---
title: "Projeto: Voice-To-Text JARVIS (HUD + IA)"
tags: [project, ai, voice, hud, python, whisper, vosk]
status: active
priority: high
progress: 5
started: <% tp.date.now("YYYY-MM-DD") %>
---

## Objetivo
Construir um sistema de transcrição + comando por voz local (Whisper/Vosk), HUD em pygame/HTML, integração com GPT local/API.

## Macro Roadmap
1) VAD (PyAudio/WebRTC VAD) → [[Resources/Voice-VAD-Example]]
2) Features (MFCC/Spectrogram) → [[Resources/Audio-Feature-Extraction]]
3) STT: Whisper tiny/medium | Vosk → [[Resources/STT-Model-Comparison]]
4) Real-time loop (mic → transcribe → intent) → [[Resources/Whisper-RealTime]]
5) LLM integration (local/API) → [[Resources/GPT-Integration]]
6) HUD overlay (pygame) com status e prompts.
7) Testes diversos (ruído/sotaques), logging.
8) Doc/UX.

## Tasks
- [ ] Setup venv + PyAudio #study [xp:10]
- [ ] Testar Whisper tiny-int8 no Pi4 + Coral (opcional) [xp:30]
- [ ] HUD pygame protótipo [xp:20]

## Links
[[03 - Resources/HUD-Code-Example]]
[[03 - Resources/RPG/README]]