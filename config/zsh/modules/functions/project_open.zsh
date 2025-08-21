#!/usr/bin/env zsh
# project_open.zsh — Fuzzy project opener for KORA.

# kora-project: Navigates to, opens, and connects to tmux/Neovim sessions for projects.
kora-project() {
  local project_path session_name

  # Uses fd to find project folders (with .git or node_modules).
  project_path=$(fd --type d --max-depth 2 -E .git -E node_modules . $HOME/workspace | fzf --no-border --prompt='📁 Select Project: ' --height=40% --preview "ls -l {}")

  if [[ -n "$project_path" ]]; then
    session_name=$(basename "$project_path" | tr . _)

    # Attempts to connect to an existing tmux session.
    tmux has-session -t "$session_name" 2>/dev/null
    if [ $? != 0 ]; then
      # If no session exists, creates a new one with Neovim.
      tmux new-session -s "$session_name" -d -c "$project_path" "nvim ."
    fi

    # Connects to the session.
    tmux attach-session -t "$session_name"
  fi
}

# Binds the function to a key (e.g., Ctrl + o).
bindkey '^o' kora-project