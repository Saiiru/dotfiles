# Modularização KORA
# Garante que ZDOTDIR esteja definido para XDG compliance.
export ZDOTDIR="$HOME/.config/zsh"

# Carrega os módulos na ordem especificada.
for f in env core plugins; do # Source env, core, and plugins first
  [ -f "$ZDOTDIR/modules/$f.zsh" ] && source "$ZDOTDIR/modules/$f.zsh"
done

# Source all files in the functions directory
if [[ -d "$ZDOTDIR/modules/functions" ]]; then
  for f in "$ZDOTDIR/modules/functions"/*.zsh(N); do
    source "$f"
  done
fi

# Continue sourcing the rest of the modules
for f in aliases keybinds completion_and_style spellbook prompt; do
  [ -f "$ZDOTDIR/modules/$f.zsh" ] && source "$ZDOTDIR/modules/$f.zsh"
done
alias arcane="~/.local/bin/arcane-tui.sh"
