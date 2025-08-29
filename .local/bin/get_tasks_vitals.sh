#!/usr/bin/env bash
echo "⌬ Today"; task today
echo; echo "⚝ Quests"; task quests
echo; echo " XP hoje"; grep "$(date -I)" ~/.config/task/xp.log | awk '{s+=$2} END{print (s? s:0)}'

