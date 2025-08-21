#!/usr/bin/env zsh
# utils.zsh — Provides various utility functions for the KORA shell environment.

# sysinfo: Displays basic system and shell information.
sysinfo() {
  echo "OS: $(uname -s) $(uname -r)"
  echo "Shell: $ZSH_VERSION"
  echo "TERM: $TERM"
  command -v python >/dev/null && echo "Python: $(python --version 2>&1)"
  command -v node >/dev/null && echo "Node: $(node --version 2>&1)"
  command -v java >/dev/null && echo "Java: $(java -version 2>&1 | head -n1)"
}

# extract: Extracts common archive types.
# Arguments:
#   $1: Path to the archive file.
extract() {
  [[ -f "$1" ]] || { echo "File not found: $1"; return 1; }
  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "Unknown archive type: $1"; return 1 ;;
  esac
}


# _kora_auto_venv: Automatically activates a Python virtual environment if a .venv directory is found.
# This function is added to the chpwd hook.
_kora_auto_venv() {
  if [[ -f ".venv/bin/activate" && -z "$VIRTUAL_ENV" ]]; then
    source .venv/bin/activate
    echo "🐍 [KORA] venv activated automatically."
  fi
}
add-zsh-hook chpwd _kora_auto_venv

# venvoff: Alias to easily deactivate the current virtual environment.
alias venvoff='deactivate 2>/dev/null || echo "No active virtual environment."'

# karduino: Opens Arduino IDE in a new Kitty tab (if Kitty is detected).
karduino() {
  if command -v kitty >/dev/null 2>&1; then
    kitty @ launch --type=tab --title "Arduino IDE" arduino-ide &
  else
    arduino-ide &
  fi
}
alias karduino=karduino

# kserial: Opens Arduino serial monitor in a new tmux window (if tmux is running).
kserial() {
  if [ -n "$TMUX" ]; then
    tmux new-window -n "Serial" "arduino-cli monitor"
  else
    arduino-cli monitor
  fi
}
alias kserial=kserial

# kora-dev-env: Sets up a development environment in tmux with multiple windows for common tools.
# Arguments:
#   $1: Session name suffix.
kora-dev-env() {
  local session="dev-$1"
  tmux new-session -d -s "$session" -c "$PWD"
  tmux send-keys -t "$session:0" "nvim ." C-m
  tmux new-window -t "$session:" -n "lazygit" "lazygit"
  tmux new-window -t "$session:" -n "arduino" "arduino-ide"
  tmux attach -t "$session"
}
alias dev=kora-dev-env