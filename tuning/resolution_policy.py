"""Validate offline evidence and emit the C++ resolution metadata selector.

No GPU calls, Torch imports, benchmarking, algorithm knobs or legacy policies.
An anchor records a measured configuration, not an invented global winner.
Clamping selects metadata only; actual geometry and admission are independent.
"""
from __future__ import annotations
import hashlib
import json
from pathlib import Path

BOUNDS = dict(width_min=1280, width_max=3840, height_min=720, height_max=2160)
DISTANCE = 'normalized_squared_2d_lower_width_height_config_ties'
PRECISIONS = {'fp8': 0, 'fp16': 1}
RESOLVER_VERSION = 'domain_then_same_family_measured_extrema_v1'

def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'), allow_nan=False)

def require(condition, message):
    if not condition:
        raise ValueError(message)

def integer(value, name, minimum=0):
    require(type(value) is int and minimum <= value <= 2147483647,
            name+' must be a bounded integer')
    return value

def digest(value, name):
    require(isinstance(value, str) and len(value)==64 and
            all(c in '0123456789abcdef' for c in value), name+' must be a SHA256')

def key(row):
    return (row['sm'], row['precision'], row['width'], row['height'])

def validate(policy):
    required={'schema_version','bounds','distance','unmeasured_config_id','anchors','admissions'}
    require(set(policy) in (required,required|{'device_sm'}), 'unexpected policy fields')
    if 'device_sm' in policy:integer(policy['device_sm'],'device_sm',1)
    require(type(policy['schema_version']) is int and policy['schema_version']==1, 'schema version')
    require(policy['bounds']==BOUNDS and all(type(v) is int for v in policy['bounds'].values()), 'fixed inclusive domain bounds')
    require(policy['distance']==DISTANCE, 'distance rule')
    require(type(policy['unmeasured_config_id']) is int and policy['unmeasured_config_id']==-1, 'unmeasured must be -1')
    contexts, configurations = {}, {}
    for collection in ('anchors','admissions'):
        rows = policy[collection]
        require(type(rows) is list, collection+' must be a list')
        seen = set()
        for row in rows:
            require(type(row) is dict, 'row must be an object')
            common = {'sm','precision','width','height','receipt','receipt_sha256'}
            extra = {'config_id','configuration_sha256','interval','binary_sha256','source_sha256','median_ns','samples','verified'} if collection=='anchors' else {'state'}
            require(set(row)==common|extra, 'unexpected '+collection+' fields')
            integer(row['sm'],'sm',1)
            require('device_sm' not in policy or row['sm']==policy['device_sm'],'row differs from per-device policy SM')
            require(row['precision'] in PRECISIONS, 'precision must be fp8 or fp16')
            integer(row['width'],'width',1); integer(row['height'],'height',1)
            require(1280 <= row['width'] <= 3840 and 720 <= row['height'] <= 2160, 'evidence outside policy domain')
            require(key(row) not in seen, 'duplicate family/resolution evidence')
            seen.add(key(row)); digest(row['receipt_sha256'],'receipt hash')
            path = row['receipt']
            require(isinstance(path,str) and path and '\\' not in path and ':' not in path
                    and not path.startswith('/') and all(p not in ('','..','.') for p in path.split('/')), 'receipt must be a safe relative path')
            if collection=='admissions':
                require(row['state'] in ('implementation_admitted','runtime_qualified'), 'explicit admission state required')
                continue
            integer(row['config_id'],'config_id'); integer(row['samples'],'samples',1)
            require(type(row['median_ns']) is int and 0 < row['median_ns'] <= 9007199254740991, 'positive finite integer median_ns required')
            require(row['verified'] is True, 'unverified measurement rejected')
            require(isinstance(row['interval'],str) and bool(row['interval'].strip()) and
                    all(32 <= ord(c) <= 126 for c in row['interval']), 'printable ASCII measurement interval required')
            for field in ('configuration_sha256','binary_sha256','source_sha256'):
                digest(row[field],field)
            family = (row['sm'],row['precision'])
            context = (row['interval'],row['binary_sha256'],row['source_sha256'])
            require(family not in contexts or contexts[family]==context, 'mixed measurement intervals or code epochs within family')
            contexts[family]=context
            config_key=family+(row['config_id'],)
            require(config_key not in configurations or configurations[config_key]==row['configuration_sha256'], 'opaque configuration ID changed meaning')
            configurations[config_key]=row['configuration_sha256']
    # Stable JSON/headers and tie ordering do not depend on input row order.
    return {**policy, 'anchors':sorted(policy['anchors'],key=lambda r:key(r)+(r['config_id'],)),
            'admissions':sorted(policy['admissions'],key=key)}

