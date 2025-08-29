#!/bin/bash
# Simple sync script: reads tasks-db.csv and adds tasks to taskwarrior using `task add`.
# Requires Taskwarrior installed and configured.
CSV="99 - Meta/tasks-db.csv"
IFS=$'\n'
for row in $(tail -n +2 "$CSV"); do
  IFS=',' read -r id project description due priority status tags <<< "$row"
  # Convert priority letter to Taskwarrior - P: priority, M: medium etc.
  if [[ "$priority" == "H" ]]; then prio="H"; elif [[ "$priority" == "M" ]]; then prio="M"; else prio="L"; fi
  cmd=(task add "$description" project:"$project" due:"$due" +$tags)
  echo "Running: ${cmd[*]}"
  "${cmd[@]}"
done
echo "Done. (Preview only: edit script to avoid duplicates)"
