---
status: planning
started: 2025-08-10
progress: 5
tags: [kora, daedalus, ai, hud]
---

# KORA — DAEDALUS (Device for Autonomous Experimental Assistance & Development)

## Elevator pitch
DAEDALUS é o assistente local/edge para o laboratorio do Sairu: HUD, automações, inventário, e runtime de modelos leves em borda.

## Módulos propostos
- **DAEDALUS-HUD** — overlays, assets, templates (integra Obsidian para gerar logs).
- **DAEDALUS-LAB** — inventário, testes, calibração.
- **DAEDALUS-AI** — inference em Raspberry Pi / Coral para wake-word, TTS, classificação.
- **DAEDALUS-SYNC** — integração com Taskwarrior e scripts CLI.

## Naming note
Sugestões curtas (Tony-starky): FRIDAY-like names (FRIDA, E.D.I.T.H.), or acronymic: DAEDALUS, ATLAS, AURORA.
Escolhi **DAEDALUS** por referência ao inventor mítico — combina com vibe 'genius tinkerer'.

## Roadmap mínimo (MVP)
1. Pico HUD — microcontroller (ESP32) + OLED + LEDs. (Milestone)
2. Local logs -> Obsidian (append via HTTP or script).
3. Simple command interface (MQTT/Websocket).
4. Edge inference (Raspberry Pi + Coral).

## Tasks
- [ ] Definir API local (HTTP endpoints).
- [ ] Implementar pico HUD firmware (MicroPython).
- [ ] Criar script de sincronização Taskwarrior.
- [ ] Inventário inicial da bancada.

## Links Rápidos
- [[00 - Maps of Content/dashboard.md|Dashboard]]
- [[03 - Resources/Shopping - Electronics.md|Shopping List]]
