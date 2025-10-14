emulate -L zsh
fh() { print -z -- "$(fc -rl 1 | awk '{$1=""; sub(/^ /,""'); print}' | fzf)"; }
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf | awk '{print $2}') || return
  kill -${1:-9} "$pid"
}