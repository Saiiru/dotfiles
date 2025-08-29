---
title: Dashboard — HUD Principal (Gamified)
tags: [dashboard, kora, hud]
cssclasses: [daily]
---

# 🚀 HUD Principal

- [[00 - Maps of Content/home|🏠 Home]]
- [[01 - Projects/Projects Index|📂 Projects]]
- [[02 - Areas/Hardware Lab|🧰 Hardware]]
- [[02 - Areas/Fitness/Batman-Nightwing-Workout|🥷 Workout]]
- [[02 - Areas/Nutrition|🍽️ Nutrition]]
- [[Sairu/Neovim-Setup|🧠 Neovim Study Setup]]
- [[03 - Resources/RPG/README|🎲 RPG D&D]]
- [[99 - Meta/Architecture/IT-Architecture-Blueprint|🏛️ IT Architecture]]

---

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

### XP by Project (from Tasks frontmatter)
```dataviewjs
// Sum XP by project from tasks converted notes (frontmatter xp)
const pages = dv.pages('"01 - Projects"').where(p => p.file.tasks);
const map = new Map();
for (const p of pages) {
  for (const t of p.file.tasks) {
    const m = t.text.match(/\[xp:(\d+)\]/i);
    if (m) {
      const xp = Number(m[1]);
      const proj = p.file.folder.split("/").slice(-1)[0] || "General";
      map.set(proj, (map.get(proj) || 0) + xp);
    }
  }
}
dv.table(["Project","XP"], Array.from(map.entries()).map(([k,v]) => [k,v]).sort((a,b)=>b[1]-a[1]));
```

---

## 🧪 Lab Queue (ESP32 / Pi / Experiments)
```dataview
TABLE status, priority, due
FROM "01 - Projects" OR "02 - Areas/Hardware*" OR "04 - Permanent"
WHERE contains(tags, "hardware") OR contains(tags, "experiment")
SORT priority desc, due asc
```

---

## 🎲 RPG Quick Links
- Characters: ```dataview
LIST FROM "03 - Resources/RPG" WHERE contains(tags,"rpg/character")
```
- Sessions: ```dataview
LIST FROM "03 - Resources/RPG" WHERE contains(tags,"rpg/session")
```
- Quests: ```dataview
LIST FROM "03 - Resources/RPG" WHERE contains(tags,"rpg/quest")
```

---

## 📈 Study / Neovim Courses — Next
```dataview
TASK FROM "01 - Projects" OR "02 - Areas"
WHERE !completed AND contains(text,"#study") 
SORT due asc
```