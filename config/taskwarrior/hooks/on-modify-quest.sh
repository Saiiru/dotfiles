#!/bin/bash
# on-modify-quest.sh: Hook do Taskwarrior para gamificação.
# Adiciona XP quando uma tarefa é concluída.

read -r OLD_TASK_JSON
read -r NEW_TASK_JSON

KORA_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/kora"
XP_FILE="$KORA_DATA_DIR/player_xp.log"
mkdir -p "$KORA_DATA_DIR"
touch "$XP_FILE"

OLD_STATUS=$(echo "$OLD_TASK_JSON" | jq -r '.status')
NEW_STATUS=$(echo "$NEW_TASK_JSON" | jq -r '.status')

if [[ "$OLD_STATUS" == "pending" && "$NEW_STATUS" == "completed" ]]; then
    XP_GAINED=$(echo "$NEW_TASK_JSON" | jq -r '.xp // 0')
    if (( XP_GAINED > 0 )); then
        CURRENT_XP=$(cat "$XP_FILE" 2>/dev/null || echo 0)
        NEW_XP=$((CURRENT_XP + XP_GAINED))
        echo "$NEW_XP" > "$XP_FILE"
        
        QUEST_DESC=$(echo "$NEW_TASK_JSON" | jq -r '.description')
        notify-send "Missão Concluída!" "<b>$QUEST_DESC</b>\nRecompensa: +${XP_GAINED} XP" -i "emblem-default"
    fi
fi

echo "$NEW_TASK_JSON"
