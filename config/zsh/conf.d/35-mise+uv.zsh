# mise and uv configuration

# Ensure mise is activated
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Ensure uv is in PATH (mise should handle this, but as a fallback)
if command -v uv &> /dev/null; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
