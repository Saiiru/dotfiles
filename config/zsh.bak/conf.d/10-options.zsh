emulate -L zsh
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY INC_APPEND_HISTORY EXTENDED_HISTORY HIST_REDUCE_BLANKS
setopt INTERACTIVE_COMMENTS
unsetopt BEEP

export EDITOR=nvim
bindkey -v
export KEYTIMEOUT=1
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line