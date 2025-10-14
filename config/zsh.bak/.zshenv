# XDG + ZDOTDIR
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# PATH básico
export PATH="$HOME/.local/bin:$PATH"
