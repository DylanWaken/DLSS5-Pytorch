"""Source-backed encoder, decoder and endpoint tensor-flow diagrams."""
try:
    from .architecture_flow import Flow
except ImportError:
    from architecture_flow import Flow


def _table(d, x, y, widths, headers, rows, title):
    d.text(x, y, title, 20, bold=True)
    for column, value in enumerate(headers):
        d.text(x + sum(widths[:column]), y + 37, value, 17, bold=True)
    for row_index, row in enumerate(rows):
        for column, value in enumerate(row):
            d.text(x + sum(widths[:column]), y + 72 + row_index * 35, value, 17)


def encoder():
    d = Flow('encoder', 'Encoder: one tail, two distinct paths',
             'H × W × C notation · pool the raw tail; retain its published value for the decoder', 1240)
    d.tensor('input', 35, 130, 260, 'Level input', ['H × W × C', 'Example: 272 × 480 × 128'])
    d.op('leading', 355, 130, 340, 'Leading window blocks', ['Branched FFN → Window attention', 'C128 example: blocks 9–13'])
    d.op('tail', 760, 130, 405, 'Tail window block', ['Branched FFN → Window attention', 'C128 example: block 14'])
    d.link('input', 'leading', start='right', end='left')
    d.link('leading', 'tail', start='right', end='left')
    d.tensor('raw', 790, 280, 360, 'Raw tail R', ['H × W × C', 'Before output publication'])
    d.link('tail', 'raw')
    d.op('publish_skip', 350, 430, 325, 'Publish R', ['Working-precision boundary'], kind='skip')
    d.op('pool', 790, 430, 360, '2 × 2 mean pool', ['H/2 × W/2 × C', '136 × 240 × 128 in example'])
    d.link('raw', 'publish_skip', via=((970, 398), (512.5, 398)), kind='skip')
    d.link('raw', 'pool')
    d.tensor('skip', 350, 580, 325, 'Saved encoder skip', ['H × W × C', 'Example: block 14 → 56'])
    d.link('publish_skip', 'skip', kind='skip')
    d.op('pad', 790, 580, 360, 'Pad to next field', ['H′ × W′ × C', 'H′, W′ = align4(ceil(size/2))'])
    d.link('pool', 'pad')
    d.op('project', 790, 730, 360, 'Channel projection C → 2C', ['Learned per-pixel matrix', 'H′ × W′ × 2C'])
    d.link('pad', 'project', label='Publish pooled values', label_at=(803, 706))
    d.op('next', 790, 880, 360, 'Publish projected state', ['Next encoder level', '136 × 240 × 256 in example'])
    d.link('project', 'next')
    _table(d, 35, 750, (165, 95, 205), ('Encoder blocks', 'C', 'Saved skip →', 'Next C'),
           (('1–4', '32', '4 → 66', '64'), ('5–8', '64', '8 → 62', '128'),
            ('9–14', '128', '14 → 56', '256'), ('15–22', '256', '22 → 48', '512'),
            ('23–30', '512', '30 → 39', '1024')), 'Same dependency at all five levels')
    d.note(35, 1030, ['FFN variants by C: 32 Dense; 64 / 128 / 256 Branched; 512 Grouped. All use Window attention.',
                     '4K C128 tail: 272 × 480 × 128 → pool 136 × 240 × 128 → project 136 × 240 × 256.',
                     'The retained skip keeps the high-resolution field, before pooling and channel projection.'])
    d.note(35, 1140, ['Pool averages in FP32, casts back, pads, then publishes. The projection is published again.',
                     'Source: DLSSNR._encoder_stage, Numerics.pool and Geometry.levels.'])
    d.save()
    return d


