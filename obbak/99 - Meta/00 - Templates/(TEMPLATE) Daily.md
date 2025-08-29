---
date: <%tp.date.now("YYYY-MM-DD")%>T<%tp.date.now("HH:mm")%>
tags:
  - Daily
cssclasses:
  - daily
  <% "- " + tp.date.now("dddd", 0, tp.file.title, "YYYYMMDD").toLowerCase() %>
  - hud
  - pen-purple
xp_today: 0
gold_today: 0
tasks_completed: 0
---

# DAILY NOTE
## <% tp.date.now("dddd, MMMM Do, YYYY", 0, tp.file.title, "YYYYMMDD") %>
***
### Journal
#### TIME
Customize this template to your liking!
...
***
### Tasks
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3


# 📅 NOTA DIÁRIA: <% tp.date.now("dddd, DD MMMM YYYY") %>
> Streak Atual: 🔥 X dias

## 📊 STATUS DIÁRIO
| Métrica | Status | Ação |
| :--- | :--- | :--- |
| ⚡ **Energia** | <% tp.file.cursor(1) %>/10 | `+10 XP` |
| 🎯 **Foco** | <% tp.file.cursor(2) %>/10 | `+10 XP` |
| 😊 **Humor** | <% tp.file.cursor(3) %>/10 | `+10 XP` |

## ⚔️ QUESTS DO DIA
- [ ] **Quest Principal:** <% tp.file.cursor(4) %>
- [ ] **Micro-Quest 1:** <% tp.file.cursor(5) %>
- [ ] **Micro-Quest 2:** <% tp.file.cursor(6) %>

## ✅ CHECKLIST DE TAREFAS
```dataviewjs
const tasks = dv.pages().file.tasks
  .where(t => !t.completed && t.text.includes(dv.current().file.name.split(" ")[0]))
  .sort(t => t.due, "asc");

if (tasks.length > 0) {
  dv.taskList(tasks, false);
} else {
  dv.paragraph("Nenhuma tarefa para hoje. Crie algumas!");
}
```
- [ ] 

## 💡 INSIGHTS & IDEIAS
- 

## 📈 REGISTRO DE PROGRESSO
- **XP Ganho Hoje:** `+<% tp.frontmatter.xp_today %> XP`
- **Gold Coletado:** `+<% tp.frontmatter.gold_today %> G`
- **Tarefas Concluídas:** `<% tp.frontmatter.tasks_completed %>`

---
> [[<% tp.date.now("YYYY-MM-DD", "P-1D") %>|◀️ Ontem]] | [[dashboard|HUD Principal]] | [[<% tp.date.now("YYYY-MM-DD", "P+1D") %>|Amanhã ▶️]]