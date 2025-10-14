emulate -L zsh
typeset -g OMP_CFG="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/kora-cyberpunk.omp.json"
if command -v oh-my-posh >/dev/null 2>&1 && [[ -r "$OMP_CFG" ]]; then
  eval "$(oh-my-posh init zsh --config "$OMP_CFG")"
else
  PROMPT='%n @%m %1~ %# '
fi