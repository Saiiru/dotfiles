# ~/.config/zsh/.zshrc
# This file is managed by Gemini Agent.
# It sources the modularized Zsh configuration files.

# Enable prompt substitution, required for some themes.
setopt prompt_subst

# Source all module files in the correct order.
if [ -d "$ZDOTDIR/modules" ]; then
    for f in "$ZDOTDIR"/modules/*.zsh; do
        [ -f "$f" ] && source "$f"
    done
fi

# Source all function files.
if [ -d "$ZDOTDIR/modules/functions" ]; then
    for f in "$ZDOTDIR"/modules/functions/*.zsh; do
        [ -f "$f" ] && source "$f"
    done
fi

# Source all mkproj archetype files.
if [ -d "$ZDOTDIR/modules/functions/mkproj" ]; then
    for f in "$ZDOTDIR"/modules/functions/mkproj/*.zsh; do
        [ -f "$f" ] && source "$f"
    done
fi
