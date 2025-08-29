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

<div class="ascii-art">
██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗
██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝
██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║   
██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║   
██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║   
╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   
</div>

# PROJETO: <% tp.file.title %>

<div class="kora-project-header">
  <div class="kora-project-status">
    <span class="status-<% tp.frontmatter.status %>"><% tp.frontmatter.status.toUpperCase() %></span>
  </div>
  <div class="kora-project-meta">
    <span class="kora-project-dates">
      <span class="kora-date-started">INÍCIO: <% tp.frontmatter.started %></span>
      <span class="kora-date-deadline">PRAZO: <% tp.frontmatter.deadline || "Não definido" %></span>
    </span>
    <div class="kora-progress-bar">
      <div class="kora-progress-fill" style="width: <% tp.frontmatter.progress %>%;"></div>
      <span class="kora-progress-text"><% tp.frontmatter.progress %>%</span>
    </div>
  </div>
</div>

## DESCRIÇÃO DO PROJETO
<% tp.file.cursor(1) %>

## OBJETIVOS
- [ ] <% tp.file.cursor(2) %>

## PARTES INTERESSADAS
- <% tp.file.cursor(3) %>

## RECURSOS NECESSÁRIOS
- <% tp.file.cursor(4) %>

## TAREFAS

```dataviewjs
// Obter tarefas deste projeto
const tasks = dv.page().file.tasks;
const completed = tasks.where(t => t.completed).length;
const total = tasks.length;
const percent = total > 0 ? Math.round((completed / total) * 100) : 0;

// Estatísticas
dv.paragraph(`**Progresso das Tarefas:** ${completed}/${total} (${percent}%)`);

// Barra de progresso
const progressBar = (percent, size = 20) => {
  const filled = Math.round((size * percent) / 100);
  const empty = size - filled;
  return `[${"■".repeat(filled)}${"□".repeat(empty)}] ${percent}%`;
};

dv.paragraph(progressBar(percent));

// Listar tarefas não concluídas
if (tasks.where(t => !t.completed).length > 0) {
  dv.header(4, "Pendentes");
  dv.taskList(tasks.where(t => !t.completed), false);
}

// Listar tarefas concluídas
if (tasks.where(t => t.completed).length > 0) {
  dv.header(4, "Concluídas");
  dv.taskList(tasks.where(t => t.completed), false);
}
```

- [ ] <% tp.file.cursor(5) %>

## MARCOS
- [ ] **Início:** <% tp.frontmatter.started %>
- [ ] **Marco 1:** <% tp.file.cursor(6) %>
- [ ] **Marco 2:** <% tp.file.cursor(7) %>
- [ ] **Conclusão:** <% tp.frontmatter.deadline || "A definir" %>

## RISCOS E MITIGAÇÕES
| Risco | Probabilidade | Impacto | Mitigação |
| ----- | ------------- | ------- | --------- |
| <% tp.file.cursor(8) %> | Média | Alto | <% tp.file.cursor(9) %> |

## NOTAS E ATUALIZAÇÕES

### <% tp.date.now("YYYY-MM-DD") %> - Criação do projeto
- <% tp.file.cursor(10) %>

## PROJETOS RELACIONADOS

```dataviewjs
// Encontrar projetos que estão vinculados a este projeto
const currentFileName = dv.current().file.name;
const relatedProjects = dv.pages('"01 - Projects"')
  .where(p => p.file.name !== currentFileName && p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             p.file.inlinks.includes(dv.current().file.link) ||
             dv.current().file.outlinks.includes(p.file.link));

if (relatedProjects.length === 0) {
  dv.paragraph("*Nenhum projeto relacionado encontrado*");
} else {
  dv.table(["Projeto", "Status", "Progresso"],
    relatedProjects.map(p => [
      p.file.link,
      p.status || "—",
      p.progress ? `${p.progress}%` : "0%"
    ])
  );
}
```

## SISTEMA DE XP
Completar este projeto concederá **<% Math.round((tp.frontmatter.priority === "high" ? 300 : (tp.frontmatter.priority === "medium" ? 200 : 100)) * (1 + tp.file.tasks.length * 0.1)) %>** pontos de experiência.

## LINKS RELACIONADOS
- [[00 - Maps of Content/home|🏠 Dashboard]]
- [[01 - Projects/Placeholder|📂 Todos os Projetos]]