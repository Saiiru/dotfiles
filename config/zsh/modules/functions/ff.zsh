#!/usr/bin/env zsh
# ff.zsh — Fuzzy file opener with preview for KORA.

# ff: Opens a fuzzy finder (fzf) to select a file, then opens the selected file in the editor.
ff() {
  command -v fzf >/dev/null 2>&1 || { print "Error: fzf not installed. Please install fzf to use this function."; return 1; }
  local file
  file=$(fd --type f --hidden --exclude .git 2>/dev/null | fzf --preview 'bat --style=header,grid --color=always --line-range :300 {}' --height=60%)
  [[ -n $file ]] && ${EDITOR:-nvim} "$file"
}