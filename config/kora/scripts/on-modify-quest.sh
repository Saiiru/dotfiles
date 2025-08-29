#!/bin/bash
# on-modify-quest.sh: Hook do Taskwarrior para gamificação.
# Local: ~/.task/hooks/on-modify-quest.sh

read -r OLD_TASK_JSON
read -r NEW_TASK_JSON

KORA_DIR="$HOME/.local/share/kora"
XP_FILE="$KORA_DIR/player_xp.log"
mkdir -p "$KORA_DIR"
touch "$XP_FILE"

OLD_STATUS=$(echo "$OLD_TASK_JSON" | jq -r '.status')
NEW_STATUS=$(echo "$NEW_TASK_JSON" | jq -r '.status')

if [[ "$OLD_STATUS" == "pending" && "$NEW_STATUS" == "completed" ]]; then
    XP_GAINED=$(echo "$NEW_TASK_JSON" | jq -r '.xp // 0')
    if (( XP_GAINED > 0 )); then
        echo "$XP_GAINED" >> "$XP_FILE"
        QUEST_DESC=$(echo "$NEW_TASK_JSON" | jq -r '.description')
        notify-send "Missão Concluída!" "<b>$QUEST_DESC</b>\nRecompensa: +${XP_GAINED} XP" -i "emblem-default"
    fi
fi

echo "$NEW_TASK_JSON"

