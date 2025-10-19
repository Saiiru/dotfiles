# This file is sourced for all shells, including non-interactive ones.
# It should contain commands that set up the environment, like PATH.

# Set ZDOTDIR to point to our dotfiles Zsh config directory
export ZDOTDIR="$HOME/.config/zsh"

# Set PATH for mise (if not already set by .zprofile for login shells)
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Load Zsh configuration
if [ -f "$ZDOTDIR/.zshrc" ]; then
  source "$ZDOTDIR/.zshrc"
fi
