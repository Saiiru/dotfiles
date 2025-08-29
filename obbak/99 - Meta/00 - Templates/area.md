---
area_type: 
last_review: <% tp.date.now("YYYY-MM-DD") %>
next_review: <% tp.date.now("YYYY-MM-DD", 90) %>
tags:
  - area
  - kora
cssclasses:
  - kora-area
---

<div class="ascii-art">
 █████╗ ██████╗ ███████╗ █████╗ 
██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████║██████╔╝█████╗  ███████║
██╔══██║██╔══██╗██╔══╝  ██╔══██║
██║  ██║██║  ██║███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
</div>

# ÁREA: <% tp.file.title %>

<div class="kora-area-header">
  <div class="kora-area-type"><% tp.frontmatter.area_type ? tp.frontmatter.area_type.toUpperCase() : "ÁREA" %></div>
  <div class="kora-area-review">
    <span class="kora-last-review">ÚLTIMA REVISÃO: <% tp.frontmatter.last_review %></span>
    <span class="kora-next-review">PRÓXIMA REVISÃO: <% tp.frontmatter.next_review %></span>
  </div>
</div>

## DESCRIÇÃO DA ÁREA
<% tp.file.cursor(1) %>

## RESPONSABILIDADES
- <% tp.file.cursor(2) %>

## OBJETIVOS DE MANUTENÇÃO
- [ ] <% tp.file.cursor(3) %>

## PROJETOS RELACIONADOS
```dataviewjs
const projects = dv.pages('"01 - Projects"')
  .where(p => p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

if (projects.length === 0) {
  dv.paragraph("*Nenhum projeto relacionado encontrado*");
} else {
  dv.table(["Projeto", "Status", "Prazo", "Progresso"],
    projects.map(p => [
      p.file.link,
      p.status || "—",
      p.deadline || "—",
      p.progress ? `${p.progress}%` : "0%"
    ])
  );
}
```

## RECURSOS IMPORTANTES
```dataviewjs
const resources = dv.pages('"03 - Resources"')
  .where(p => p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

if (resources.length === 0) {
  dv.paragraph("*Nenhum recurso relacionado encontrado*");
} else {
  dv.table(["Recurso", "Tipo", "Data"],
    resources.map(p => [
      p.file.link,
      p.resource_type || "—",
      p.file.cday.toString().split("T")[0]
    ])
  );
}
```

## TAREFAS PENDENTES
```dataviewjs
const areaTasks = dv.pages()
  .file.tasks
  .where(t => !t.completed)
  .where(t => t.text.includes(dv.current().file.name) || 
             t.text.includes(dv.current().file.link));

if (areaTasks.length === 0) {
  dv.paragraph("*Nenhuma tarefa pendente para esta área*");
} else {
  dv.taskList(areaTasks, false);
}
```

## NOTAS E IDEIAS
- <% tp.file.cursor(4) %>

## HISTÓRICO DE REVISÕES

### <% tp.date.now("YYYY-MM-DD") %> - Criação/Revisão Inicial
- <% tp.file.cursor(5) %>

## MÉTRICAS
```dataviewjs
// Contar projetos nesta área
const projects = dv.pages('"01 - Projects"')
  .where(p => p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

// Contar recursos
const resources = dv.pages('"03 - Resources"')
  .where(p => p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

// Contar tarefas
const tasks = dv.pages()
  .file.tasks
  .where(t => t.text.includes(dv.current().file.name) || 
             t.text.includes(dv.current().file.link));

const completedTasks = tasks.where(t => t.completed);
const pendingTasks = tasks.where(t => !t.completed);

// Estatísticas
dv.table(["Métrica", "Valor"],
  [
    ["Projetos Vinculados", projects.length],
    ["Recursos Vinculados", resources.length],
    ["Tarefas Completadas", completedTasks.length],
    ["Tarefas Pendentes", pendingTasks.length]
  ]
);
```

## LINKS RELACIONADOS
- [[00 - Maps of Content/home|🏠 Dashboard]]
- [[02 - Areas/Placeholder|🏢 Todas as Áreas]]