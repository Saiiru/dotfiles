# env.zsh — Environment variables and paths for KORA

# --- Essential Configurations ---
export EDITOR="nvim"
export TERMINAL="kitty"
export LANG="en_US.UTF-8"
export LC_ALL="$LANG"

# --- XDG Base Directories ---
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

# --- Path Management ---
# Adds user's local binaries to PATH.
# Mise handles paths for development tools (Node.js, Python, etc.).
export PATH="$HOME/.local/bin:$PATH"

# --- Zsh History File ---
export HISTFILE="$HOME/.local/share/zsh/history"

# --- NPM Global Package Prefix ---
export NPM_CONFIG_PREFIX="$HOME/.local"

# --- KORA Color Definitions (for scripts and themes) ---
export KORA_PRIMARY="#7C3AED"
export KORA_CYAN="#22D3EE"
export KORA_GREEN="#10B981"
export KORA_PINK="#EC4899"
export KORA_YELLOW="#F59E0B"
export KORA_RED="#EF4444"
export KORA_VOID="#0A0E27"
export KORA_SURFACE="#1A1F29"
export KORA_TEXT="#CDD6F4"
export KORA_MUTED="#7F849C"
