# Compleções: fora do repo, rápidas e consistentes
emulate -L zsh

# Onde o gen_completions.sh grava
typeset -g COMPDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"

# compdump no $HOME para não sujar o repo
typeset -g ZSH_COMPDUMP="$HOME/.zcompdump-${HOST}-${ZSH_VERSION}"

# fpath: prioriza nossas completions cacheadas
if [[ -d "$COMPDIR" ]]; then
  fpath=($COMPDIR $fpath)
fi

# zsh/complist para seleção com setas
zmodload -i zsh/complist 2>/dev/null

# Estilos úteis
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$COMPDIR/.zcompcache"

# fzf-tab (se presente) melhora o UI de completion
if [[ -n ${options[zle]} ]] && typeset -f _fzf_tab_completion >/dev/null; then
  zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border --info=inline
  zstyle ':fzf-tab:*' switch-group 'alt-h' 'alt-l'
fi

# Inicialização performática
autoload -Uz compinit
# -d: usa compdump definido; -C: evita checagem pesada de timestamp
compinit -C -d "$ZSH_COMPDUMP"
