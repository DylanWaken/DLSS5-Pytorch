'use strict';
document.querySelectorAll('.copy-code').forEach(button => button.addEventListener('click', async () => {
  const block = button.closest('.source').querySelector('code').cloneNode(true);
  block.querySelectorAll('.ln').forEach(n => n.remove());
  try { await navigator.clipboard.writeText(block.textContent); button.textContent = 'Copied'; }
  catch { button.textContent = 'Select code to copy'; }
}));
const sourceToggle = document.querySelector('#toggle-code');
if (sourceToggle) sourceToggle.addEventListener('click', () => {
  const blocks = [...document.querySelectorAll('details.source')];
  const open = blocks.some(d => !d.open);
  blocks.forEach(d => d.open = open);
  sourceToggle.textContent = open ? 'Collapse code' : 'Expand code';
});
const filter = document.querySelector('#kernel-filter');
if (filter) filter.addEventListener('input', () => {
  const terms = filter.value.toLowerCase().trim().split(/\s+/);
  let shown = 0;
  document.querySelectorAll('.inventory tbody tr').forEach(row => {
    const match = terms.every(t => row.textContent.toLowerCase().includes(t));
    row.hidden = !match;
    if (match) shown++;
  });
  document.querySelector('#filter-count').textContent = `${shown} of 81 public entries shown`;
});
const explorer = document.querySelector('#lane-explorer');
if (explorer) {
  const laneInput = document.querySelector('#lane-input'), tileInput = document.querySelector('#tile-input'), precisionInput = document.querySelector('#precision-input');
  const render = () => {
    const lane = Math.max(0, Math.min(31, Math.trunc(Number(laneInput.value) || 0)));
    const tile = Math.max(0, Math.min(1023, Math.trunc(Number(tileInput.value) || 0)));
    const fp8 = precisionInput.value === 'fp8', bytes = fp8 ? 512 : 1024;
    const row = lane >> 2, col = (lane & 3) * 2, offset = tile * bytes + lane * 16;
    document.querySelector('#lane-result').textContent = `${fp8 ? 'FP8' : 'FP16'}, tile ${tile}, lane ${lane}: byte offset ${offset}${fp8 ? '' : ` (chunk 0), ${offset + 512} (chunk 1)`}. Output rows ${row} and ${row+8}; channel pairs ${[0,8,16,24].map(c => `${c+col}–${c+col+1}`).join(', ')}.`;
    const ns = 'http://www.w3.org/2000/svg', grid = document.querySelector('#lane-grid');
    grid.replaceChildren();
    const add = (tag, attrs, text) => { const n=document.createElementNS(ns,tag); Object.entries(attrs).forEach(([k,v])=>n.setAttribute(k,v)); if(text)n.textContent=text; grid.append(n); };
    add('title',{},`Lane ${lane} owns rows ${row} and ${row+8}, columns ${col} and ${col+1} of one m16n8 accumulator.`);
    for(let r=0;r<16;r++)for(let c=0;c<8;c++) {
      const active=(r===row||r===row+8)&&(c===col||c===col+1);
      add('rect',{x:40+c*26,y:10+r*15,width:24,height:13,fill:active?'#147d78':'#d1e4df',rx:2});
    }
    add('text',{x:295,y:70,'font-size':20},`Lane ${lane} · m16n8 output`);
    add('text',{x:295,y:108,'font-size':16},`Word 0 → row ${row}, columns ${col} and ${col+1}`);
    add('text',{x:295,y:138,'font-size':16},`Word 1 → row ${row+8}, columns ${col} and ${col+1}`);
    add('text',{x:295,y:188,'font-size':14},'Each colored cell is one Half accumulator.');
    add('text',{x:295,y:215,'font-size':14},'The other 31 lanes own all remaining cells.');
  };
  [laneInput,tileInput,precisionInput].forEach(input=>input.addEventListener('input',render));
  render();
}
