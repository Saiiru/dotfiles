# ───── Inicialização ─────
# Definir o diretório do Oh My Zsh
# export ZSH="$HOME/.oh-my-zsh"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
# Tema Darkblood
# ZSH_THEME="custom/kali"

# Inicializar o Homebrew (somente no macOS)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ───── Variáveis de Ambiente ─────
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$HOME/.pub-cache/bin"

# ───── Inicialização do NVM (Node Version Manager) ─────
export NVM_DIR="$HOME/.nvm"

# Instalação do NVM caso não esteja instalado
if [ ! -d "$NVM_DIR" ]; then
  echo "NVM não encontrado. Instalando..."
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR" && git checkout v0.39.3  # versão estável
  \. "$NVM_DIR/nvm.sh"  # Carregar o NVM
  echo "NVM instalado com sucesso!"
else
  echo "NVM já está instalado."
  \. "$NVM_DIR/nvm.sh"  # Carregar o NVM
fi

# Garantir que o NVM seja carregado corretamente
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"  # Carregar o NVM
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  \. "$NVM_DIR/bash_completion"  # Completação de bash do NVM
fi

# Função para carregar versões do Node.js a partir do arquivo .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Revertendo para a versão padrão do NVM"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ───── Zinit (Gerenciador de Plugins) ─────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ───── Plugins Zinit ─────
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zap-zsh/supercharge
zinit light zap-zsh/exa
zinit light gasech/simplest-prompt
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light junegunn/fzf

# ───── Snippets ─────
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# ───── Configurações Gerais ─────
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 21

# Definir opções de Zsh
CASE_SENSITIVE="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="false"

# ───── Histórico ─────
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
export HISTSIZE=100000
export SAVEHIST=100000
export HISTDUP=erase
setopt APPENDHISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# ───── Teclas de Atalho ─────
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
setopt NO_BEEP
setopt auto_cd
setopt no_flow_control
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# ───── Configuração do Shell ─────
export LANG=en_US.UTF-8

# ───── Plugins de Autocompletação ─────
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2

# ───── Aliases ─────
alias :q="exit"
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'
alias vi="nvim"
alias vim="nvim"

# Git Aliases
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'

# Docker Aliases
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Kubernetes Aliases
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kc="kubectx"
alias kns="kubens"
alias ke="kubectl exec -it"

# ───── Finalização ─────
echo "Bem-vindo, $USER!"
