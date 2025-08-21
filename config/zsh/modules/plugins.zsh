# plugins.zsh — Zinit plugin manager and plugin list for KORA

# Zinit Bootstrap: Ensures Zinit is installed and sourced for efficient plugin management.
export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  print -P -- "%F{#F59E0B}Downloading Zinit...%f"
  command mkdir -p "$(dirname "$ZINIT_HOME")"
  command git clone --quiet --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" >/dev/null 2>&1
fi
# shellcheck disable=SC1090
[[ -f "$ZINIT_HOME/zinit.zsh" ]] && source "$ZINIT_HOME/zinit.zsh"

# Plugin List: Core plugins for enhanced shell functionality.
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf-bin
zinit light ajeetdsouza/zoxide

# Syntax Highlighting: Loaded last for optimal performance.
zinit wait lucid for atload'ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern); ZSH_HIGHLIGHT_STYLES[comment]=fg=#7F849C' zsh-users/zsh-syntax-highlighting

# FZF Integration: Helper scripts for FZF key-bindings and completion.
if command -v fzf >/dev/null 2>&1; then
  [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
  [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
fi

# Zoxide Integration: Initializes Zoxide for smart directory navigation.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Autosuggestions Styling: Customizes the appearance and behavior of autosuggestions.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7C3AED'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Completion and FZF-tab Styling: Consolidated styling for completions and fzf-tab.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"
zstyle ':completion:*' list-colors "di=34:fi=0:ln=36:pi=35:so=32:bd=33:cd=33:or=31:mi=5:ex=1:*.zsh=38;5;213"
zstyle ':fzf-tab:*' fzf-flags --color=fg:#CDD6F4,bg:#0A0E27,hl:#7C3AED,fg+:#0A0E27,bg+:#7C3AED,hl+:#CDD6F4
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-preview 'bat --style=numbers --color=always --line-range :300 {}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always --level=3 $realpath'
zstyle ':fzf-tab:complete:kill:*' fzf-preview 'ps -f -p $word'
# Plugin loading performance report: Displays Zinit loading time for debugging.
if [[ "$KORA_DEBUG" == "1" ]]; then
  local zinit_end=$SECONDS
  local zinit_time=$((zinit_end - zinit_start))
  print -P "%F{#22D3EE}🐉 KORA: Plugin system loaded in ${zinit_time}ms%f"
fi
