# completion_and_style.zsh — Centralized configuration for Zsh completions, FZF, and syntax highlighting.

# --- Zsh Completion Styling ---
autoload -Uz compinit
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{141}-- %d --%f'
zstyle ':completion:*:messages' format '%F{51}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{196}-- No matches found --%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"
zstyle ':completion:*:corrections' format '%F{220}-- %d (errors: %e) --%f'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' group-order aliases builtins functions commands

# --- Zsh Syntax Highlighting Styles ---
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#EF4444,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#22D3EE,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#10B981,underline'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#10B981,underline'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#10B981,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#10B981,underline'
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#F59E0B'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#F59E0B'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#F59E0B'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#7C3AED'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#7F849C,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='none'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#10B981'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#EF4444,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#3B82F6,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#10B981,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#7C3AED,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#F59E0B,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#22D3EE,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

# --- FZF and fzf-tab Styling and Widgets ---
# Configures FZF and fzf-tab behavior and styling, including custom widgets for file and history search.
if command -v fzf >/dev/null 2>&1; then
  zstyle ':fzf-tab:*' fzf-flags --color=fg:#CDD6F4,bg:#0A0E27,hl:#7C3AED,fg+:#0A0E27,bg+:#7C3AED,hl+:#CDD6F4
  zstyle ':fzf-tab:*' fzf-command fzf
  zstyle ':fzf-tab:*' fzf-preview 'bat --style=numbers --color=always --line-range :300 {}'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always --level=3 $realpath'
  zstyle ':fzf-tab:complete:kill:*' fzf-preview 'ps -f -p $word'

  _kora_fzf_files() {
    local preview_cmd file
    preview_cmd='bat --color=always --style=header,grid --line-range :300 {}'
    file=$(fd --type f --hidden --follow --exclude .git . | fzf --height=60% --layout=reverse --border --prompt="📁 Files: " --preview="$preview_cmd")
    [[ -n $file ]] && LBUFFER+="$file" && zle redisplay
  }
  zle -N _kora_fzf_files

  _kora_fzf_history() {
    local sel
    sel=$(fc -rl 1 | fzf --height=60% --layout=reverse --border --prompt="⏱️ History: " --query="$LBUFFER" | sed 's/^ *[0-9]* *//')
    [[ -n $sel ]] && LBUFFER="$sel" && zle redisplay
  }
  zle -N _kora_fzf_history
fi

# --- Zsh Autosuggestions Styling ---
# Customizes the appearance and behavior of autosuggestions.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7C3AED'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# --- Zoxide Initialization ---
# Initializes Zoxide for smart directory navigation.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi