# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added a config file for you to customize HyDE before loading zshrc
# Edit $ZDOTDIR/.user.zsh to customize HyDE before loading zshrc

#  Plugins 
# oh-my-zsh plugins are loaded  in $ZDOTDIR/.user.zsh file, see the file for more information

#  Aliases 
# Override aliases here in '$ZDOTDIR/.zshrc' (already set in .zshenv)

# # Helpful aliases
# alias c='clear'                                                        # clear terminal
# alias l='eza -lh --icons=auto'                                         # long list
# alias ls='eza -1 --icons=auto'                                         # short list
# alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
# alias ld='eza -lhD --icons=auto'                                       # long list dirs
# alias lt='eza --icons=auto --tree'                                     # list folder as tree
# alias un='$aurhelper -Rns'                                             # uninstall package
# alias up='$aurhelper -Syu'                                             # update system/package/aur
# alias pl='$aurhelper -Qs'                                              # list installed package
# alias pa='$aurhelper -Ss'                                              # list available package
# alias pc='$aurhelper -Sc'                                              # remove unused cache
# alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
# alias vc='code'                                                        # gui code editor
# alias fastfetch='fastfetch --logo-type kitty'

# # Directory navigation shortcuts
# alias ..='cd ..'
# alias ...='cd ../..'
# alias .3='cd ../../..'
# alias .4='cd ../../../..'
# alias .5='cd ../../../../..'

# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
# alias mkdir='mkdir -p'

#  This is your file 
# Add your configurations here
# export EDITOR=nvim
export EDITOR=code
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

# unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager

# bun completions
[ -s "/home/sairu/.bun/_bun" ] && source "/home/sairu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