def combine(policies):
    """Merge validated device files for one C++ table, without creating anchors."""
    require(bool(policies),'at least one policy required')
    result=dict(schema_version=1,bounds=BOUNDS,distance=DISTANCE,unmeasured_config_id=-1,anchors=[],admissions=[])
    devices=set()
    for policy in policies:
        policy=validate(policy)
        if 'device_sm' in policy:
            require(policy['device_sm'] not in devices,'duplicate device policy')
            devices.add(policy['device_sm'])
        result['anchors'].extend(policy['anchors']);result['admissions'].extend(policy['admissions'])
    return validate(result)

def verify_receipts(policy, root):
    """Check actual bytes and the exact recorded row before exporting a header."""
    policy=validate(policy); root=Path(root).resolve()
    for kind in ('anchors','admissions'):
        for row in policy[kind]:
            path=(root/row['receipt']).resolve()
            require(path.is_relative_to(root), 'receipt escaped evidence root')
            raw=path.read_bytes()
            require(hashlib.sha256(raw).hexdigest()==row['receipt_sha256'],'receipt bytes changed')
            receipt=json.loads(raw)
            require(type(receipt.get('schema_version')) is int and receipt['schema_version']==1 and receipt.get('kind')==('resolution_measurement' if kind=='anchors' else 'resolution_admission'), 'wrong receipt schema/kind')
            expected={k:v for k,v in row.items() if k not in ('receipt','receipt_sha256')}
            require(receipt.get('record')==expected, 'receipt record does not match policy row')
    return policy

def version(policy):
    return hashlib.sha256(canonical(dict(resolver=RESOLVER_VERSION,policy=validate(policy))).encode()).hexdigest()

def lookup(policy, width, height, sm, precision):
    """Offline reference for the emitted C++; never an inference dispatcher."""
    policy=validate(policy)
    integer(width,'actual width',1); integer(height,'actual height',1); integer(sm,'sm',1)
    require(precision in PRECISIONS,'precision must be fp8 or fp16')
    w=min(3840,max(1280,width)); h=min(2160,max(720,height))
    admission=next((a for a in policy['admissions'] if key(a)==(sm,precision,width,height)),None)
    candidates=[a for a in policy['anchors'] if (a['sm'],a['precision'])==(sm,precision)]
    if candidates:
        # Only matching measured anchors define metadata endpoint clamps.
        w=min(max(a['width'] for a in candidates),max(min(a['width'] for a in candidates),w))
        h=min(max(a['height'] for a in candidates),max(min(a['height'] for a in candidates),h))
    anchor=min(candidates,key=lambda a:((w-a['width'])**2*1440**2+(h-a['height'])**2*2560**2,a['width'],a['height'],a['config_id'])) if candidates else None
    exact=anchor is not None and (width,height)==(anchor['width'],anchor['height'])
    return dict(config_id=anchor['config_id'] if anchor else -1,
                status='exact_measured' if exact else 'transferred' if anchor else 'unmeasured',
                actual_width=width,actual_height=height,query_width=w,query_height=h,
                clamped=(w,h)!=(width,height),actual_resolution_measured=exact,
                actual_shape_supported=admission is not None,
                runtime_qualified=admission is not None and admission['state']=='runtime_qualified',
                admission=admission,anchor=anchor,policy_version=version(policy))

def cpp_header(policy):
    """Emit validated rows; CLI verifies external receipt bytes before calling."""
    p=validate(policy); rows=[]; admissions=[]
    for a in p['anchors']:
        strings=','.join(json.dumps(a[k]) for k in ('configuration_sha256','interval','binary_sha256','source_sha256','receipt_sha256'))
        rows.append('    {'+','.join(str(a[k]) for k in ('sm',))+','+str(PRECISIONS[a['precision']])+','+','.join(str(a[k]) for k in ('width','height','config_id','median_ns','samples'))+','+strings+'}')
    for a in p['admissions']:
        admissions.append('    {'+f"{a['sm']},{PRECISIONS[a['precision']]},{a['width']},{a['height']},"+('true' if a['state']=='runtime_qualified' else 'false')+','+json.dumps(a['receipt_sha256'])+'}')
    return CPP.replace('@VERSION@',version(p)).replace('@N@',str(len(rows))).replace('@ROWS@',',\n'.join(rows)).replace('@A@',str(len(admissions))).replace('@ADMISSIONS@',',\n'.join(admissions))

