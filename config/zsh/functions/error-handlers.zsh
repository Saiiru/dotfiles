emulate -L zsh
function TRAPZERR() {
  printf '\n[%s] erro: %s\n' "$0" "$ZSH_COMMAND" >&2
}