emulate -L zsh
typeset -g ZC="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZC"
fpath=("$ZC" $fpath)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit -u -d "$HOME/.zcompdump"