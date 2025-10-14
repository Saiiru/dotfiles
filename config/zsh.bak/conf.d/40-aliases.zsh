emulate -L zsh
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1  --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

alias ..='cd ..'; alias ...='cd ../..'
alias .3='cd ../../..'; alias .4='cd ../../../..'; alias .5='cd ../../../../..'

alias gs='git status -sb'; alias ga='git add -A'; alias gc='git commit -m'; alias gp='git push'; alias gl='git log --oneline --graph --decorate -20'
