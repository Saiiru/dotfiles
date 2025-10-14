emulate -L zsh
command -v fzf >/dev/null 2>&1 && znap eval fzf 'fzf --zsh'
zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border --info=inline
zstyle ':fzf-tab:*' switch-group 'Alt-h' 'Alt-l'
zstyle ':fzf-tab:complete:*' insert-unambiguous yes