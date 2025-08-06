#!/usr/bin/env zsh
# KORA NEURAL INTERFACE - BATMAN HUD (Modular)

# Create config directory if it doesn't exist
[[ -d $HOME/.config/zsh ]] || mkdir -p $HOME/.config/zsh

# Load core modules in proper order
for file in $HOME/.config/zsh/{theme,env,plugins,prompt,python,node,fzf,completion,aliases,kora,startup}.zsh; do
  [[ -f "$file" ]] && source "$file"
done

# Auto-detect Python environment in current directory
auto_activate_venv

PATH=~/.console-ninja/.bin:$PATH