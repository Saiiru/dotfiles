# Completions do Zsh

# Inicializa o sistema de completions
autoload -Uz compinit
compinit -C
# Bindings de teclas
bindkey '^k' vi-up-line-or-history
bindkey '^j' vi-down-line-or-history
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^ ' autosuggest-accept
bindkey -v '^?' backward-delete-char
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -s '^r' '^usource ~/.config/zsh/.zshrc\n'

# Função para controlar jobs em background
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# Usar lf para mudar de diretórios
lfcd () {
  tmp="$(mktemp)"
  lfub -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    cd "$dir" || return
  fi
}

