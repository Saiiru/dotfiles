---
tags: [Quest, KORA]
status: "Active"
difficulty: "Normal" # Easy, Normal, Hard, Epic
xp_reward: 100
gold_reward: 50
due_date: <% tp.date.now("YYYY-MM-DD", "P+7D") %>
cssclasses: [quest, hud-blue]
---

# 퀘스트: <% tp.file.title %>

> [!quest] Detalhes da Missão
> - **Status:** <% tp.frontmatter.status %>
> - **Dificuldade:** <% tp.frontmatter.difficulty %>
> - **Recompensa:** `+<% tp.frontmatter.xp_reward %> XP` | `+<% tp.frontmatter.gold_reward %> G`
> - **Prazo:** <% tp.frontmatter.due_date %>

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