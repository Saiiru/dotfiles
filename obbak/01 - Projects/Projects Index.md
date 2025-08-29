# 📂 Projects Index

```dataview
TABLE status, priority, progress, due
FROM "01 - Projects"
WHERE contains(tags, "project")
SORT priority desc, file.name asc
```