'use strict';
// One shared tooltip; links remain useful without JavaScript and on touch screens.
const glossaryTerms = document.querySelectorAll('.glossary-term');
if (glossaryTerms.length) {
  const tip = document.createElement('div');
  tip.id = 'glossary-tooltip';
  tip.className = 'glossary-tooltip';
  tip.setAttribute('role', 'tooltip');
  tip.hidden = true;
  document.body.append(tip);
  let active = null, hideTimer = null;
  const cancelHide = () => { clearTimeout(hideTimer); };
  const hide = () => {
    cancelHide();
    if (active) active.removeAttribute('aria-describedby');
    active = null;
    tip.hidden = true;
  };
  const position = () => {
    if (!active) return;
    const rect = active.getBoundingClientRect();
    const margin = 12, gap = 8;
    const width = tip.offsetWidth, height = tip.offsetHeight;
    tip.style.left = `${Math.max(margin, Math.min(rect.left, window.innerWidth - width - margin))}px`;
    const below = rect.bottom + gap;
    const top = below + height <= window.innerHeight - margin ? below : rect.top - height - gap;
    tip.style.top = `${Math.max(margin, Math.min(top, window.innerHeight - height - margin))}px`;
  };
  const show = term => {
    cancelHide();
    if (active && active !== term) active.removeAttribute('aria-describedby');
    active = term;
    const title = document.createElement('strong');
    title.textContent = term.dataset.term;
    const definition = document.createElement('p');
    definition.textContent = term.dataset.definition;
    const hint = document.createElement('small');
    hint.textContent = 'Follow the term link for more context · Esc to dismiss';
    tip.replaceChildren(title, definition, hint);
    tip.hidden = false;
    term.setAttribute('aria-describedby', tip.id);
    position();
  };
  const scheduleHide = () => {
    cancelHide();
    hideTimer = setTimeout(() => {
      if (active && (active.matches(':hover') || document.activeElement === active || tip.matches(':hover'))) return;
      hide();
    }, 180);
  };
  glossaryTerms.forEach(term => {
    term.addEventListener('pointerenter', event => { if (event.pointerType !== 'touch') show(term); });
    term.addEventListener('pointerleave', scheduleHide);
    term.addEventListener('focus', () => show(term));
    term.addEventListener('blur', scheduleHide);
    term.addEventListener('click', hide);
  });
  tip.addEventListener('pointerenter', cancelHide);
  tip.addEventListener('pointerleave', scheduleHide);
  document.addEventListener('keydown', event => { if (event.key === 'Escape') hide(); });
  window.addEventListener('resize', position);
  document.addEventListener('scroll', event => {
    if (event.target !== tip && !tip.contains(event.target)) hide();
  }, true);
}

document.querySelectorAll('.copy-code').forEach(button => button.addEventListener('click', async () => {
  const block = button.closest('.source').querySelector('code').cloneNode(true);
  block.querySelectorAll('.ln').forEach(n => n.remove());
  try { await navigator.clipboard.writeText(block.textContent); button.textContent = 'Copied'; }
  catch { button.textContent = 'Select code to copy'; }
}));
const sourceToggle = document.querySelector('#toggle-code');
if (sourceToggle) sourceToggle.addEventListener('click', () => {
  const blocks = [...document.querySelectorAll('details.source')];
  const open = !blocks.some(d => d.open);
  blocks.forEach(d => d.open = open);
  sourceToggle.textContent = open ? 'Collapse code' : 'Expand code';
});
const filter = document.querySelector('#kernel-filter');
if (filter) {
 const applyFilter = () => {
  const terms = filter.value.toLowerCase().trim().split(/\s+/);
  const catalog = document.querySelector('.kernel-catalog');
  if (catalog) {
    const rows = [...catalog.querySelectorAll('.kernel-role')];
    let shown = 0, lessons = 0;
    rows.forEach(row => {
      const haystack = `${row.dataset.search} ${row.textContent}`.toLowerCase();
      row.hidden = !terms.every(t => haystack.includes(t));
      if (!row.hidden) { shown++; lessons += Number(row.dataset.lessons); }
    });
    catalog.querySelectorAll('[data-catalog-group]').forEach(group => {
      group.hidden = ![...group.querySelectorAll('.kernel-role')].some(row => !row.hidden);
    });
    document.querySelector('#filter-count').textContent = `${shown} of ${rows.length} kernel roles · ${lessons} of 83 lessons shown`;
    document.querySelector('#catalog-empty').hidden = shown !== 0;
    document.querySelectorAll('.operator-jumps a').forEach(link => {
      const group = document.querySelector(link.getAttribute('href')).closest('.operator-group');
      link.hidden = group.hidden;
    });
    return;
  }
  let shown = 0;
  document.querySelectorAll('.inventory tbody tr').forEach(row => {
    const match = terms.every(t => row.textContent.toLowerCase().includes(t));
    row.hidden = !match;
    if (match) shown++;
  });
  const total = document.querySelectorAll('.inventory tbody tr').length;
  document.querySelector('#filter-count').textContent = `${shown} of ${total} ${total === 41 ? 'kernel roles' : 'public entries'} shown`;
 };
 filter.addEventListener('input', applyFilter);
 applyFilter();
}
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
