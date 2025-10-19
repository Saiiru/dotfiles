# compdump no HOME
typeset -g ZCOMPDUMP="$HOME/.zcompdump-${HOST}-${ZSH_VERSION}"

# completar com menu, case-insensitive, descrições e cores
zmodload zsh/complist
fpath=($ZDOTDIR/completions $fpath)
autoload -Uz compinit
compinit -d "$ZCOMPDUMP" -i

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:messages'     format '%F{yellow}%d%f'
zstyle ':completion:*:warnings'     format '%F{red}no matches%f'
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2 numeric