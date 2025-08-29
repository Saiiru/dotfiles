# 📦 Pacote Obsidian — KORA / Sairu Vault

Este documento contém **todos os arquivos** (templates, dashboard, DB, tutoriais e BOM) prontos para copiar para o seu vault Obsidian. Cada seção abaixo é um arquivo separado: copie o bloco inteiro (incluindo o frontmatter) para o respectivo ficheiro dentro do seu vault.

> OBS: este pacote evita qualquer instrução para fabricar armas letais/não-letais. Para efeitos "taser"/"stun" use apenas **efeitos visuais/sonoros/hápticos seguros** (LEDs, EL-wire, vibração, som). Veja a secção *Alternativas Seguras* no tutorial.

---

## === FILE: 00 - Maps of Content/dashboard.md ===

````markdown
---
cssclasses: kora-project
---
# 🚀 HUD Principal — KORA / SAIRU

**Visão rápida**

- [[01 - Projects/Launchpad|🏁 Launchpad]]
- [[01 - Projects/Projects Index|📂 Projects Index]]
- [[02 - Hardware/BOM|🧰 Hardware & BOM]]
- [[03 - Tutorials/Smart-Lab-Setup|🔧 Montagem do Smart Lab]]
- [[Sairu/Sairu Dragnovitch|🧾 Ficha de Personagem - Sairu]]

---

## Tasks Hoje
```dataview
table due, priority, status
from "01 - Projects"
where contains(file.tasks.text, date(today)) or due = date(today)
sort priority desc
````

---

## Quick Links

* **Daily**: \[\[06 - Daily/{{date\:YYYYMMDD}}|Abrir nota diária]]
* **Kanban**: \[\[01 - Projects/Projects Index|Projects Index]]
* **Database (Tasks)**: \[\[04 - Database/tasks-db|Task DB]]

---

## Painel de Hardware

```dataview
list from "02 - Hardware"
```

````

---

## === FILE: 01 - Projects/(TEMPLATE) Project.md ===
```markdown
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

# PROJETO: <% tp.file.title %>

## Descrição
<% tp.file.cursor(1) %>

## Objetivos
- [ ] <% tp.file.cursor(2) %>

## Tarefas relacionadas (Dataview)
```dataview
table priority, due, status
from "01 - Projects"
where contains(file.inlinks, this.file.link) or contains(file.outlinks, this.file.link)
````

## Recursos

* Materiais: <% tp.file.cursor(3) %>
* Orçamento: <% tp.file.cursor(4) %>

## Marcos

* [ ] Início: <% tp.frontmatter.started %>
* [ ] Marco 1: <% tp.file.cursor(5) %>
* [ ] Conclusão: <% tp.frontmatter.deadline || "A definir" %>

````

---

## === FILE: 02 - Templates/(TEMPLATE) Daily.md ===
```markdown
---
date: <%tp.date.now("YYYY-MM-DD")%>T<%tp.date.now("HH:mm")%>
tags:
  - Daily
  - hud
cssclasses:
  - daily
  - pen-purple
xp_today: 0
gold_today: 0
tasks_completed: 0
---

# DAILY NOTE — <% tp.date.now("dddd, DD MMMM YYYY") %>

## Morning
- [ ] Revisar inbox
- [ ] 15m leitura técnica

## Quests
- [ ] Quest Principal: <% tp.file.cursor(1) %>

## Logs / Notas
-

## Tasks automáticas
```dataview
task from "01 - Projects"
where !completed and due = date(today)
````

````

---

## === FILE: 03 - Database/tasks-db.md ===
```markdown
---
aliases: ["Task DB"]
---
# 🗃️ Database: Tasks (esquema)

Este ficheiro descreve o *schema* que usaremos para centralizar tarefas e para sincronizar com Taskwarrior.

## Frontmatter recomendado para cada tarefa / ficheiro de projeto
```yaml
- title: "Nome da Tarefa"
  tags: [task, project:NomeDoProjeto]
  status: pending
  priority: H/M/L
  due: 2025-08-15
  source: taskwarrior
````

## Sincronização simples (visão geral)

1. No seu computador com Taskwarrior, exporte:

```
task export > tasks.json
```

2. Execute um script (node/python) que converta o JSON em notas `.md` individuais (ou atualize uma nota `04 - Database/tasks-db.md`).
3. Agende via cron/Task Scheduler: `cron` a cada 5–30 min.

> Exemplos de comandos e script na pasta `99 - Meta/03 - scripts`.

```
# Exemplo (pseudocódigo):
# python3 taskwarrior_to_obsidian.py tasks.json --out "01 - Projects/"
```

*Nota:* O script de conversão está incluído no pacote (veja a secção `99 - Meta/03 - scripts`).

````

---

## === FILE: 04 - Hardware/BOM.md ===
```markdown
---
cssclasses: kora-project
---
# 🧰 Hardware & BOM — Smart Lab Básico (BR + AliExpress)

## Núcleo (microcontrollers & SBCs)
- **ESP32-WROVER-B** (devkit ESP32) — microcontroller Wi‑Fi/Bluetooth. *Bom para sensores, GPIO e pequenos agentes.*
- **Raspberry Pi 4 Model B (4/8GB)** — para HUD local, serviços leves e integração com câmera.
- **NVIDIA Jetson (Nano / Orin Nano)** — para inferência de modelos ML maiores e visão computacional (opcional para projetos avançados).
- **Google Coral USB Accelerator (Edge TPU)** — acelera modelos TensorFlow Lite em SBCs.

