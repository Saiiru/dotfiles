# Zsh options

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt hist_verify
setopt share_history
setopt extended_glob
setopt no_beep

# Case-insensitive completion
setopt CASE_SENSITIVE=false

# Correct spelling of commands
setopt CORRECT

# Automatically remove superfluous blanks from history lines
setopt HIST_REDUCE_BLANKS

# Don't write duplicates in the history file
setopt HIST_IGNORE_ALL_DUPS

# Append history lines rather than overwriting the history file
setopt APPEND_HISTORY

# Share history between all sessions
setopt SHARE_HISTORY

# Enable completion with TAB
autoload -Uz compinit
compinit
