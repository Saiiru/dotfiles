---
cssclasses:
  - kora-dashboard
---

<div class="ascii-art">
██╗  ██╗ ██████╗ ██████╗  █████╗ 
██║ ██╔╝██╔═══██╗██╔══██╗██╔══██╗
█████╔╝ ██║   ██║██████╔╝███████║
██╔═██╗ ██║   ██║██╔══██╗██╔══██║
██║  ██╗╚██████╔╝██║  ██║██║  ██║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
███╗   ██╗███████╗██╗   ██╗██████╗  █████╗ ██╗         ███╗   ███╗ █████╗ ████████╗██████╗ ██╗██╗  ██╗
████╗  ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║         ████╗ ████║██╔══██╗╚══██╔══╝██╔══██╗██║╚██╗██╔╝
██╔██╗ ██║█████╗  ██║   ██║██████╔╝███████║██║         ██╔████╔██║███████║   ██║   ██████╔╝██║ ╚███╔╝ 
██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██╔══██║██║         ██║╚██╔╝██║██╔══██║   ██║   ██╔══██╗██║ ██╔██╗ 
██║ ╚████║███████╗╚██████╔╝██║  ██║██║  ██║███████╗    ██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║██║██╔╝ ██╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝
</div>

<div class="kora-header">
  <div class="kora-stats">
    <span class="kora-date">2025-08-04</span>
    <span class="kora-system">KORA v1.0</span>
    <span class="kora-user">USUÁRIO: Saiirue</span>
  </div>
</div>

> [!info] KORA NEURAL MATRIX v1.0
> **Data:** 2025-08-04
> **Hora:** 15:39:41
> **Usuário:** Saiirue
> **Estado:** Sistema Operacional

## AÇÕES RÁPIDAS

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <button class="kora-button" onclick="app.commands.executeCommandById('templater-obsidian:99 - Meta/00 - Templates/daily.md')">
    NOVA NOTA DIÁRIA
  </button>
  
  <button class="kora-button" onclick="app.commands.executeCommandById('templater-obsidian:99 - Meta/00 - Templates/project.md')">
    NOVO PROJETO
  </button>
  
  <button class="kora-button" onclick="app.commands.executeCommandById('templater-obsidian:99 - Meta/00 - Templates/area.md')">
    NOVA ÁREA
  </button>
  
  <button class="kora-button" onclick="app.commands.executeCommandById('templater-obsidian:99 - Meta/00 - Templates/permanent.md')">
    NOVA NOTA PERMANENTE
  </button>
</div>

## PROJETOS ATIVOS

```dataviewjs
const projects = dv.pages('"01 - Projects"')
  .where(p => p.status && p.status !== "completed" && p.status !== "archived" && p.file.name !== "Placeholder");

const getStatusEmoji = (status) => {
  if (!status) return "⚪";
  switch(status.toLowerCase()) {
    case "active": return "🟢";
    case "on hold": return "🟠";
    case "planning": return "🔵";
    case "reviewing": return "🟣";
    default: return "⚪";
  }
};

const progressBar = (value) => {
  const percent = value || 0;
  const filled = Math.round((20 * percent) / 100);
  const empty = 20 - filled;
  return `[${"■".repeat(filled)}${"□".repeat(empty)}] ${percent}%`;
};

if (projects.length === 0) {
  dv.paragraph("*Nenhum projeto ativo encontrado*");
} else {
  dv.table(["Status", "Projeto", "Prazo", "Progresso"],
    projects.map(p => [
      getStatusEmoji(p.status),
      p.file.link,
      p.deadline ? p.deadline : "—",
      progressBar(p.progress)
    ])
  );
}
```

## ÁREAS DE RESPONSABILIDADE

