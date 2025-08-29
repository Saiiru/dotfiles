#!/usr/bin/env bash
# OP-1 · Arcane TUI (gum + task + jq)
set -euo pipefail

need(){ command -v "$1" >/dev/null || { echo "[ERR] falta $1"; exit 1; }; }
need task; need jq; need gum

# ── Paleta
C_PURP="#b162ff"; C_CYAN="#00e0ff"; C_GRN="#00d084"; C_ORNG="#ff9d00"; C_DIM="#8a8f98"

icon_proj(){ case "$1" in
  CodeForge*) echo "";;
  RedVeil*) echo "󰬸";;
  CircuitForge*) echo "";;
  ArcaneGrimoire*|Ops*) echo "";;
  Lore*|lore*) echo "𓂀";;
  Study*|study*) echo "";;
  NoProject) echo "…";;
  *) echo "";;
esac; }

energy_glyph(){ case "${1:-low}" in low) echo "";; mid) echo "";; high) echo "";; *) echo "";; esac; }
diff_glyph(){ case "${1:-easy}" in easy) echo "★";; normal) echo "★★";; hard) echo "★★★";; elite) echo "★★★★";; legendary) echo "★★★★★";; *) echo "☆";; esac; }

# ── Dados
projects_json(){ task rc.context=none rc.gc=off rc.json.array=on '(status:pending or status:waiting)' export 2>/dev/null |
  jq -c 'map({p:(.project // "NoProject"), xp:(.xp // 0)})
         | group_by(.p)
         | map({project: .[0].p, count: length, xp:(map(.xp)|add)})'; }

projects_list(){
  projects_json | jq -r '.[]|@tsv' | while IFS=$'\t' read -r P N XP; do
    echo "$(icon_proj "$P")  $P  $N  $XP"
  done
  echo "＊  ALL  ∑  All Projects"
}

pick_project(){
  gum style --foreground "$C_CYAN" --border normal --border-foreground "$C_PURP" --padding "0 1" "⚝ Selecione um projeto"
  local CHOICE
  CHOICE=$(projects_list | gum choose --height 15 --limit 1 --cursor "⟡" --no-limit=false)
  echo "$CHOICE" | awk '{print $2}'
}

list_tasks(){ # list_tasks <PROJ|ALL|NoProject>
  local P="${1:-ALL}" FILT
  if [[ "$P" == "ALL" ]]; then
    FILT='(status:pending or status:waiting)'
  elif [[ "$P" == "NoProject" ]]; then
    FILT='(status:pending or status:waiting) and -PROJECT'
  else
    FILT="project:$P (status:pending or status:waiting)"
  fi
  task rc.context=none rc.gc=off rc.color=off rc.verbose=nothing $FILT arc |
  awk 'NR>2 && $1~/^[0-9]+$/ {printf "%-4s | %-14s | %-48s | %-6s | %-3s | %-4s | %-6s | %-4s | %-9s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}'
}

pick_task_row(){ # retorna linha selecionada
  local P="$1"
  gum style --foreground "$C_GRN" --border normal --border-foreground "$C_CYAN" --padding "0 1" "⌬ ${P} · Tasks"
  list_tasks "$P" | gum filter --placeholder "filtrar…"
}

id_from_row(){ echo "$1" | awk -F'|' '{gsub(/ /,"",$1);print $1}'; }

task_field(){ task "$1" _get "$2" 2>/dev/null || true; }

preview_card(){ # preview_card <ID>
  local id="$1"
  local desc proj est energy xp diff due schd stat urg age tags
  desc=$(task_field "$id" description)
  proj=$(task_field "$id" project); [[ -z "$proj" ]] && proj="NoProject"
  est=$(task_field  "$id" est); energy=$(task_field "$id" energy); xp=$(task_field "$id" xp)
  diff=$(task_field "$id" diff); due=$(task_field "$id" due.relative); schd=$(task_field "$id" scheduled.relative)
  stat=$(task_field "$id" status); urg=$(task_field "$id" urgency); age=$(task_field "$id" age)
  tags=$(task "$id" _get tags 2>/dev/null || echo "-")
  gum style --border normal --border-foreground "$C_PURP" --margin "0 0" --padding "1 2" \
    "$(printf "✦ %s\n" "$desc")" \
    "$(printf "Project  %s  %s     XP %s    Energy %s    Diff %s" "$(icon_proj "$proj")" "$proj" "${xp:-0}" "$(energy_glyph "${energy:-low}")" "$(diff_glyph "${diff:-easy}")")" \
    "$(printf "Est %s    Due %s    Sched %s    Age %s" "${est:--}" "${due:--}" "${schd:--}" "${age:--}")" \
    "$(printf "Urgency %s" "${urg:-0}")" \
    "$(printf "Tags: %s" "$tags")"
}

confirm(){ gum confirm --selected.background "$C_ORNG" --prompt "Confirmar?"; }

quick_add(){ # quick_add <PROJECT>
  local P="$1"
  local desc xp diff energy est tag
  desc=$(gum input --placeholder "Nova quest…") || return 0
  [[ -z "$desc" ]] && return 0
  xp=$(gum input --placeholder "XP (10)") ; xp=${xp:-10}
  diff=$(printf "easy\nnormal\nhard\nelite\nlegendary" | gum choose --height 5) ; diff=${diff:-easy}
  energy=$(printf "low\nmid\nhigh" | gum choose --height 3) ; energy=${energy:-low}
  est=$(gum input --placeholder "Est ex: 20min") || true
  tag=$(gum input --placeholder "tag opcional ex: +ops") || true
  # regra ≤25min: se >25min, força diff:hard
  if echo "$est" | grep -Eqi '([3-9][0-9]|[1-9][0-9]{2,}) *min'; then diff="hard"; fi
  gum spin --title "gravando…" -- task add "${desc}" ${P:+project:"$P"} xp:"$xp" diff:"$diff" energy:"$energy" ${est:+est:"$est"} ${tag}
}

actions_menu(){ printf "start\ndone\nedit\nannotate\ndelete\nview\nnew\nback"; }

do_action(){ # do_action <ID> <P>
  local id="$1" P="$2" act note
  act=$(actions_menu | gum choose --height 8 --cursor "⚝") || return 1
  case "$act" in
    start)   gum spin --title "start…"   -- task start "$id" ;;
    done)    if confirm; then gum spin --title "done…"    -- task done "$id"; fi ;;
    edit)    task "$id" modify ;; 
    annotate) note=$(gum input --placeholder "anotação…") && task "$id" annotate "$note" ;;
    delete)  if confirm; then gum spin --title "delete…"  -- task "$id" delete; fi ;;
    view)    task "$id" ;;
    new)     quick_add "$P" ;;
    back)    return 1 ;;
  esac
}

