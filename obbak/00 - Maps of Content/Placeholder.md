---
title: Dashboard — HUD Principal (Gamified)
tags: [dashboard, kora, hud]
cssclasses: [daily]
---

# 🚀 HUD Principal

- [[00 - Maps of Content/home|🏠 Home]]
- [[01 - Projects/Projects Index|📂 Projects]]
- [[01 - Projects/DAEDALUS - Core Project|🧠 DAEDALUS]]
- [[02 - Areas/Fitness/Batman-Nightwing-Workout|🥷 Workout]]
- [[02 - Areas/Fitness/Shoulder-Care-and-Mobility|🦸 Shoulder Care]]
- [[Sairu/Neovim-Setup|🧠 Neovim Study Setup]]
- [[03 - Resources/RPG/README|🎲 RPG D&D]]
- [[99 - Meta/Architecture/IT-Architecture-Blueprint|🏛️ IT Architecture]]

---

## 🎯 Hábitos do Dia
```dataviewjs
// Somas de hoje a partir de tasks CONCLUÍDAS com tokens
const isToday = d =%3E d && dv.date(d).toFormat('yyyy-LL-dd') === dv.date('today').toFormat('yyyy-LL-dd');
const pages = dv.pages().where(p => p.file.tasks && p.file.tasks.length);
let studyMin=0, mobMin=0, relaxMin=0;
let didShoulder=false, didStrength=false, didSkill=false;

for (const p of pages) {
  for (const t of p.file.tasks) {
    if (!t.completed || !isToday(t.completion)) continue;
    const text = t.text;
    const m = (re) => (text.match(re)||[])[1];
    const mi = (re) => { const v = m(re); return v ? Number(v) : 0; };
    studyMin += mi(/\[study:(\d+)m\]/i);
    mobMin   += mi(/\[mobility:(\d+)m\]/i);
    relaxMin += mi(/\[relax:(\d+)m\]/i);
    if (/\[shoulder:session\]/i.test(text)) didShoulder = true;
    if (/\[strength:session\]/i.test(text)) didStrength = true;
    if (/\[parkour:skill\]/i.test(text)) didSkill = true;
  }
}

const goalStudy = 120, goalMob = 20, goalRelax = 10;
const pct = (v,g)=> Math.min(100, Math.round(100*v/g));

function bar(label, val, goal){
  const p = pct(val, goal);
  const cls = p>=100?'':'';
  const state = p>=100?'':'';
  const c = p%3C50?'danger':(p<100?'warn':'');
  dv.el('div', `
  <div class="hud-card">
    <div class="hud-row" style="justify-content:space-between;">
      <div><strong>${label}</strong> — ${val}m / ${goal}m</div>
      <div class="hud-pill">${p}%</div>
    </div>
    <div class="progress ${c}"><div class="bar" style="width:${p}%"></div></div>
  </div>`);
}
bar('Estudo', studyMin, goalStudy);
bar('Mobilidade', mobMin, goalMob);
bar('Relax', relaxMin, goalRelax);

dv.el('div', `
  <div class="hud-card">
    <div class="hud-row" style="gap:8px;">
      <span class="hud-pill" style="border-color:${didShoulder?'#7bf1a8':'#ff9a9a'};color:${didShoulder?'#7bf1a8':'#ff9a9a'}">Shoulder ${didShoulder?'✓':'•'}</span>
      <span class="hud-pill" style="border-color:${didStrength?'#7bf1a8':'#ff9a9a'};color:${didStrength?'#7bf1a8':'#ff9a9a'}">Força ${didStrength?'✓':'•'}</span>
      <span class="hud-pill" style="border-color:${didSkill?'#7bf1a8':'#ff9a9a'};color:${didSkill?'#7bf1a8':'#ff9a9a'}">Skill ${didSkill?'✓':'•'}</span>
    </div>
  </div>
`);
```

## 📅 Today — Dailies
```dataview
TABLE file.link as Daily, xp_today, tasks_completed, gold_today
FROM "06 - Daily"
WHERE date(file.name) = date(today)
SORT file.name desc
```

## ✅ Tasks (Not Done, Next 7 days)
```dataview
TASK FROM "01 - Projects" OR "02 - Areas"
WHERE !completed AND (due <= date(today) + dur(7 days) OR due = null)
SORT priority desc, due asc
```

## 🏆 Gamification — XP Board (Last 14 days)
```dataview
TABLE sum(xp_today) AS "XP", sum(tasks_completed) AS "Tasks", sum(gold_today) AS "Gold"
FROM "06 - Daily"
WHERE file.cday >= date(today) - dur(14 days)
GROUP BY "Last 14 days"
```

### XP by Project
```dataviewjs
const pages = dv.pages('"01 - Projects"').where(p => p.file.tasks);
const map = new Map();
for (const p of pages) {
  for (const t of p.file.tasks) {
    const m = t.text.match(/\[xp:(\d+)\]/i);
    if (m) {
      const xp = Number(m[1]);
      const proj = p.project || p.file.folder.split("/").slice(-1)[0] || "General";
      map.set(proj, (map.get(proj) || 0) + xp);
    }
  }
}
dv.table(["Project","XP"], Array.from(map.entries()).map(([k,v]) => [k,v]).sort((a,b)=>b[1]-a[1]));
```>)