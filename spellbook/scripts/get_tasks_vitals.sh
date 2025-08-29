#!/bin/bash

# KORA: HUD Vitals and Task Status
# Retorna uma string minimalista com contagem de tarefas e próxima missão.

# Cores
CYAN="#[fg=#22D3EE]"
YELLOW="#[fg=#F59E0B]"
MAGENTA="#[fg=#EC4899]"
WHITE="#[fg=#CDD6F4]"
RESET="#[fg=default]"

# Contagem de tarefas
TASK_COUNT=$(task count status:pending)

# Próxima missão ativa
NEXT_TASK=$(task next limit:1 rc.report.next.columns=description rc.report.next.labels= | tail -n +2 | head -n -2 | tr '\n' ' ' | sed 's/ \+/\ \ /g' | xargs)

if [ -n "$NEXT_TASK" ]; then
    MISSION_STATUS="${YELLOW}${NEXT_TASK}${RESET}"
else
    MISSION_STATUS="${MAGENTA}NENHUMA MISSÃO ATIVA"
fi

# Saída formatada para o tmux
echo "» ${CYAN}MISSÕES:[${TASK_COUNT}]${RESET} ✦ ${MISSION_STATUS} "
