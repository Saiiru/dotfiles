if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS="
    --color=bg+:#1A1A2E,bg:#0A0A0F,spinner:#8B5CF6,hl:#00CED1
    --color=fg:#B0B0C0,header:#8B5CF6,info:#00CED1,pointer:#8B5CF6
    --color=marker:#00FF7F,fg+:#E0E0F0,prompt:#8B5CF6,hl+:#00E5FF
    --height=40% --layout=reverse --border=sharp --margin=1
    --preview 'bat --style=numbers --color=always --line-range :200 {}'
    --preview-window=right:50%:wrap
    --bind='ctrl-u:preview-up,ctrl-d:preview-down'
    --bind='ctrl-f:preview-page-down,ctrl-b:preview-page-up'
  "
  export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
