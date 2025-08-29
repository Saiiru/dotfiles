---
date: <% tp.date.now("YYYY-MM-DD") %>T<% tp.date.now("HH:mm") %>
energy: 5
focus: 5
mood: neutral
tasks_completed: 0
xp_gained: 0
tags:
  - Daily
  - KORA
cssclasses:
  - daily
  - kora-daily
  <% "- " + tp.date.now("dddd", 0, tp.file.title, "YYYYMMDD").toLowerCase() %>
---

<div class="ascii-art">
 ██ ▄█▀ ▒█████   ██▀███   ▄▄▄      
 ██▄█▒ ▒██▒  ██▒▓██ ▒ ██▒▒████▄    
▓███▄░ ▒██░  ██▒▓██ ░▄█ ▒▒██  ▀█▄  
▓██ █▄ ▒██   ██░▒██▀▀█▄  ░██▄▄▄▄██ 
▒██▒ █▄░ ████▓▒░░██▓ ▒██▒ ▓█   ▓██▒
▒ ▒▒ ▓▒░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░
░ ░▒ ▒░  ░ ▒ ▒░   ░▒ ░ ▒░  ▒   ▒▒ ░
░ ░░ ░ ░ ░ ░ ▒    ░░   ░   ░   ▒   
░  ░       ░ ░     ░           ░  ░
</div>

# DAILY LOG: <% tp.date.now("YYYY-MM-DD", 0, tp.file.title, "YYYYMMDD") %>

<div class="kora-header">
  <div class="kora-stats">
    <span class="kora-date"><% tp.date.now("YYYY-MM-DD", 0, tp.file.title, "YYYYMMDD") %></span>
    <span class="kora-system">KORA NEURAL MATRIX v1.0</span>
    <span class="kora-user">USUÁRIO: Saiiru</span>
  </div>
</div>

## STATUS DO SISTEMA

> [!info] KORA NEURAL MATRIX v1.0
> **Inicialização diária:** <% tp.date.now("HH:mm:ss") %>
> **Dia da semana:** <% tp.date.now("dddd", 0, tp.file.title, "YYYYMMDD") %>
> **Usuário:** Saiirue
> **Estado:** Operacional

## MÉTRICAS VITAIS

<div class="kora-meter kora-energy">
  <span style="width: <% tp.frontmatter.energy * 10 %>%"></span>
  <div class="kora-meter-label">ENERGIA: <% tp.frontmatter.energy %>/10</div>
</div>

<div class="kora-meter kora-focus">
  <span style="width: <% tp.frontmatter.focus * 10 %>%"></span>
  <div class="kora-meter-label">FOCO: <% tp.frontmatter.focus %>/10</div>
</div>

<div class="kora-meter kora-mood">
  <span style="width: <% 
    (function(){
      const moods = {
        "terrível": 1, "ruim": 3, "neutro": 5, 
        "bom": 7, "excelente": 10, "neutral": 5
      };
      return (moods[tp.frontmatter.mood.toLowerCase()] || 5) * 10;
    })()
  %>%"></span>
  <div class="kora-meter-label">HUMOR: <% tp.frontmatter.mood %></div>
</div>

## AGENDA DE HOJE

- [ ] <% tp.file.cursor(1) %>

## REGISTRO DE ATIVIDADES

### MANHÃ
- <% tp.file.cursor(2) %>

### TARDE
- <% tp.file.cursor(3) %>

### NOITE
- <% tp.file.cursor(4) %>

## TAREFAS PENDENTES

```dataviewjs
// Obter tarefas não concluídas com vencimento para hoje ou sem data
const today = dv.date("today");
const formattedToday = today.toString().split("T")[0];

// Tarefas de todas as notas
const tasks = dv.pages()
  .file.tasks
  .where(t => !t.completed)
  .where(t => !t.due || t.due.toString().split("T")[0] <= formattedToday)
  .sort(t => t.due, 'asc');

// Exibir em tabela
dv.table(
  ["Status", "Tarefa", "Data", "Arquivo"],
  tasks.map(t => [
    t.due && t.due.toString().split("T")[0] < formattedToday ? "🔴" : "🔵",
    t.text,
    t.due ? t.due.toString().split("T")[0] : "—",
    t.link
  ])
);
```

## TAREFAS CONCLUÍDAS HOJE

```dataviewjs
// Obter tarefas concluídas hoje
const today = dv.date("today");
const tasks = dv.pages()
  .file.tasks
  .where(t => t.completed)
  .where(t => t.completion && t.completion.toString().startsWith(today.toString().split("T")[0]));

// Calcular XP
const xpGained = tasks.length * 10;

// Exibir em tabela
dv.table(
  ["✓", "Tarefa", "Concluída", "Arquivo"],
  tasks.map(t => [
    "✅",
    t.text,
    t.completion ? t.completion.toString().split("T")[1].substring(0, 5) : "—",
    t.link
  ])
);

// Exibir total de XP
dv.paragraph(`**XP Ganho Hoje:** ${xpGained} pontos (${tasks.length} tarefas × 10 XP)`);
```

## SISTEMA DE EXPERIÊNCIA

<div class="kora-xp">
  <span class="kora-xp-label">XP</span>
  <div class="kora-xp-bar">
    <div class="kora-xp-fill" style="width: <% 
      (function(){
        const totalXP = tp.frontmatter.xp_gained || 0;
        const levelThreshold = 1000;
        return (totalXP % levelThreshold) / levelThreshold * 100;
      })()
    %>%"></div>
    <div class="kora-xp-text"><% tp.frontmatter.xp_gained || 0 %> / 1000</div>
  </div>
  <div class="kora-level"><% Math.floor((tp.frontmatter.xp_gained || 0) / 1000) + 1 %></div>
</div>

## REFLEXÃO DO DIA

### O que foi bem hoje?
- <% tp.file.cursor(5) %>

### O que poderia ter sido melhor?
- <% tp.file.cursor(6) %>

### Ideias capturadas
- <% tp.file.cursor(7) %>

## LINKS
- [[00 - Maps of Content/home|🏠 Dashboard]]
- [[06 - Daily/<% tp.date.now("YYYYMMDD", -1) %>|◀️ Ontem]]
- [[06 - Daily/<% tp.date.now("YYYYMMDD", 1) %>|▶️ Amanhã]]