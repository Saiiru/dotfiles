emulate -L zsh
bindkey '^R'  fzf-history-widget
bindkey '^T'  fzf-file-widget
bindkey '^[c' fzf-cd-widget
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char