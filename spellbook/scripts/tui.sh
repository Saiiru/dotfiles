#!/bin/bash

# Define as variáveis de cores ANSI e Unicode
CYAN='\033[38;5;51m'
MAGENTA='\033[38;5;141m'
WHITE='\033[0m'
GREEN='\033[38;5;84m'
RESET='\033[0m'

# Símbolos Unicode
LINE_H="═"
LINE_V="║"
CORNER_TL="╔"
CORNER_TR="╗"
CORNER_BL="╚"
CORNER_BR="╝"
SEPARATOR_T="╠"
SEPARATOR_B="╠"
EMBLEM_L="⟡◈⟡"
EMBLEM_M="⟁"
EMBLEM_S="⟡✦⟡"
RUNE_TASK="⟊"
RUNE_STATUS="⧖"

# Define o comprimento da linha
LINE_LENGTH=65
PADDED_LENGTH=$((LINE_LENGTH - 4))

# --- Coleta de Dados do Sistema ---

# Get Mana and Level
MANA_FILE="$HOME/dotfiles/spellbook/mana_log.dat"
TOTAL_MANA=$(awk '{s+=$1} END {print s+0}' "$MANA_FILE")
CURRENT_LEVEL=1
MANA_FOR_NEXT_LEVEL=100
while (( $(echo "$TOTAL_MANA >= $MANA_FOR_NEXT_LEVEL" | bc -l) )); do
    TOTAL_MANA_TEMP=$(echo "$TOTAL_MANA - $MANA_FOR_NEXT_LEVEL" | bc -l)
    TOTAL_MANA=$TOTAL_MANA_TEMP
    ((CURRENT_LEVEL++))
    MANA_FOR_NEXT_LEVEL=$((CURRENT_LEVEL * 100))
done

# Get Mana Bar
PROGRESS_PERCENT=$(echo "scale=0; ($TOTAL_MANA / $MANA_FOR_NEXT_LEVEL) * 100" | bc | cut -d. -f1)
FILLED_LENGTH=$(( (PROGRESS_PERCENT * 10) / 100 ))
MANA_BAR=""
for ((i=0; i<$FILLED_LENGTH; i++)); do MANA_BAR+="█"; done
for ((i=$FILLED_LENGTH; i<10; i++)); do MANA_BAR+="▒"; done

# Get Tasks
TASK_LIST=$(task '(status:pending or status:waiting)' limit:5 rc.report.next.columns=description rc.report.next.labels= | sed '1d' | sed '$d')

# Get Status Text
if [[ $(task '(status:pending or status:waiting)' count) -gt 0 ]]; then
    STATUS_TEXT="Ritual in progress..."
else
    STATUS_TEXT="All spells cast. Mana full."
fi

# --- Renderização do Painel ---

# Top Border
echo -e "${MAGENTA}${CORNER_TL}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_L}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${CORNER_TR}${RESET}"

# Header
echo -e "${MAGENTA}${LINE_V}${WHITE} $(printf "%-${PADDED_LENGTH}s" "${CYAN}⟁ ARCANE SPELLBOOK :: TASKS ${WHITE}") ${MAGENTA}${LINE_V}${RESET}"

# Separator
echo -e "${MAGENTA}${SEPARATOR_T}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_S}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_S}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${CORNER_TR}${RESET}"

# Task List
while read -r line; do
    if [[ -n "$line" ]]; then
        echo -e "${MAGENTA}${LINE_V}${WHITE} ${RUNE_TASK} ${line} $(printf "%*s" $((LINE_LENGTH - 4 - ${#line} - 4)))${MAGENTA}${LINE_V}${RESET}"
    else
        echo -e "${MAGENTA}${LINE_V}${WHITE} $(printf "%-${PADDED_LENGTH}s" " ") ${MAGENTA}${LINE_V}${RESET}"
    fi
done <<< "$(task '(status:pending or status:waiting)' limit:5 rc.report.next.columns=description rc.report.next.labels= | tail -n +2 | head -n -2)"

# Bottom Separator
echo -e "${MAGENTA}${SEPARATOR_B}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_S}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_S}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${CORNER_TR}${RESET}"

# Status/Aura/Next
echo -e "${MAGENTA}${LINE_V}${GREEN} ${RUNE_STATUS} STATUS: ${STATUS_TEXT} $(printf "%*s" $((LINE_LENGTH - 4 - ${#STATUS_TEXT} - 12)))${MAGENTA}${LINE_V}${RESET}"
echo -e "${MAGENTA}${LINE_V}${GREEN} ${RUNE_STATUS} AURA:  ${MANA_BAR} (${PROGRESS_PERCENT}%) $(printf "%*s" $((LINE_LENGTH - 4 - 10 - 10)))${MAGENTA}${LINE_V}${RESET}"
echo -e "${MAGENTA}${LINE_V}${GREEN} ${RUNE_STATUS} NEXT SEAL: Midnight Invocation $(printf "%*s" $((LINE_LENGTH - 4 - 29)))${MAGENTA}${LINE_V}${RESET}"

# Bottom Border
echo -e "${MAGENTA}${CORNER_BL}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${EMBLEM_L}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${LINE_H}${CORNER_BR}${RESET}"