CPP = r'''#pragma once
// Generated offline. Configuration transfer is not measured coverage or admission.
#include <array>
#include <cstdint>
#include <limits>

namespace dlssnr::resolution_policy
{
inline constexpr char Version[] = "@VERSION@";
inline constexpr char ResolverVersion[] = "domain_then_same_family_measured_extrema_v1";
inline constexpr int WidthMin = 1280, WidthMax = 3840, HeightMin = 720, HeightMax = 2160;
enum class EPrecision : int
{
	Fp8 = 0,
	Fp16 = 1
};
enum class EStatus : int
{
	Unmeasured = 0,
	ExactMeasured = 1,
	Transferred = 2,
	InvalidInput = 3
};

struct FAnchor
{
	int Sm, PrecisionValue, Width, Height, ConfigId;
	int64_t MedianNs;
	int Samples;
	const char *ConfigurationSha256, *Interval, *BinarySha256, *SourceSha256, *ReceiptSha256;
};

struct FAdmission
{
	int Sm, PrecisionValue, Width, Height;
	bool bRuntimeQualified;
	const char* ReceiptSha256;
};

inline constexpr std::array<FAnchor, @N@> Anchors{{
@ROWS@
}};
inline constexpr std::array<FAdmission, @A@> Admissions{{
@ADMISSIONS@
}};

struct FSelection
{
	int ConfigId = -1;
	EStatus StatusValue = EStatus::Unmeasured;
	int ActualWidth = 0, ActualHeight = 0, QueryWidth = 0, QueryHeight = 0;
	bool bClamped = false, bActualResolutionMeasured = false, bActualShapeSupported = false,
		 bRuntimeQualified = false;
	const FAnchor* AnchorEvidence = nullptr;
	const FAdmission* Admission = nullptr;
};

inline FSelection Select(int Width, int Height, int Sm, EPrecision PrecisionValue)
{
	FSelection Selection;
	Selection.ActualWidth = Width;
	Selection.ActualHeight = Height;
	const int PrecisionIndex = static_cast<int>(PrecisionValue);
	if (Width <= 0 || Height <= 0 || Sm <= 0 || PrecisionIndex < 0 || PrecisionIndex > 1)
	{
		Selection.StatusValue = EStatus::InvalidInput;
		return Selection;
	}
	Selection.QueryWidth = Width < WidthMin ? WidthMin : Width > WidthMax ? WidthMax : Width;
	Selection.QueryHeight = Height < HeightMin ? HeightMin : Height > HeightMax ? HeightMax : Height;
	// Measured extrema are family-local and affect metadata only.
	int MeasuredWidthMin = WidthMax, MeasuredWidthMax = WidthMin, MeasuredHeightMin = HeightMax, MeasuredHeightMax = HeightMin;
	bool bMeasuredFamily = false;
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		bMeasuredFamily = true;
		if (EvidenceRow.Width < MeasuredWidthMin)
			MeasuredWidthMin = EvidenceRow.Width;
		if (EvidenceRow.Width > MeasuredWidthMax)
			MeasuredWidthMax = EvidenceRow.Width;
		if (EvidenceRow.Height < MeasuredHeightMin)
			MeasuredHeightMin = EvidenceRow.Height;
		if (EvidenceRow.Height > MeasuredHeightMax)
			MeasuredHeightMax = EvidenceRow.Height;
	}
	if (bMeasuredFamily)
	{
		Selection.QueryWidth = Selection.QueryWidth < MeasuredWidthMin ? MeasuredWidthMin : Selection.QueryWidth > MeasuredWidthMax ? MeasuredWidthMax : Selection.QueryWidth;
		Selection.QueryHeight = Selection.QueryHeight < MeasuredHeightMin	? MeasuredHeightMin
							 : Selection.QueryHeight > MeasuredHeightMax ? MeasuredHeightMax
														: Selection.QueryHeight;
	}
	Selection.bClamped = Selection.QueryWidth != Width || Selection.QueryHeight != Height;
	// Exact actual dimensions only. Clamped coordinates never grant admission.
	for (const auto& EvidenceRow : Admissions)
		if (EvidenceRow.Sm == Sm && EvidenceRow.PrecisionValue == PrecisionIndex &&
			EvidenceRow.Width == Width && EvidenceRow.Height == Height)
		{
			Selection.Admission = &EvidenceRow;
			Selection.bActualShapeSupported = true;
			Selection.bRuntimeQualified = EvidenceRow.bRuntimeQualified;
			break;
		}
	int64_t NearestDistanceSquared = std::numeric_limits<int64_t>::max();
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		const int64_t WidthDelta = int64_t(Selection.QueryWidth) - EvidenceRow.Width,
					  HeightDelta = int64_t(Selection.QueryHeight) - EvidenceRow.Height;
		const int64_t DistanceSquared = WidthDelta * WidthDelta * 1440LL * 1440LL + HeightDelta * HeightDelta * 2560LL * 2560LL;
		// Generated rows are sorted by width, height, configuration within family.
		if (DistanceSquared < NearestDistanceSquared)
		{
			NearestDistanceSquared = DistanceSquared;
			Selection.AnchorEvidence = &EvidenceRow;
		}
	}
	if (Selection.AnchorEvidence)
	{
		Selection.ConfigId = Selection.AnchorEvidence->ConfigId;
		Selection.bActualResolutionMeasured =
			Selection.AnchorEvidence->Width == Width && Selection.AnchorEvidence->Height == Height;
		Selection.StatusValue = Selection.bActualResolutionMeasured ? EStatus::ExactMeasured : EStatus::Transferred;
	}
	return Selection;
}
} // namespace dlssnr::resolution_policy
'''
