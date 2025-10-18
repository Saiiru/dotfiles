#!/usr/bin/env bash

# Helper functions for logging and UI, using gum

# --- Gum Check ---
# This check is now handled by the main install.sh script for bootstrapping.
# If gum is not found here, it means the main script failed to install it.
if ! command -v gum &> /dev/null; then
    echo "Error: gum is not installed. This script requires gum." >&2
    exit 1
fi

# --- Logging Functions ---
info() {
    gum style --foreground 212 "[INFO]" "$*"
}

success() {
    gum style --foreground 42 "[SUCCESS]" "$*"
}

warning() {
    gum style --foreground 214 "[WARNING]" "$*"
}

error() {
    gum style --foreground 196 --bold "[ERROR]" "$*" >&2
}

# --- Header Function ---
print_header() {
    gum style --border double --margin "1" --padding "1" --border-foreground 212 "$*"
}

# --- Utility Functions ---

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Ask for confirmation, but skip if FORCE_YES is true
confirm() {
    if [[ "${FORCE_YES:-false}" == "true" ]]; then
        return 0 # Automatically confirm
    fi
    gum confirm "$@"
}

# Run a command with a spinner
spin() {
    local title="$1"
    shift
    local cmd="$@"
    gum spin --spinner dot --title "$title" -- /bin/bash -c "$cmd"
}
