---
date: <% tp.date.now("YYYY-MM-DD") %>
tags: [experiment, hardware, log]
safety_checked: false
status: draft
components: []
results: []
---

# EXPERIMENTO: <% tp.file.title %>

## Objetivo
- <% tp.file.cursor(1) %>

## BOM (Bill of Materials)
- item | qty | note
- --- | --- | ---
- ESP32 Dev Board | 1 | I2C, Wi-Fi
- OLED 0.96" | 1 | I2C
- WS2812B strip | 1m | addressable LEDs

## Esquema / Wiring
- <% provide schematic or link to Excalidraw %>

## Procedimento (passo a passo)
1. Preparar bancada e ESD.
2. Montar em breadboard.
3. Testar alimentações.
4. Gravar firmware.

## Segurança
- Use fonte com limite de corrente e fusível.
- Verifique conexões antes de alimentar.
- Nunca manipule baterias Li-ion sem proteção.

## Resultados
- Tempo: 
- Observações:
- Logs: [[06 - Daily/<% tp.date.now("YYYYMMDD") %>.md|diário]]

## Tags
#experiment #hardware
