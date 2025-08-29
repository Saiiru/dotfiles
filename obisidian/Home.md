---
title: Sairu Battlemage HUD
cssclasses: sl-hud-root
banner: "![[99 - Meta/02 - images/Images/banner.png]]"
---

<div class="sl-hud-root">

<!-- ==== PLAYER CARD ==== -->
<div class="sl-card">
  <div class="sl-title">PLAYER STATUS</div>
  <div class="sl-class">BATTLEMAGE • BLADESINGER</div>
  <div class="sl-level">Lv. 25</div>
  <div class="sl-stats-grid">
    <div class="sl-stat">445 <span class="sl-stat-label">Attack</span></div>
    <div class="sl-stat">155 <span class="sl-stat-label">Defense</span></div>
    <div class="sl-stat">650 <span class="sl-stat-label">Health</span></div>
    <div class="sl-stat">420 <span class="sl-stat-label">Mana</span></div>
    <div class="sl-stat">97 <span class="sl-stat-label">Agility</span></div>
    <div class="sl-stat">110 <span class="sl-stat-label">Perception</span></div>
  </div>
  <div class="sl-xpbar">
    <div class="sl-xpfill" style="width: 47%"></div>
  </div>
  <div style="text-align:center; color:var(--sl-xp); font-family:var(--sl-font-mage); margin-top:2px;">
    3470 / 7350 XP
  </div>
  <hr>
  <b>Rank:</b> E • <b>Guild:</b> Solo Operators • <b>Streak:</b> 12d
</div>

<!-- ==== QUEST CARD ==== -->
<div class="sl-card">
  <div class="sl-title">ACTIVE QUEST</div>
  <div class="sl-quest">[Conquer the Arcane Dungeon]</div>
  <div class="sl-quest-status incomplete">Incomplete</div>
  <div class="sl-quest-objectives">
    <div>Runes Collected <span>[7/10]</span></div>
    <div>Bosses Defeated <span>[1/3]</span></div>
    <div>Mana Used <span>[1200/2000]</span></div>
  </div>
  <div class="sl-warning">Penalty on failure: <b>Stamina -10%</b>, <b>XP Loss</b></div>
  <button class="sl-btn">COMPLETE QUEST</button>
</div>

<!-- ==== GOALS CARD ==== -->
<div class="sl-card">
  <div class="sl-title">LIFE GOALS</div>
  ```dataviewjs
  let goals = dv.pages('"08 - Review/Goals"');
  dv.table(
    ["Goal", "Progress", "Deadline"],
    goals.map(goal => [
      `<span style="font-size:1.1em">${goal.file.link}</span>`,
      `<progress value="${goal.progress}" max="${goal.target}"></progress>
       <br>${Math.round((goal.progress / goal.target) * 100)}%`,
      goal.deadline
    ])
  );
  ```
</div>

<!-- ==== BOOK TRACKER CARD ==== -->
<div class="sl-card">
  <div class="sl-title">BOOK TRACKER</div>
  ```dataviewjs
  let books = dv.pages("#book");
  dv.table(
    ["Cover", "Book", "Author", "Status"],
    books.map(book => [
      book.cover ? `![|100](${book.cover})` : "",
      book.file.link,
      book.author ?? "",
      book.status ?? ""
    ])
  );
  ```
  <hr>
  <b>Lidos:</b> `=dv.pages("#book").where(b => b.status && b.status.toLowerCase()=="completed").length` /
  <b>Total:</b> `=dv.pages("#book").length`
</div>

<!-- ==== HABITS CARD ==== -->
<div class="sl-card">
  <div class="sl-title">HABITS & DAILY</div>
  ```dataviewjs
  let habits = dv.pages('"06 - Daily"').sort(p => p.file.day, "desc").limit(5);
  dv.table(
    ["Day", "Writing", "Workout", "Reading"],
    habits.map(h => [
      h.file.link,
      h.Writing ? "✅" : "❌",
      h.Workout ? "✅" : "❌",
      h.Reading ? "✅" : "❌"
    ])
  );
  ```
</div>

<!-- ==== METRICS CARD ==== -->
<div class="sl-card">
  <div class="sl-title">SYSTEM METRICS</div>
  ```dataviewjs
  const totalNotes = dv.pages().length;
  const completedTasks = dv.pages().file.tasks.where(t => t.completed).length;
  const pendingTasks = dv.pages().file.tasks.where(t => !t.completed).length;
  dv.table(
    ["Metric", "Value"],
    [
      ["Notes", totalNotes],
      ["Tasks Done", completedTasks],
      ["Tasks Pending", pendingTasks]
    ]
  );
  ```
  <hr>
  <div><b>Next Level in:</b> <span style="color:var(--sl-xp)">3880 XP</span></div>
</div>

<!-- ==== CALENDAR CARD ==== -->
<div class="sl-card">
  <div class="sl-title">CALENDAR</div>
  ```dataviewjs
  await dv.view("99 - Meta/Calendar", {pages: "", view: "month", firstDayOfWeek: "1", options: "style1"})
  ```
</div>

<!-- ==== QUICK LINKS ==== -->
<div class="sl-card">
  <div class="sl-title">QUICK ACCESS</div>
  - [[06 - Daily|Daily]]
  - [[01 - Projects|Projects]]
  - [[08 - Review/Goals|Goals]]
  - [[03 - Resources|Resources]]
  - [[Permanent/Zettels|Zettels]]
  - [[99 - Meta/00 - Templates|Templates]]
</div>
</div>

---

## 📖 **Como Expandir Cada Área do HUD**

> **PLAYER STATUS:**  
> Edite atributos/XP diretamente no card ou automatize puxando de suas notas diárias/XP logs.

> **QUESTS:**  
> Troque o texto/objetivos ou conecte a um Dataview de projetos importantes, mostrando status, deadlines e recompensas.

> **GOALS:**  
> Crie/edite notas em `08 - Review/Goals/`, adicione mais campos (ex: categoria, impacto) no frontmatter e ajuste o Dataview para mostrar.

> **BOOK TRACKER:**  
> Para adicionar livros:
> - Crie uma nota em qualquer lugar do vault, adicione `#book` no início.
> - YAML sugerido:
>   ```
>   ---
>   tags: [book]
>   cover: https://link-da-capa.jpg
>   author: Nome do autor
>   status: Unread / Completed
>   ---
>   ```
> - Exemplos já cadastrados:
>   - Algoritmos para Viver
>   - 50 ideias de matemática que você precisa conhecer
>   - Data Science para Negócios
> - Para status "Completed", marque o campo na nota.

> **HABITS/DAILY:**  
> Os campos Writing/Workout/Reading são booleanos em cada nota diária. Marque `[x]` ou `true` para exibir como feito.

> **METRICS:**  
> Para expandir, some contagens de outros tipos (ex: hábitos, streak, XP semanal).

> **CALENDAR:**  
> O widget já puxa o mês atual. Para outros formatos, troque "view: 'month'" para "week" ou "year".

> **LINKS:**  
> Adicione/remova links conforme seu fluxo.

---

## 3. **BOOK TRACKER - Como ficam seus livros**

Crie 3 arquivos markdown (um para cada livro) assim:

````markdown name=03 - Resources/Algoritmos para viver.md
---
tags: [book]
cover: https://m.media-amazon.com/images/I/81gTwYAhU7L.jpg
author: Brian Christian, Tom Griffiths
status: Unread
---
# Algoritmos para viver