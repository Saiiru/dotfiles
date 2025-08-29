---
tags: [Stat, KORA, Character]
stat_name: "" # strength, perception, etc.
current_level: 10
xp_to_next_level: 1000
cssclasses: [stat, hud-green]
---

# 📊 STAT: <% tp.frontmatter.stat_name %>

> [!stat] Atributo Principal
> - **Nível Atual:** <% tp.frontmatter.current_level %>
> - **Próximo Nível:** `<% tp.frontmatter.xp_to_next_level %> XP`

## 📈 DESCRIÇÃO E BENEFÍCIOS
<% tp.file.cursor(1) %>

## 🏋️ COMO TREINAR ESTE ATRIBUTO
- **Ação 1:** <% tp.file.cursor(2) %> (`+10 XP`)
- **Ação 2:** <% tp.file.cursor(3) %> (`+20 XP`)
- **Ação 3:** <% tp.file.cursor(4) %> (`+50 XP`)

## 🏆 MARCOS DE PROGRESSO
- **Nível 15:** 
- **Nível 20:** 
- **Nível 25:** 