emulate -L zsh
TRAPZERR(){ printf '\n[Zsh] erro: %s\n' "$ZSH_COMMAND" >&2; }