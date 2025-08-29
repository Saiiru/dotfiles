#!/usr/bin/env bash
set -e
sel=$(task rc.report.pick.columns=id,description rc.report.pick.labels=ID,Quest pick | fzf --layout=reverse --prompt="⚝ pick> " | awk '{print $1}')
[ -z "$sel" ] && exit 0
echo "⌬ Ações: [s]tart  [d]one  [e]dit  [v]iew"
read -rn1 k
case "$k" in
  s) task start "$sel" ;;
  d) task done  "$sel" ;;
  e) task "$sel" modify ;;
  v) task "$sel" ;;
esac