```dataviewjs
const areas = dv.pages('"02 - Areas"').where(p => p.file.name !== "Placeholder");

if (areas.length === 0) {
  dv.paragraph("*Nenhuma área de responsabilidade encontrada*");
} else {
  dv.table(["Área", "Tipo", "Última Revisão", "Próxima Revisão"],
    areas.map(p => [
      p.file.link,
      p.area_type ? p.area_type : "—",
      p.last_review ? p.last_review : "Nunca",
      p.next_review ? p.next_review : "—"
    ])
  );
}
```

## TAREFAS RECENTES

```dataviewjs
const tasks = dv.pages().file.tasks
  .where(t => !t.completed)
  .sort(t => t.due || "9999-99-99", "asc");

if (tasks.length === 0) {
  dv.paragraph("*Nenhuma tarefa pendente encontrada*");
} else {
  dv.table(["Prioridade", "Tarefa", "Devido", "Arquivo"],
    tasks.slice(0, 10).map(t => {
      let priority = "🔵"; // Normal
      
      if (t.due) {
        const dueDate = new Date(t.due);
        const today = new Date();
        const diffDays = Math.ceil((dueDate - today) / (1000 * 60 * 60 * 24));
        
        if (diffDays < 0) {
          priority = "🔴"; // Atrasado
        } else if (diffDays <= 2) {
          priority = "🟠"; // Próximo do prazo
        }
      }
      
      return [
        priority,
        t.text,
        t.due ? t.due.toString().split("T")[0] : "—",
        t.link
      ];
    })
  );
}
```

## NOTAS RECENTES

```dataviewjs
const permanentNotes = dv.pages('"04 - Permanent"')
  .where(p => p.file.name !== "Placeholder")
  .sort(p => p.file.mtime, "desc")
  .limit(5);

if (permanentNotes.length === 0) {
  dv.paragraph("*Nenhuma nota permanente encontrada*");
} else {
  dv.table(["Nota", "Criada", "Modificada", "Tags"],
    permanentNotes.map(p => [
      p.file.link,
      p.created ? p.created.toString().split("T")[0] : "—",
      p.file.mtime.toString().split("T")[0],
      p.tags ? p.tags.join(", ") : "—"
    ])
  );
}
```

## ESTATÍSTICAS DO SISTEMA

```dataviewjs
const totalNotes = dv.pages().length;
const completedTasks = dv.pages().file.tasks.where(t => t.completed).length;
const pendingTasks = dv.pages().file.tasks.where(t => !t.completed).length;
const permanentNotes = dv.pages('"04 - Permanent"').where(p => p.file.name !== "Placeholder").length;
const totalProjects = dv.pages('"01 - Projects"').where(p => p.file.name !== "Placeholder").length;
const activeProjects = dv.pages('"01 - Projects"')
  .where(p => p.status && p.status.toLowerCase() === "active" && p.file.name !== "Placeholder").length;

const progressBar = (value, max, size = 20) => {
  const percent = max > 0 ? Math.round((value / max) * 100) : 0;
  const filled = Math.round((size * percent) / 100);
  const empty = size - filled;
  return `[${"■".repeat(filled)}${"□".repeat(empty)}] ${percent}%`;
};

dv.table(["Métrica", "Valor", "Progresso"],
  [
    ["Total de Notas", totalNotes, ""],
    ["Notas Permanentes", permanentNotes, progressBar(permanentNotes, totalNotes)],
    ["Tarefas Completas", completedTasks, ""],
    ["Tarefas Pendentes", pendingTasks, ""],
    ["Projetos Ativos", activeProjects, progressBar(activeProjects, totalProjects)]
  ]
);
```

## SISTEMA DE XP

