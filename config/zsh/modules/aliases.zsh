#!/usr/bin/env zsh
# aliases.zsh — KORA · Arcane Ops

# ── Core Utility ──────────────────────────────────────────────────────────────
alias ls='eza --icons --color=always --group-directories-first'
alias la='eza -la --icons --color=always --group-directories-first'
alias ll='eza -l --icons --color=always --group-directories-first'
alias cat='bat --style=plain --paging=never'
alias grep='rg'
alias find='fd'
alias top='btop'
alias ps='procs'

# ── Dir Nav ───────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# ── Git ───────────────────────────────────────────────────────────────────────
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

# ── Editors ───────────────────────────────────────────────────────────────────
alias vi='nvim'
alias vim='nvim'
alias code='codium'

# ── Python ────────────────────────────────────────────────────────────────────
alias py='python'
alias pip='python -m pip'

# ── Docker ────────────────────────────────────────────────────────────────────
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'

# ── Shell Mgmt ────────────────────────────────────────────────────────────────
alias h='history'
alias c='clear'
alias bye='exit'                         # era `q=exit` → conflita com funções q/qs...
alias reload='exec zsh'
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'

# ── Arduino ───────────────────────────────────────────────────────────────────
alias arduino-ide='arduino-ide'
alias arcli='arduino-cli'
alias arduinoprojects='cd $PROJECTS_DIR/arduino'

# ── KORA / sgpt Roles ─────────────────────────────────────────────────────────
alias kora-tui='~/.config/kora/scripts/kora-tui.sh'
alias kora-core='sgpt --role kora-core'
alias karch='sgpt --role arch'
alias ksairu='sgpt --role sairu'
alias klabs='sgpt --role labs'
alias kora-fast='sgpt --model gpt-4o-mini --role kora-core'

# ── Taskwarrior · OP-1 Quests ─────────────────────────────────────────────────
# Protege nomes das funções
unalias q  qs  qd  qt 2>/dev/null

# Short-hands
q(){ task add "$@"; }          # q "desc" xp:40 diff:normal energy:mid est:20min +study
qs(){ task start "$@"; }       # qs 12
qd(){ task done "$@"; }        # qd 12
qt(){ task today; task quests; }

# Callbacks estilo OP-1
setup-op1(){ # ⌬ Setup
  mkdir -p ~/.config/task/hooks ~/.cache/arcane
  # Corrige legado: se 'data' for ARQUIVO, salva backup e cria diretório
  if [[ -f ~/.config/task/data ]]; then
    mv ~/.config/task/data ~/.config/task/data.bak.$(date +%s)
  fi
  mkdir -p ~/.config/task/data
  chmod +x ~/.config/task/hooks/* 2>/dev/null || true
  echo "⌬ Setup OK."
}

micro(){ # /micro energy:low foco:deep
  local energy="${1:-energy:low}"
  q "✦ Deep work 20m: fechar pendência pequena" xp:40 diff:easy "$energy" est:20min +ops
  q "⚝ Inbox zero: triagem 20 emails/msgs"     xp:30 diff:easy "$energy" est:20min +ops
  q "⌬ Manutenção: atualizar dotfiles 1 commit" xp:35 diff:normal "$energy" est:25min +code
  qt
}

sprint7(){ # /sprint 7d
  for d in 1 2 3 4 5 6 7; do
    q "DO #$d · sessão foco 25m + log" xp:35 diff:easy energy:mid est:25min +ops
  done
  echo "⌬ Sprint semeada."
}

unclog(){ # /unclog
  task status:pending limit:5 sort:urgency- \
    rc.report.tmp.columns=id,description,project,urgency rc.report.tmp.labels=ID,Quest,Proj,Urg tmp
  echo "→ Para cada uma: defina a próxima ação de 1 passo e ≤25min."
}

today(){ # /today
  task today
  echo "→ Execute 1 micro-quest agora. Regra: ≤25min. Se maior: diff:hard + aviso."
}

