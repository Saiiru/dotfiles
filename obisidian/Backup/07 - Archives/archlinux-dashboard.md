---
cssclasses: [dashboard, hud, kora-main]
---
# KORA NEURAL MATRIX - DASHBOARD

> [!kora] STATUS DO SISTEMA
> **Usuário:** Sairu Dragnovitch
> **Nível:** 0 | **Rank:** E-RANK
> **XP:** 0 / 1000
> **Gold:** 💰 0 | **Streak:** 🔥 0

## 📊 PAINEL DE ATRIBUTOS
```dataviewjs
const stats = {
    "💪 Força": 10, "👁️ Percepção": 10, "❤️ Vigor": 10,
    "😊 Carisma": 10, "🧠 Inteligência": 10, "🏃 Agilidade": 10,
    "🍀 Sorte": 10
};
const data = Object.entries(stats).map(([key, value]) => [key, value]);
dv.table(["Atributo", "Nível"], data);
```

## ⚔️ QUESTS ATIVAS
```dataviewjs
const quests = dv.pages('"01 - Projects" or "06 - Daily"')
  .where(p => p.tags?.includes("Quest") && p.status === "Active");
dv.table(["Quest", "Dificuldade", "Recompensa XP", "Prazo"],
  quests.map(q => [
    q.file.link,
    q.difficulty,
    q.xp_reward,
    q.due_date
  ])
);
```

## ✅ TAREFAS PENDENTES (HOJE)
```dataviewjs
const tasks = dv.pages().file.tasks
  .where(t => !t.completed && t.due && t.due.toISODate() === dv.date('today').toISODate());
dv.taskList(tasks, false);
```

## 🚀 AÇÕES RÁPIDAS
<a href="obsidian://new?file=06 - Daily/2025-08-04&template=99 - Meta/00 - Templates/(TEMPLATE) daily" class="kora-button">📝 Nota Diária</a>
<a href="obsidian://new?file=01 - Projects/Nova Quest&template=99 - Meta/00 - Templates/(TEMPLATE) quest" class="kora-button">⚔️ Nova Quest</a>
<a href="obsidian://new?file=01 - Projects/Novo Projeto&template=99 - Meta/00 - Templates/(TEMPLATE) project" class="kora-button">🚀 Novo Projeto</a>

---
*Interface KORA v1.0 - Sincronizada em: 17:08:09*