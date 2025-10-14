emulate -L zsh
set -o pipefail
unsetopt EXTENDED_GLOB
typeset -g ZNAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/znap"
[[ -d "$ZNAP_DIR" ]] || git clone --depth=1 https://github.com/marlonrichert/zsh-snap.git "$ZNAP_DIR"
source "$ZNAP_DIR/znap.zsh"
if [[ -r /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
else
  znap source zsh-users/zsh-completions
fi
znap source Aloxaf/fzf-tab