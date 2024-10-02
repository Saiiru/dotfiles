################################################################################
#                                                                              #
#                                   Aliases                                     #
#                                                                              #
################################################################################

# General aliases
alias b='bash'
alias z='zsh'
alias c='clear'
alias e='exit'
alias minecraft='java -jar '$HOME/.local/bin/minecraft.jar''
alias reloud='clear && source '$HOME/.config/zsh/.zshrc''
alias l='lfub'
alias grep='grep --color'
alias mkdir='nocorrect mkdir --parents'
alias cp='nocorrect cp -iv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -vI'
alias ip="ip -4 -o a | cut -d ' ' -f 2,7 | cut -d '/' -f 1"
alias distro='source /etc/lsb-release && source /etc/os-release && echo "Main Distro: $ID_LIKE. Sub Distro: $DISTRIB_ID"'
alias svn="svn --config-dir \"$XDG_CONFIG_HOME\"/subversion"
alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
alias wgs="nocorrect watch git status"

# Update aliases for Arch and Artix Linux
if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
  alias update='sudo pacman -Syu'
  if command -v yay &> /dev/null; then
    alias updatey='yay -Syu'
  fi
fi

# Installed programs aliases
if command -v git &> /dev/null; then
  alias g='git'
  alias cg='clear && git status'
fi
if command -v gnuplot &> /dev/null; then
  alias gplot='cp -r '$XDG_CONFIG_HOME/gnuplot/gnuplotrc' '$HOME/.gnuplot'; gnuplot; rm -rf '$HOME/.gnuplot''
fi
if command -v yarn &> /dev/null; then
  alias yarn='yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config''
fi
if command -v abook &> /dev/null; then
  alias abook='abook --config '$XDG_CONFIG_HOME/abook/abookrc' --datafile '$XDG_DATA_HOME/abook/addressbook''
fi
if command -v calcurse &> /dev/null; then
  alias c='calcurse'
fi
if command -v mariadb &> /dev/null; then
  alias msr='mariadb -u root -p'
  alias mss="mariadb -u=$(get-password 'programming/mariadb/account-1' 'account') -p=\"$(get-password 'programming/mariadb/account-1')\""
fi
if command -v ncmpcpp &> /dev/null; then
  alias n='ncmpcpp'
fi
if command -v hugo &> /dev/null; then
  alias hss='hugo server --noHTTPCache'
  alias hssd='hugo server --noHTTPCache --buildDrafts'
fi
if command -v tmux &> /dev/null; then
  alias t='tmux'
  alias tn='tmux new'
  alias ta='tmux attach'
fi

# Custom aliases for development
alias dev="cd ~/dev"
alias pyenv="pyenv virtualenvwrapper"
alias workon="workon"
alias workoff="deactivate"
alias venv="source venv/bin/activate"

