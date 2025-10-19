# This file is sourced once at login for login shells.
# It should contain commands that should run only once per login session.

# Set PATH for mise
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Load Zsh configuration
if [ -f "$HOME/.zshrc" ]; then
  source "$HOME/.zshrc"
fi