def decoder():
    d = Flow('decoder', 'Decoder: project, resize, then merge the encoder skip',
             'H × W × C notation · restore a recorded target field before ordinary window blocks resume', 1360)
    d.tensor('low', 35, 130, 300, 'Lower-resolution state', ['Hℓ × Wℓ × 2C'], h=89)
    d.op('project', 420, 130, 325, 'Channel projection 2C → C', ['Learned per-pixel matrix', 'Hℓ × Wℓ × C'])
    d.op('resize', 830, 130, 335, 'Nearest upsample ×2', ['Repeat rows and columns', '2Hℓ × 2Wℓ × C'])
    d.link('low', 'project', start='right', end='left')
    d.link('project', 'resize', start='right', end='left')
    d.op('crop', 830, 295, 335, 'Crop to target field', ['Ht × Wt × C', 'From Geometry.levels'])
    d.link('resize', 'crop')
    d.tensor('skip', 35, 305, 300, 'Encoder skip', ['Ht × Wt × C', 'Published encoder tail'])
    d.op('scale', 420, 305, 325, 'Scale encoder skip', ['transition_scale ⊙ skip', 'One learned value / channel'], kind='skip')
    d.link('skip', 'scale', start='right', end='left', kind='skip')
    d.add('merge', 650, 485)
    d.link('crop', 'merge', end='right', via=((997.5, 485),))
    d.link('scale', 'merge', end='left', via=((582.5, 485),), kind='skip')
    d.tensor('raw', 490, 555, 320, 'Raw merged state', ['U + scale ⊙ encoder skip', 'Ht × Wt × C'])
    d.link('merge', 'raw')
    d.op('publish', 490, 700, 320, 'Publish merged state', ['Ht × Wt × C'])
    d.link('raw', 'publish')
    d.op('first', 490, 835, 320, 'First window block', ['40 / 48 / 56 / 62 / 66', 'FFN → Window attention'])
    d.link('publish', 'first')
    d.op('remaining', 875, 835, 290, 'Remaining blocks', ['FFN → Window attention', 'Published Ht × Wt × C'])
    d.link('first', 'remaining', start='right', end='left')
    d.link('raw', 'first', start='left', end='left', via=((430, 599.5), (430, 879.5)), kind='skip')
    d.note(35, 695, ['Block66 only:', 'Raw merge bypasses publication', 'for its first FFN residual.',
                    'Other levels use the published', 'merged state as that residual.'], kind='skip')
    d.note(35, 955, 'Block39 is transition-only: it ends at publication; block40 is the next ordinary window block.')
    _table(d, 35, 1010, (190, 155, 210, 200),
           ('Transition', 'Target C', 'Encoder skip', 'First block', 'Remaining blocks'),
           (('39', '512', '30', '40', '41–47'), ('48', '256', '22', '48', '49–55'),
            ('56', '128', '14', '56', '57–61'), ('62', '64', '8', '62', '63–65'),
            ('66', '32', '4', '66', '67–69')), 'Weights and record ownership')
    d.note(35, 1270, ['FFN variants by C: 32 Dense; 64 / 128 / 256 Branched; 512 Grouped. Record 39 has no FFN or attention.',
                     'Source: _decoder_stage, _bottleneck_stage and Numerics.upsample_residual.'])
    d.save()
    return d


def input_stage():
    d = Flow('input_stage', 'Input stage: raw adapter residual and two block0 outputs',
             'H × W × C notation · Hp,Wp are padded full-field dimensions; H0,W0 are encoder level0 dimensions', 945)
    d.tensor('features', 40, 155, 280, 'Caller-provided features', ['Hp × Wp × 16', 'FP32 or BF16 training input'])
    d.op('adapter', 385, 155, 320, 'Input adapter 16 → 32', ['Learned per-pixel matrix', 'Hp × Wp × 32'])
    d.tensor('raw_adapter', 860, 155, 300, 'Raw adapter A', ['Hp × Wp × 32'], h=89)
    d.link('features', 'adapter', start='right', end='left')
    d.link('adapter', 'raw_adapter', start='right', end='left')
    d.op('publish_adapter', 860, 305, 300, 'Publish A', ['Working-precision boundary'])
    d.op('block0', 385, 305, 320, 'Window block0 · C32', ['Dense FFN → Window attention', 'FFN residual uses raw A'])
    d.link('raw_adapter', 'publish_adapter')
    d.link('publish_adapter', 'block0', start='left', end='right', via=((790, 338), (790, 349.5)))
    d.link('raw_adapter', 'block0', start='bottom', end='top',
           via=((1010, 275), (545, 275)), kind='skip', label='Raw adapter residual', label_at=(572, 262))
    d.tensor('raw0', 385, 460, 320, 'Raw block0 result', ['Hp × Wp × 32'])
    d.link('block0', 'raw0')
    d.op('publish0', 860, 460, 300, 'Publish block0 result', ['Hp × Wp × 32'], kind='skip')
    d.link('raw0', 'publish0', start='right', end='left', kind='skip')
    d.tensor('saved0', 860, 610, 300, 'Retain block0 skip', ['Hp × Wp × 32', 'Used only at output merge'])
    d.link('publish0', 'saved0', kind='skip')
    d.op('pool0', 70, 610, 355, '2 × 2 mean pool + pad', ['Raw result → H0 × W0 × 32', 'Publish; no channel projection'])
    d.link('raw0', 'pool0', via=((545, 565), (247.5, 565)))
    d.tensor('input1', 70, 755, 355, 'Encoder input · block1', ['H0 × W0 × 32'])
    d.link('pool0', 'input1')
    d.note(480, 770, ['4K padded field: 2176 × 3840.', 'Level0 field: 1088 × 1920.',
                     'The two block0 outputs are distinct values.'])
    d.note(35, 890, 'Source: _input_block, _input_stage and Numerics.pool. Retain the block0 skip for output70.')
    d.save()
    return d


