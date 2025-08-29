# prompt.zsh — Configures the shell prompt for KORA, with Oh My Posh and a fallback.

# Path to the Oh My Posh theme configuration.
KORA_OMP_CONFIG="$HOME/dotfiles/config/oh-my-posh/kora-cyberpunk.omp.json"

# Initialize Oh My Posh if available.
# Prefers system oh-my-posh binary.
if command -v oh-my-posh >/dev/null 2>&1 && [[ -f "$KORA_OMP_CONFIG" ]]; then
  # Initialize Oh My Posh for Zsh.
  eval "$(oh-my-posh init zsh --config "$KORA_OMP_CONFIG")"
else
  # Fallback: Simple prompt using KORA colors if Oh My Posh is not available.
  autoload -Uz colors # Ensure colors are loaded.
  colors # Initialize colors.
  PS1="%F{#7C3AED}┌─%f%F{#CDD6F4}%n%f%F{#7C3AED}(@%m)%f
%F{#7C3AED}└─%f%F{#CDD6F4}%~ %f%F{#7C3AED}$%f "
fi

# Helper function: Exposes the number of pending tasks to the prompt (non-blocking).
_kora_task_count() {
  command -v task >/dev/null 2>&1 || { echo ""; return; }
  local c
  c=$(task status:pending count 2>/dev/null) || c=0
  [[ $c -gt 0 ]] && echo "⚑${c}"
}
# This function can be easily integrated into an Oh My Posh segment.