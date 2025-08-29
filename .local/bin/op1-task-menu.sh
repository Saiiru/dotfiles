#!/usr/bin/env bash
# tmux display-menu launcher
set -euo pipefail
has(){ command -v "$1" >/dev/null; }

tmux display-menu -T "#[align=centre]⚝ OP-1 · Quests" -x C -y C \
 "TUI (popup)"     t  "display-popup -w 90% -h 90% -E 'arcane || ~/.local/bin/op1-arcane.sh || task quests'" \
 "Today"           y  "display-popup -w 80% -h 80% -E 'task today'" \
 "Quests"          q  "display-popup -w 80% -h 80% -E 'task quests'" \
 "Add quick"       a  "display-popup -E 'bash -lc \"read -p \\\"desc: \\\" d; task add \\\"\$d\\\" xp:10 diff:easy energy:low est:20min\"'" \
 "Pomo: novo"      p  "display-popup -w 70% -h 70% -E '~/.local/bin/op1-pomo.sh new'" \
 "Pomo: pause/res" P  "run-shell -b '~/.local/bin/op1-pomo.sh toggle'" \
 "Pomo: stop"      s  "run-shell    '~/.local/bin/op1-pomo.sh stop'" \
 "" "" "" \
 "Fechar"          Enter ""

