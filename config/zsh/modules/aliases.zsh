#!/usr/bin/env zsh
# aliases.zsh — Defines common and convenient shell aliases for KORA.

# --- Core Utility Aliases ---
alias ls='eza --icons --color=always --group-directories-first'
alias la='eza -la --icons --color=always --group-directories-first'
alias ll='eza -l --icons --color=always --group-directories-first'
alias cat='bat --style=plain --paging=never'
alias grep='rg'
alias find='fd'
alias top='btop'
alias ps='procs'

# --- Directory Navigation Aliases ---
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -' # Navigate to the previous directory

# --- Git Aliases ---
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias lg='lazygit'

# --- Editor Aliases ---
alias vi='nvim'
alias vim='nvim'
alias code='codium'

# --- Python Aliases ---
alias py='python'
alias pip='python -m pip'

# --- Docker Aliases ---
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'

# --- Shell Management Aliases ---
alias h='history'
alias c='clear'
alias q='exit'
alias reload='exec zsh' # Reloads the current Zsh session
alias zshrc='$EDITOR $ZDOTDIR/.zshrc' # Opens .zshrc in the default editor

# --- Arduino Aliases ---
alias arduino-ide='arduino-ide' # Launches Arduino IDE (if installed)
alias arcli='arduino-cli'       # Arduino CLI
alias arduinoprojects='cd $PROJECTS_DIR/arduino' # Navigates to Arduino projects directory

# --- KORA Spellbook Aliases (Taskwarrior Integration) ---
alias my-stats='~/dotfiles/spellbook/scripts/stats.sh' # View physical and mental attributes
alias summon='task add Spell_Type:Main' # Summon a new Main Spell
alias daily-spell='task add Spell_Type:Daily' # Summon a new Daily Spell
alias conclude='task done' # Conclude a spell and claim the Mana reward
alias sync-spellbook='task sync' # Sync the spellbook
alias my-quests='task next' # View your current quests and missions
alias kora='~/.config/kora/scripts/kora-tui.sh' # Launch KORA TUI
alias kp='kora-project'
