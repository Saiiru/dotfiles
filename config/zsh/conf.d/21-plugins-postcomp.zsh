emulate -L zsh
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
else
  znap source zsh-users/zsh-autosuggestions
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6cff00,bold'
if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  znap source zsh-users/zsh-syntax-highlighting
fi
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[comment]='fg=#7a7a7a'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00e5ff,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00a2ff'
ZSH_HIGHLIGHT_STYLES[command]='fg=#39ff14,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#ff2d95'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#9a6cff,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#7cff00'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#7cff00'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#ffd166'