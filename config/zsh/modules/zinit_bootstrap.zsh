# zinit_bootstrap.zsh — Zinit Plugin Manager Bootstrap
# Ensures Zinit is installed and sourced.

export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  print -P -- "%F{#F59E0B} baixando zinit...%f"
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" 2>/dev/null || true
fi
# shellcheck disable=SC1090
[[ -f "$ZINIT_HOME/zinit.zsh" ]] && source "$ZINIT_HOME/zinit.zsh"