dashboard(){ # dashboard <P>
  local P="${1:-ALL}" FILT pend wait soon xp
  if [[ "$P" == "ALL" ]]; then
    FILT='(status:pending or status:waiting)'
  elif [[ "$P" == "NoProject" ]]; then
    FILT='(status:pending or status:waiting) and -PROJECT'
  else
    FILT="project:$P (status:pending or status:waiting)"
  fi
  pend=$(task rc.context=none rc.gc=off $FILT status:pending count 2>/dev/null || echo 0)
  wait=$(task rc.context=none rc.gc=off $FILT +WAITING count 2>/dev/null || echo 0)
  soon=$(task rc.context=none rc.gc=off $FILT due.before:tomorrow count 2>/dev/null || echo 0)
  xp=$(task rc.context=none rc.gc=off $FILT rc.report.tmp.columns=xp rc.report.tmp.labels=XP tmp 2>/dev/null |
       awk 'NR>2 && $1~/^[0-9]+$/ {s+=$1} END{print (s?s:0)}')
  gum style --border normal --border-foreground "$C_CYAN" --padding "1 2" \
    "$(printf "⌬ Dashboard  %s %s" "$(icon_proj "$P")" "$P")" \
    "$(printf "Pend %s   Wait %s   Due<24h %s    XP %s" "$pend" "$wait" "$soon" "$xp")"
}

main(){
  while true; do
    P=$(pick_project); [[ -z "${P:-}" ]] && exit 0
    clear; dashboard "$P"
    while true; do
      ROW=$(pick_task_row "$P") || break
      ID=$(id_from_row "$ROW")
      clear; dashboard "$P"; preview_card "$ID"
      do_action "$ID" "$P" || break
      clear; dashboard "$P"
    done
  done
}
main

