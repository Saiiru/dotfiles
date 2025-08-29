---
title: HUD Principal
tags: [dashboard, kora, sput]
kora_status: standby
kora_version: DAEDALUS-0.1
---

# 🚀 HUD Principal — DAEDALUS

> Visão rápida do vault, status de KORA (DAEDALUS), tarefas e projetos ativos.

## Quick Links
- [[01 - Projects/KORA - DAEDALUS Project.md|KORA — DAEDALUS Project]]
- [[01 - Projects/Pico HUD - MVP.md|Pico HUD - MVP]]
- [[Sairu/Sairu Dragnovitch.md|Sairu Profile]]
- [[05 - Archive/MurderboardNerferia.md|Murderboard Nerféria]]

## Status KORA
- **Nome:** DAEDALUS (sugestão; ver `99 - Meta/NAME_CHOICES.md`)
- **Estado:** `{{kora_status}}`
- **Última sincronização:** 2025-08-10 03:16

## Projetos ativos
```dataview
table progress, status, started, deadline
from "01 - Projects"
where status != "completed"
sort progress desc
```

## Tasks Hoje (Dataview tasks + link para Taskwarrior sync)
```dataview
task from "06 - Daily"
where !completed and due = date(today)
sort priority desc
```

## Hardware Quick (inventory status)
```dataview
table qty, location, status
from "02 - Areas/Hardware Lab"
where contains(tags, "inventory")
```

## Quick Actions
- [[03 - Resources/Templates/(TEMPLATE) Project.md|New Project Template]]
- [[03 - Resources/Templates/(TEMPLATE) Hardware Experiment.md|New Experiment Template]]
- [[03 - Resources/Shopping - Electronics.md|Shopping List]]
- [[99 - Meta/sync_taskwarrior.sh|Sync tasks to Taskwarrior script]]

---
*Use this page as your Launchpad. Customize Dataview queries to taste.*