def output_stage():
    d = Flow('output_stage', 'Output stage: two scaled paths meet before block70',
             'H × W × C notation · retain the published block0 skip; block70 uses the raw merge as a residual', 1150)
    d.tensor('state69', 35, 130, 300, 'Published block69 state', ['H0 × W0 × 32'], h=89)
    d.op('upsample69', 420, 130, 325, 'Repeat ×2, then crop', ['Hp × Wp × 32', 'No channel projection here'])
    d.op('scale_input', 840, 130, 320, 'Scale resized state', ['input_scale ⊙ upsample', 'Learned channelwise scale'])
    d.link('state69', 'upsample69', start='right', end='left')
    d.link('upsample69', 'scale_input', start='right', end='left')
    d.tensor('saved0', 35, 310, 300, 'Retained block0 skip', ['Hp × Wp × 32', 'From the input stage'])
    d.op('scale_adapter', 420, 310, 325, 'Scale retained block0 skip', ['adapter_scale ⊙ block0', 'Separate learned scale'], kind='skip')
    d.link('saved0', 'scale_adapter', start='right', end='left', kind='skip')
    d.add('merge70', 985, 445)
    d.link('scale_input', 'merge70')
    d.link('scale_adapter', 'merge70', start='right', end='left', via=((790, 354.5), (790, 445)), kind='skip')
    d.tensor('raw70', 815, 515, 345, 'Raw full-field merge M', ['Hp × Wp × 32'])
    d.link('merge70', 'raw70')
    d.op('publish70', 815, 660, 345, 'Publish M', ['Block70 input state'])
    d.op('block70', 400, 660, 330, 'Window block70 · C32', ['Dense FFN → Window attention', 'FFN residual uses raw M'])
    d.link('raw70', 'publish70')
    d.link('publish70', 'block70', start='left', end='right', via=((775, 693), (775, 704.5)))
    d.link('raw70', 'block70', start='left', end='top', via=((565, 548),), kind='skip')
    d.note(420, 615, 'Raw merge residual', kind='skip')
    d.op('head', 400, 820, 330, 'Head projection 32 → 4', ['Consumes raw block70 result', 'FP32 four-channel head'])
    d.link('block70', 'head')
    d.op('crop', 35, 820, 300, 'Optional valid-size crop', ['Hp × Wp → Hv × Wv'])
    d.link('head', 'crop', start='left', end='right', via=((367, 864.5), (367, 853)))
    d.tensor('result', 35, 965, 300, 'Model output', ['Hv × Wv × 4 if cropped', 'Hp × Wp × 4 otherwise'])
    d.link('crop', 'result')
    d.note(805, 835, ['4K example:', 'Level0: 1088 × 1920 × 32', 'Full field: 2176 × 3840 × 32', 'Cropped head: 2160 × 3840 × 4'])
    d.note(400, 990, ['The head uses the raw attention result.', 'The published block70 value is only', 'returned as an optional boundary.'])
    d.note(35, 1093, 'Source: _post_head and Numerics.upsample_residual. Optional compose() consumes this head afterward.')
    d.save()
    return d


def render():
    return [encoder(), decoder(), input_stage(), output_stage()]


if __name__ == '__main__':
    render()