## Ferramentas (essenciais)
- Estação de solda: **TS100** (ferro) ou **Hakko FX-888D** (estação completa)
- Sugestão de multímetro digital (1000V/10A) e pinças (precision tweezers)
- Fonte de alimentação ajustável 0–30V, 5A
- Ferramentas: cuter, alicate, ferro de solda, maleta com resistores, capacitores, cabos jumper

## Kits e componentes baratos (AliExpress keywords)
- "ESP32 WROVER DevKit" (busca AliExpress)
- "Raspberry Pi 4 Model B 8GB" + case + PSU USB-C 5V/3A
- "NVIDIA Jetson Nano Developer Kit" (se disponível no Brasil comprar via ML)
- "Coral USB Accelerator USB" (search)
- "TS100 soldering iron" or "Hakko FX-888D" (stores)

> Veja no chat os links sugeridos para AliExpress e Mercado Livre com SKUs, e a seção de referências.
````

---

## === FILE: 05 - Tutorials/Smart-Lab-Setup.md ===

```markdown
---
cssclasses: kora-project
---
# 🔧 Tutorial: Como montar sua estação (passo-a-passo)

## 1) Planejamento + segurança
- Espaço ventilado; coifa simples ou ventilador local.
- Use óculos e sempre desligue fontes antes de mexer em circuitos.

## 2) Primeiras compras (priorize)
1. Multímetro decente
2. Estação de solda (TS100 para portabilidade; Hakko para bancada fixa)
3. Kit ESP32 + Cabo USB
4. Raspberry Pi 4 (se quiser UI local)
5. Cabos, protoboard, jumpers

## 3) Ambiente de software (básico)
- Git + GitHub (versão de controle do seu vault)
- Obsidian: plugins recomendados (Templater, Dataview, Tasks, Excalidraw)
- SSH e SAMBA: monte o RPi como servidor de ficheiros se quiser editar remotamente

## 4) Exemplo rápido: HUD local com Raspberry Pi + ESP32
- Pi roda servidor local (Flask/Node) e apresenta widgets com HTML/CSS
- ESP32 envia telemetria via MQTT para o Pi
- Use Mosquitto como broker MQTT

## 5) Integrações úteis
- Coral USB Accelerator para acelerar modelos TFLite no Pi. (Edge TPU)
- Jetson para cargas maiores de inferência.

## 6) Alternativas seguras aos "taser" props
- LEDs pulsantes + som (circuito com 5V). Seguro e convincente.
- EL-Wire / Neon LED Strips para arco visual.
- Motores de vibração (para feedback háptico).
- Não forneceremos informação para construir dispositivos que apliquem choque elétrico.

## 7) Primeiro projeto recomendado (iniciante)
- Projetar um HUD simples em HTML que lê temperatura via ESP32 e mostra notificações.
- Documentar passo a passo no Obsidian (template: Project.md)
```

---

## === FILE: 06 - Cheatsheets/Commands-Cheatsheet.md ===

```markdown
# 🧾 Cheatsheet Rápido

## Taskwarrior -> export
- Exportar tasks: `task export > tasks.json`  
- Importar para Taskwarrior: `task import tasks.json`

## Git (vault)
- `git init`  
- `git add .`  
- `git commit -m "update"`  
- `git push origin main`

## Cron example (Linux)
- agendar export Taskwarrior a cada 15 min:
```

\*/15 \* \* \* \* /usr/bin/task export > /home/you/vault/99-meta/tasks.json && /usr/bin/python3 /home/you/vault/99-meta/scripts/tw2md.py

```

## SSH para Raspberry Pi
- `ssh pi@192.168.1.42`

```

---

## === FILE: 99 - Meta/03 - scripts/taskwarrior\_to\_obsidian.py ===

```python
#!/usr/bin/env python3
# Exemplo simples: converte Taskwarrior JSON para notas Markdown "Tasks/UUID.md"
import json, sys, os

infile = sys.argv[1]
outdir = sys.argv[2] if len(sys.argv) > 2 else './01 - Projects/'
with open(infile) as f:
    tasks = json.load(f)
for t in tasks:
    uid = t.get('uuid')
    title = t.get('description','task')
    status = t.get('status','')
    due = t.get('due','')
    md = f"---\ntitle: {title}\nstatus: {status}\ndue: {due}\nsource: taskwarrior\n---\n\n# {title}\n\n- status: {status}\n- due: {due}\n"
    fn = os.path.join(outdir, f"task_{uid}.md")
    with open(fn,'w') as o:
        o.write(md)
    print('wrote', fn)
```

---

# Como usar este pacote

1. Crie as pastas correspondentes no seu vault (ex.: `01 - Projects`, `02 - Hardware`, `03 - Tutorials`, `06 - Daily`, `99 - Meta/03 - scripts`).
2. Copie cada bloco acima para um ficheiro com o mesmo nome.
3. Instale plugins: Templater, Dataview, Tasks.
4. Teste o fluxo Taskwarrior -> `task export` -> script -> Obsidian.

---

*Fim do pacote.*

