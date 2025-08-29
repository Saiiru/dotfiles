---
status: planning
started: <% tp.date.now("YYYY-MM-DD") %>
deadline:
progress: 0
priority: medium
tags:
  - project
  - kora
cssclasses:
  - kora-project
---

# PROJETO: <% tp.file.title %>

## Resumo
<% tp.file.cursor(1) %>

## Objetivos (SMART)
- [ ] Objetivo principal
- [ ] Critério de sucesso

## Marcos
- [ ] Marco 1 — <% tp.date.now("YYYY-MM-DD", 7) %>
- [ ] Marco 2

## Recursos / BOM
- <% tp.file.cursor(2) %>

## Tarefas (use Task plugin / Tasks inline)
- [ ] Task example

```dataviewjs
// Project task overview (tasks inside this project's folder)
const p = dv.current().file.path;
const tasks = dv.pages(p).file.tasks.where(t => !t.completed);
dv.taskList(tasks, false);
```

## Notas de Design / CAD / Esquemas
- Links: [[Assets/]] / [[04 - Zettels/]]

## Riscos
- <% tp.file.cursor(3) %>

## Logs
- <% tp.date.now("YYYY-MM-DD") %> — Criação do projeto
