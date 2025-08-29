#!/usr/bin/env bash
# OP-1 Pomodoro · tmux-integrado · start|new|pause|resume|toggle|stop|status|daemon
set -euo pipefail

DIR="${XDG_CACHE_HOME:-$HOME/.cache}/arcane"; mkdir -p "$DIR"
STATE="$DIR/pomo.json"

# Paleta para tmux (usa #[fg=..][bg=..] no segmento)
P_FOCUS="#b162ff"
P_BREAK="#00e0ff"
P_LONG="#00d084"
P_BG_DARK="#0a0f14"
P_FG_DARK="#101317"

need(){ command -v "$1" >/dev/null || { echo "[ERR] falta $1"; exit 1; }; }
need jq

now(){ date +%s; }
fmt(){ printf "%02d:%02d" $(( $1/60 )) $(( $1%60 )); }

write_state(){ # id phase end remain cycle total focus short long paused
  jq -n --arg id "${1:-}" --arg ph "${2:-FOCUS}" --argjson end "${3:-0}" \
        --argjson rem "${4:-0}" --argjson cyc "${5:-1}" --argjson tot "${6:-4}" \
        --argjson f "${7:-1500}" --argjson s "${8:-300}" --argjson l "${9:-900}" \
        --argjson paused "${10:-false}" \
     '{task_id:$id, phase:$ph, end:$end, remain:$rem, cycle:$cyc, total:$tot, focus:$f, short:$s, long:$l, paused:$paused}' > "$STATE"
}

readv(){ jq -r ".$1" "$STATE"; }

notify(){ tmux display-message "⏱ $1" 2>/dev/null || true; command -v notify-send >/dev/null && notify-send "OP-1 Pomodoro" "$1" || true; }

segment_set(){ # atualiza opções do tmux para colorir o status-right
  command -v tmux >/dev/null || return 0
  local ph="$1" time="$2" cyc="$3" tot="$4"
  local bg icon; case "$ph" in
    FOCUS) bg="$P_FOCUS"; icon="";;
    BREAK) bg="$P_BREAK"; icon="󰂛";;
    LONG)  bg="$P_LONG";  icon="";;
    *)     bg="$P_BREAK"; icon="⏱";;
  esac
  local seg="#[bg=${bg},fg=${P_FG_DARK}]#[bg=${bg},fg=${P_BG_DARK}] ${icon} ${ph} ${time} ${cyc}/${tot} #[bg=default,fg=${bg}]#[default]"
  tmux set-option -gq @pomo_segment "$seg"
  tmux set-option -gq @pomo_phase   "$ph"
  tmux set-option -gq @pomo_time    "$time"
  tmux set-option -gq @pomo_cycle   "${cyc}/${tot}"
}

segment_clear(){
  command -v tmux >/dev/null || return 0
  tmux set-option -gq @pomo_segment "#[fg=colour244]⏱ idle"
  tmux set-option -gq @pomo_phase "IDLE"
  tmux set-option -gq @pomo_time  "--:--"
  tmux set-option -gq @pomo_cycle "-/-"
}

status(){
  [ -f "$STATE" ] || { echo "⏱ idle"; exit 0; }
  local ph end cyc tot paused rem n
  ph=$(readv phase); end=$(readv end); cyc=$(readv cycle); tot=$(readv total); paused=$(readv paused)
  if $paused; then rem=$(readv remain); else n=$(now); rem=$(( end - n )); [ "$rem" -lt 0 ] && rem=0; fi
  echo "$ph $(fmt "$rem") $cyc/$tot"
}

pause(){
  [ -f "$STATE" ] || exit 0
  [ "$(readv paused)" = "true" ] && exit 0
  local end n rem; end=$(readv end); n=$(now); rem=$(( end - n )); [ "$rem" -lt 0 ] && rem=0
  jq ".paused=true | .remain=$rem" "$STATE" > "$STATE.tmp" && mv "$STATE.tmp" "$STATE"
  segment_set "$(readv phase)" "$(fmt "$rem")" "$(readv cycle)" "$(readv total)"
  notify "Pausa · $(fmt "$rem")"
}

