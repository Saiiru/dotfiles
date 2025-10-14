# plugins focados em teclado com isolamento de opções
emulate -L zsh
unsetopt extendedglob bareglobqual kshglob
setopt no_nomatch

typeset -g ZNAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/znap"
[[ -d "$ZNAP_DIR" ]] || git clone --depth=1 https://github.com/marlonrichert/zsh-snap.git "$ZNAP_DIR"
source "$ZNAP_DIR/znap.zsh" 2>/dev/null || return 0

# Preferir pacotes do sistema se existirem; senão, buscar upstream
if [[ -r /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
else
  znap source zsh-users/zsh-completions
fi

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
else
  znap source zsh-users/zsh-autosuggestions
fi

# fzf-tab não existe no pacote oficial; use upstream
znap source Aloxaf/fzf-tab

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  znap source zsh-users/zsh-syntax-highlighting    # manter por último
fi

# widgets fzf e zoxide
command -v fzf >/dev/null 2>&1     && znap eval fzf    'fzf --zsh'
command -v zoxide >/dev/null 2>&1  && znap eval zoxide 'zoxide init zsh'

# fzf-tab ajustes
zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border --info=inline
zstyle ':fzf-tab:*' switch-group 'Alt-h' 'Alt-l'
zstyle ':fzf-tab:complete:*' insert-unambiguous yes

# autosuggestions: cor discreta
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# syntax-highlighting: paleta leve
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[comment]='fg=8'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=yellow'