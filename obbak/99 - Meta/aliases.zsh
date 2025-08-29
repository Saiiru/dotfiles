#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════════════
# 🔧 ALIASES
# ═══════════════════════════════════════════════════════════════════════════

# Modern file operations
if command -v exa &>/dev/null; then
  alias ls='exa --icons --color=always'
  alias ll='exa -alF --icons --color=always --git'
  alias la='exa -a --icons --color=always'
  alias l='exa -F --icons --color=always'
  alias tree='exa --tree --icons --color=always'
else
  alias ll='ls -alF --color=always'
  alias la='ls -a --color=always'
  alias l='ls -F --color=always'
fi

# Enhanced file operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# Modern alternatives
command -v bat &>/dev/null && alias cat='bat --style=numbers --color=always'
command -v rg &>/dev/null && alias grep='rg --color=always'
command -v fd &>/dev/null && alias find='fd'
command -v procs &>/dev/null && alias ps='procs'
command -v btop &>/dev/null && alias top='btop'
command -v duf &>/dev/null && alias df='duf'
command -v dust &>/dev/null && alias du='dust'

# Editor shortcuts
command -v nvim &>/dev/null && alias vi='nvim' && alias vim='nvim'

# Git enhanced
alias gst='git status'
alias gp='git push'
alias gpl='git pull'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
alias gl='git log --oneline --graph --decorate'
