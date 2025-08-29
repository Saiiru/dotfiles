#!/bin/bash

# KORA: Task Log Interface
# Retorna uma string formatada com as próximas tarefas.

# Define as cores
GREEN="#[fg=colour10]" # Cor verde para o título
YELLOW="#[fg=colour11]" # Cor amarela para tarefas pendentes
RESET="#[fg=default]"

# Conta as tarefas pendentes
TASK_COUNT=$(task count status:pending)

# Pega as 3 próximas tarefas e as formata
if [ "$TASK_COUNT" -gt 0 ]; then
    TASKS_STRING=$(task next limit:3 rc.report.next.columns=description rc.report.next.labels= | tail -n +2 | head -n -2 | tr '\n' ' ' | sed 's/ \+/\ \ /g' | xargs | sed 's/ / | /g')
    echo "${GREEN}TASKS${RESET} > ${YELLOW}$TASKS_STRING${RESET}"
else
    echo "${GREEN}TASKS${RESET} > ${YELLOW}MISSION LOG: CLEAR${RESET}"
fi
