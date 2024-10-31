# ───── Inicialização ─────
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # Configura o Homebrew para macOS
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ───── Variáveis de Ambiente ─────
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$HOME/.pub-cache/bin:/home/$USER/.fnm"

# ───── Inicialização do FNM ─────
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# ───── Zinit ─────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ───── Plugins Zinit ─────
# zinit light romkatv/powerlevel10k  # Adicione se quiser usar
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

# ───── Completions ─────
autoload -Uz compinit && compinit

# ───── Estilos de Completions ─────
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ───── Configurações de Histórico ─────
export HISTSIZE=5000
export HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ───── Keybindings ─────
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ───── Aliases ─────
alias ls='ls'
alias vim='nvim'
alias c='clear'

# ───── Integrações do Shell ─────
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ───── Finaliza ─────
zinit cdreplay -q

