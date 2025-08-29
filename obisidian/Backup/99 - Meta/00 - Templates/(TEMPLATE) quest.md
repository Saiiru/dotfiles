---
tags:
  - Quest
  - KORA
status: Active
difficulty: Normal
xp_reward: 100
gold_reward: 50
due_date: <% tp.date.now("YYYY-MM-DD", "P+7D") %>
cssclasses:
  - quest
  - hud-blue
area: 
Progress: 15
Target: 100
Start: 
Deadline: 
banner: https://assets-global.website-files.com/63fe5b1c322d2f50310b436a/63fe5b1c322d2f11cb0b4860_midj02.png
banner_y: 0.5
Completed date: 
---

# 퀘스트: <% tp.file.title %>

```meta-bind
INPUT[progressBar(title(Progress), minValue(0), maxValue(100)):Progress]
```

> [!quest] Detalhes da Missão
> - **Status:** <% tp.frontmatter.status %>
> - **Dificuldade:** <% tp.frontmatter.difficulty %>
> - **Recompensa:** `+<% tp.frontmatter.xp_reward %> XP` | `+<% tp.frontmatter.gold_reward %> G`
> - **Prazo:** <% tp.frontmatter.due_date %>

> [!info]- Why is this goal Important to me?
> - 1
> - 2

> [!success]- What would I gain by achieving this goal?
> - 1
> - 2

> [!danger]- What are the possible risks & Obstacles?
> - 1
> - 2


## 📜 DESCRIÇÃO
<% tp.file.cursor(1) %>

## 🎯 OBJETIVOS
- [ ] <% tp.file.cursor(2) %>
- [ ] <% tp.file.cursor(3) %>
- [ ] <% tp.file.cursor(4) %>

## 📝 NOTAS E ESTRATÉGIA
- 

## 🔗 LINKS RELACIONADOS
- 