```dataviewjs
// Obter total de XP de todas as notas diárias
let totalXP = 0;
const dailyNotes = dv.pages('"06 - Daily"').where(p => p.xp_gained);

dailyNotes.forEach(note => {
  totalXP += note.xp_gained;
});

// Calcular nível e progresso
const levelThreshold = 1000;
const currentLevel = Math.floor(totalXP / levelThreshold) + 1;
const levelProgress = (totalXP % levelThreshold) / levelThreshold * 100;

// Criar barra de progresso
const progressBar = (percent, size = 20) => {
  const filled = Math.round((size * percent) / 100);
  const empty = size - filled;
  return `[${"■".repeat(filled)}${"□".repeat(empty)}] ${Math.round(percent)}%`;
};

dv.el("div", "", {
  cls: "kora-xp",
  attr: {
    style: "margin: 20px 0; padding: 15px; background: rgba(139, 92, 246, 0.1); border-radius: 10px; border: 1px solid var(--kora-purple);"
  }
});

dv.span("NÍVEL ATUAL: ");
dv.el("span", currentLevel.toString(), {
  attr: {
    style: "font-family: var(--kora-font-heading); color: var(--kora-purple); font-size: 1.2em; margin-right: 10px;"
  }
});

dv.span("XP TOTAL: ");
dv.el("span", totalXP.toString(), {
  attr: {
    style: "font-family: var(--kora-font-mono-alt); color: var(--kora-cyan);"
  }
});

dv.el("div", "", {
  attr: {
    style: "height: 20px; background: rgba(139, 92, 246, 0.2); border-radius: 10px; margin: 10px 0; position: relative; overflow: hidden;"
  }
});

dv.el("div", "", {
  attr: {
    style: `position: absolute; top: 0; left: 0; height: 100%; width: ${levelProgress}%; background: linear-gradient(90deg, var(--kora-purple), var(--kora-blue)); border-radius: 10px;`
  }
});

dv.el("div", `${Math.round(levelProgress)}% para o nível ${currentLevel + 1}`, {
  attr: {
    style: "position: absolute; top: 0; left: 0; right: 0; bottom: 0; display: flex; align-items: center; justify-content: center; font-family: var(--kora-font-mono-alt); color: var(--kora-text);"
  }
});
```

## ACESSO RÁPIDO
- [[06 - Daily/20250804|📝 Nota Diária Atual]]
- [[01 - Projects/Placeholder|📂 Projetos]]
- [[02 - Areas/Placeholder|🏢 Áreas]]
- [[03 - Resources/Placeholder|📚 Recursos]]
- [[04 - Permanent/Placeholder|💎 Notas Permanentes]]

```dataviewjs
// Obter data atual
const today = new Date();
const month = today.getMonth();
const year = today.getFullYear();

// Criar calendário
const daysInMonth = new Date(year, month + 1, 0).getDate();
const firstDay = new Date(year, month, 1).getDay();
const monthName = today.toLocaleString('default', { month: 'long' });

// Cabeçalho do calendário
dv.header(3, `Calendário: ${monthName} ${year}`);

// Dias da semana
const weekDays = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
let calendarTable = `| ${weekDays.join(" | ")} |\n| ${weekDays.map(() => "---").join(" | ")} |\n`;

// Preencher dias do mês
let day = 1;
let calendarRow = "|";

// Preencher espaços vazios no início
for (let i = 0; i < firstDay; i++) {
  calendarRow += "   |";
}

// Preencher dias
for (let i = firstDay; i < 7; i++) {
  const date = `${year}${(month + 1).toString().padStart(2, '0')}${day.toString().padStart(2, '0')}`;
  calendarRow += ` [[06 - Daily/${date}|${day}]] |`;
  day++;
}
calendarTable += calendarRow + "\n";

// Continuar preenchendo as semanas restantes
while (day <= daysInMonth) {
  calendarRow = "|";
  for (let i = 0; i < 7; i++) {
    if (day <= daysInMonth) {
      const date = `${year}${(month + 1).toString().padStart(2, '0')}${day.toString().padStart(2, '0')}`;
      calendarRow += ` [[06 - Daily/${date}|${day}]] |`;
    } else {
      calendarRow += "   |";
    }
    day++;
  }
  calendarTable += calendarRow + "\n";
}

dv.paragraph(calendarTable);
```