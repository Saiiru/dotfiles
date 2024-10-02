# Zsh Configuration File
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Define o PATH com diretórios pessoais
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/home/sairu/.spicetify"
export PATH="$PATH:/home/sairu/dotfiles/scripts/"
export DENO_INSTALL="/home/sairu/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# NVM: Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carrega nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carrega bash_completion do nvm
[[ -f /usr/share/bash-preexec/bash-preexec.sh ]] && source /usr/share/bash-preexec/bash-preexec.sh

# Exports
HISTFILE="${ZDOTDIR}/history"
HISTSIZE=1000000
SAVEHIST=1000000

export TERMINAL="kitty"
export PDF_VIEWER="zathura"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="/usr/bin/firefox-developer-edition"
export FILE_BROWSER="thunar"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"

export SHLVL=0
export GPG_TTY=$(tty)
export OPENSSL_DIR="/usr/lib/ssl"
export TZ="America/Sao_Paulo"

export JDTLS_HOME=""
export NOTES_DIR="${HOME}/Documents/school-notes"
export CURRENT_GRADE="${NOTES_DIR}/College"
export ROOT="${NOTES_DIR}/College/Year-2/semester-1"
export CURRENT_COURSE="${NOTES_DIR}/current-course"

# Exports adicionais no PATH
export PATH="${PATH}:${HOME}/.local/share/sairu/third-party-tools/instant-reference/"
export PATH="${PATH}:${HOME}/.local/share/cargo/bin"
export PATH="${PATH}:${HOME}/.local/share/gem/ruby/3.0.0/bin"

# Plugins com Zinit
# Adicionando plugins
zinit light zsh-users/zsh-completions
zinit light zap-zsh/supercharge
zinit light zap-zsh/exa
zinit light gasech/simplest-prompt
zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf
# Plugins com Zinit
zinit light zsh-users/zsh-autosuggestions

# Configurações do zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # cor da sugestão

# Bindings
bindkey '^[[C' autosuggest-accept  # Aceita sugestão com seta direita

# Inicializa o Oh My Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

# Carrega opções do Zsh
# source ~/.config/zsh/options.zsh

# Carrega completions do Zsh
source ~/.config/zsh/options.zsh
source ~/.config/zsh/completions.zsh
# source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/hooks.zsh
# Finaliza a configuração do Zsh

