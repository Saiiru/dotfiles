# _helpers.zsh — Provides utility functions for the mkproj script.

# _kora_log: Displays a styled log message for mkproj operations.
_kora_log() {
    gum style --foreground "$KORA_PRIMARY" "[KORA]" "$1"
}

# _kora_spin: Displays a styled spinner during mkproj operations.
_kora_spin() {
    gum spin --spinner dot --title "$1" -- sleep 0.5
}