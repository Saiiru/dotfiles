[[ -f "$ZDOTDIR/plugin.zsh" ]] && source "$ZDOTDIR/plugin.zsh"
for f in "$ZDOTDIR/conf.d/"*.zsh; do [[ -f "$f" ]] && source "$f"; done
for f in "$ZDOTDIR/functions/"*.zsh; do [[ -f "$f" ]] && source "$f"; done
for f in "$ZDOTDIR/completions/"*.zsh; do [[ -f "$f" ]] && source "$f"; done