---
id: <% tp.date.now("YYYYMMDDHHmm") %>
created: <% tp.date.now("YYYY-MM-DD") %>
modified: <% tp.date.now("YYYY-MM-DD") %>
tags:
  - permanent
  - zettelkasten
  - kora
cssclasses:
  - kora-permanent
---

<div class="ascii-art">
███████╗███████╗████████╗████████╗███████╗██╗     
╚══███╔╝██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██║     
  ███╔╝ █████╗     ██║      ██║   █████╗  ██║     
 ███╔╝  ██╔══╝     ██║      ██║   ██╔══╝  ██║     
███████╗███████╗   ██║      ██║   ███████╗███████╗
╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝
</div>

# <% tp.file.title %>

<div class="kora-permanent-header">
  <div class="kora-permanent-id"><% tp.frontmatter.id %></div>
  <div class="kora-permanent-dates">
    <span class="kora-date-created">CRIADO: <% tp.frontmatter.created %></span>
    <span class="kora-date-modified">MODIFICADO: <% tp.frontmatter.modified %></span>
  </div>
</div>

## CONCEITO PRINCIPAL
<% tp.file.cursor(1) %>

## ELABORAÇÃO
<% tp.file.cursor(2) %>

## EXEMPLOS
- <% tp.file.cursor(3) %>

## CONEXÕES
```dataviewjs
// Encontrar notas permanentes conectadas
const permanentNotes = dv.pages('"04 - Permanent"')
  .where(p => p.file.name !== dv.current().file.name && p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

if (permanentNotes.length === 0) {
  dv.paragraph("*Nenhuma nota permanente conectada*");
} else {
  dv.table(["Nota", "Criada", "Tags"],
    permanentNotes.map(p => [
      p.file.link,
      p.created ? p.created : p.file.cday.toString().split("T")[0],
      p.tags ? p.tags.filter(t => t !== "permanent").join(", ") : "—"
    ])
  );
}
```

- <% tp.file.cursor(4) %>

## REFERÊNCIAS
- <% tp.file.cursor(5) %>

## NOTAS
- <% tp.file.cursor(6) %>

## SISTEMA DE TAGS
```dataviewjs
// Extrair tags da nota atual
const currentTags = dv.current().tags || [];

// Encontrar tags relacionadas (tags que aparecem em notas conectadas)
const connectedNotes = dv.pages('"04 - Permanent"')
  .where(p => p.file.name !== dv.current().file.name && p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

let relatedTags = [];
connectedNotes.forEach(note => {
  if (note.tags) {
    relatedTags = [...relatedTags, ...note.tags.filter(t => !currentTags.includes(t))];
  }
});

// Remover duplicatas e tags comuns
const uniqueRelatedTags = [...new Set(relatedTags)]
  .filter(t => t !== "permanent" && t !== "zettelkasten" && t !== "kora");

// Mostrar tags relacionadas
if (uniqueRelatedTags.length > 0) {
  dv.paragraph("**Tags relacionadas:** " + uniqueRelatedTags.map(t => `#${t}`).join(", "));
}

// Mostrar tags atuais
dv.paragraph("**Tags atuais:** " + currentTags.map(t => `#${t}`).join(", "));
```

## LINKS
- [[00 - Maps of Content/home|🏠 Dashboard]]
- [[04 - Permanent/Placeholder|// filepath: /home/sairu/dotfiles/obisidian/99 - Meta/00 - Templates/permanent.md
---
id: <% tp.date.now("YYYYMMDDHHmm") %>
created: <% tp.date.now("YYYY-MM-DD") %>
modified: <% tp.date.now("YYYY-MM-DD") %>
tags:
  - permanent
  - zettelkasten
  - kora
cssclasses:
  - kora-permanent
---

<div class="ascii-art">
███████╗███████╗████████╗████████╗███████╗██╗     
╚══███╔╝██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██║     
  ███╔╝ █████╗     ██║      ██║   █████╗  ██║     
 ███╔╝  ██╔══╝     ██║      ██║   ██╔══╝  ██║     
███████╗███████╗   ██║      ██║   ███████╗███████╗
╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝
</div>

# <% tp.file.title %>

<div class="kora-permanent-header">
  <div class="kora-permanent-id"><% tp.frontmatter.id %></div>
  <div class="kora-permanent-dates">
    <span class="kora-date-created">CRIADO: <% tp.frontmatter.created %></span>
    <span class="kora-date-modified">MODIFICADO: <% tp.frontmatter.modified %></span>
  </div>
</div>

## CONCEITO PRINCIPAL
<% tp.file.cursor(1) %>

## ELABORAÇÃO
<% tp.file.cursor(2) %>

## EXEMPLOS
- <% tp.file.cursor(3) %>

## CONEXÕES
```dataviewjs
// Encontrar notas permanentes conectadas
const permanentNotes = dv.pages('"04 - Permanent"')
  .where(p => p.file.name !== dv.current().file.name && p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

if (permanentNotes.length === 0) {
  dv.paragraph("*Nenhuma nota permanente conectada*");
} else {
  dv.table(["Nota", "Criada", "Tags"],
    permanentNotes.map(p => [
      p.file.link,
      p.created ? p.created : p.file.cday.toString().split("T")[0],
      p.tags ? p.tags.filter(t => t !== "permanent").join(", ") : "—"
    ])
  );
}
```

- <% tp.file.cursor(4) %>

## REFERÊNCIAS
- <% tp.file.cursor(5) %>

## NOTAS
- <% tp.file.cursor(6) %>

## SISTEMA DE TAGS
```dataviewjs
// Extrair tags da nota atual
const currentTags = dv.current().tags || [];

// Encontrar tags relacionadas (tags que aparecem em notas conectadas)
const connectedNotes = dv.pages('"04 - Permanent"')
  .where(p => p.file.name !== dv.current().file.name && p.file.name !== "Placeholder")
  .where(p => p.file.outlinks.includes(dv.current().file.link) || 
             dv.current().file.outlinks.includes(p.file.link));

let relatedTags = [];
connectedNotes.forEach(note => {
  if (note.tags) {
    relatedTags = [...relatedTags, ...note.tags.filter(t => !currentTags.includes(t))];
  }
});

// Remover duplicatas e tags comuns
const uniqueRelatedTags = [...new Set(relatedTags)]
  .filter(t => t !== "permanent" && t !== "zettelkasten" && t !== "kora");

// Mostrar tags relacionadas
if (uniqueRelatedTags.length > 0) {
  dv.paragraph("**Tags relacionadas:** " + uniqueRelatedTags.map(t => `#${t}`).join(", "));
}

// Mostrar tags atuais
dv.paragraph("**Tags atuais:** " + currentTags.map(t => `#${t}`).join(", "));
```

## LINKS
- [[00 - Maps of Content/home|🏠 Dashboard]]
-