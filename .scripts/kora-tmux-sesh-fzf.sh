#!/usr/bin/env bash
# KORA · Tmux Sesh FZF Picker (Minimal)
# This script is called by tmux.conf to provide fzf-based sesh selection.
# It prints the selected session name to stdout.

# Debugging: Redirect stderr to a file
exec 2>/tmp/kora-sesh-fzf-debug.log

echo "--- Script Start: $(date) ---"

# Ensure sesh is available
if ! command -v sesh &>/dev/null; then
    echo "Error: 'sesh' command not found. Please install sesh." >&2
    exit 1
fi

# Ensure fzf-tmux is available
if ! command -v fzf-tmux &>/dev/null; then
    echo "Error: 'fzf-tmux' command not found. Please install fzf-tmux." >&2
    exit 1
fi

# Default FZF colors (will be overridden by tmux.conf)
FZF_COLORS="--color border:#262533,input-border:#9A6CFF,preview-border:#262533,header-bg:-1,header-border:#9A6CFF,hl:#7CFF00,hl+:#7CFF00"

# Determine which sesh list command to use based on argument
SESH_LIST_CMD="sesh list --icons"
if [[ "$1" == "hide-duplicates" ]]; then
    SESH_LIST_CMD="sesh list --icons --hide-duplicates"
elif [[ "$1" == "root" ]]; then
    SESH_LIST_CMD="sesh list --icons --query \"$2\""
fi

echo "SESH_LIST_CMD: $SESH_LIST_CMD" >&2

# Execute fzf-tmux and print selected session
SELECTED_SESSION=$( 
    echo "Executing fzf-tmux command..." >&2
    eval "$SESH_LIST_CMD" | fzf-tmux -p 100%,100% --no-border \
        --ansi \
        --list-border \
        --no-sort --prompt '⚡  ' \
        "$FZF_COLORS" \
        --input-border \
        --header-border \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-b:abort' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
        --preview-window 'right:70%' \
        --preview 'sesh preview {}'
    echo "fzf-tmux command finished." >&2
)

echo "SELECTED_SESSION: '$SELECTED_SESSION'" >&2

# Connect to the selected session
if [[ -n "$SELECTED_SESSION" ]]; then
    echo "Attempting to connect to session: '$SELECTED_SESSION'" >&2
    sesh connect "$SELECTED_SESSION"
    CONNECT_EXIT_CODE=$?
    echo "sesh connect exit code: $CONNECT_EXIT_CODE" >&2
    exit $CONNECT_EXIT_CODE # Exit with the connect command's exit code
else
    echo "No session selected or fzf-tmux failed." >&2
    exit 2 # Indicate that no session was selected or an error occurred
fi