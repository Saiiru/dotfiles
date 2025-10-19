# fzf helper functions

# fkill - kill process
fkill() {
  local pid 
  if [ "$(ps -ef | sed 1d | fzf -m | awk '{print $2}')" ]; then
    for pid in $(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    do
      kill -9 "$pid"
    done
  fi
}

# fcd - cd into directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m)
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