resume(){
  [ -f "$STATE" ] || exit 0
  [ "$(readv paused)" = "true" ] || exit 0
  local rem n end; rem=$(readv remain); n=$(now); end=$(( n + rem ))
  jq ".paused=false | .end=$end" "$STATE" > "$STATE.tmp" && mv "$STATE.tmp" "$STATE"
  segment_set "$(readv phase)" "$(fmt "$rem")" "$(readv cycle)" "$(readv total)"
  notify "Retomado"
}

toggle(){ [ -f "$STATE" ] || exit 0; [ "$(readv paused)" = "true" ] && resume || pause; }

stop(){ rm -f "$STATE"; segment_clear; notify "Parado"; }

daemon(){
  while [ -f "$STATE" ]; do
    local paused ph n end cyc tot f s l rem
    paused=$(readv paused)
    if $paused; then
      rem=$(readv remain)
      segment_set "$(readv phase)" "$(fmt "$rem")" "$(readv cycle)" "$(readv total)"
      sleep 1; continue
    fi
    ph=$(readv phase); n=$(now); end=$(readv end); cyc=$(readv cycle); tot=$(readv total)
    f=$(readv focus); s=$(readv short); l=$(readv long)
    rem=$(( end - n )); [ "$rem" -lt 0 ] && rem=0
    segment_set "$ph" "$(fmt "$rem")" "$cyc" "$tot"
    if [ "$n" -ge "$end" ]; then
      if [ "$ph" = "FOCUS" ]; then
        command -v task >/dev/null && id=$(readv task_id) && [ -n "$id" ] && task "$id" annotate "Pomodoro foco $((f/60))m" >/dev/null 2>&1 || true
        cyc=$((cyc+1))
        if [ $(( (cyc-1) % tot )) -eq 0 ]; then ph="LONG"; end=$(( n + l )); notify "Pausa longa"
        else ph="BREAK"; end=$(( n + s )); notify "Pausa"; fi
      else
        ph="FOCUS"; end=$(( n + f )); notify "Foco"
      fi
      write_state "$(readv task_id)" "$ph" "$end" 0 "$cyc" "$tot" "$f" "$s" "$l" false
    fi
    sleep 1
  done
  segment_clear
}

start(){ # id focus_min short_min long_min total
  local id="${1:-}" F=$(( ${2:-25}*60 )) S=$(( ${3:-5}*60 )) L=$(( ${4:-15}*60 )) T="${5:-4}"
  write_state "$id" "FOCUS" $(( $(now) + F )) 0 1 "$T" "$F" "$S" "$L" false
  segment_set "FOCUS" "$(fmt "$F")" 1 "$T"
  notify "Foco iniciado · $((F/60))m"
  ( "$0" daemon & ) >/dev/null 2>&1
}

new(){ # interativo via tmux popup
  local id="" F S L T
  if command -v task >/dev/null; then
    id=$(task rc.report.pick.columns=id,description rc.report.pick.labels=ID,Quest pick | sed -n '3p' | awk '{print $1}')
  fi
  printf "Foco (min, 25): "; read -r F; F=${F:-25}
  printf "Pausa curta (min, 5): "; read -r S; S=${S:-5}
  printf "Pausa longa (min, 15): "; read -r L; L=${L:-15}
  printf "Ciclos até pausa longa (4): "; read -r T; T=${T:-4}
  start "${id:-}" "$F" "$S" "$L" "$T"
}

case "${1:-status}" in
  status) status ;;
  start)  shift; start "$@" ;;
  new)    new ;;
  pause)  pause ;;
  resume) resume ;;
  toggle) toggle ;;
  stop)   stop ;;
  daemon) daemon ;;
  *)      echo "uso: $0 {status|new|start|pause|resume|toggle|stop}"; exit 1;;
esac

