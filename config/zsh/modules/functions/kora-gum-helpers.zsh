# kora-gum-helpers.zsh — Centralized functions for Gum styling and interactive prompts in KORA.

# _kora_log: Displays a styled log message.
_kora_log() {
    gum style --foreground "$KORA_PRIMARY" "[KORA]" "$1"
}

# _kora_spin: Displays a styled spinner for ongoing operations.
_kora_spin() {
    gum spin --spinner dot --title "$1" -- sleep 0.5
}

# _kora_confirm: Presents a styled confirmation prompt.
_kora_confirm() {
    local prompt_text="$1"
    gum confirm "$prompt_text" \
        --affirmative "Sim" \
        --negative "Não" \
        --selected.foreground "$KORA_GREEN" \
        --unselected.foreground "$KORA_RED"
}

# _kora_input: Prompts for user input with custom styling.
_kora_input() {
    local placeholder_text="$1"
    local header_text="$2"
    gum input \
        --placeholder "$placeholder_text" \
        --header "$header_text" \
        --cursor.foreground "$KORA_CYAN" \
        --prompt.foreground "$KORA_YELLOW" \
        --width 50
}

# _kora_choose: Presents a styled selection menu for multiple choices.
_kora_choose() {
    local header_text="$1"
    shift
    local choices=("$@")
    gum choose \
        --header "$header_text" \
        --cursor.foreground "$KORA_CYAN" \
        --selected.foreground "$KORA_GREEN" \
        --item.foreground "$KORA_TEXT" \
        --height 15 \
        "${choices[@]}"
}