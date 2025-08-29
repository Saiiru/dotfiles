#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════════════
# 🚀 STARTUP SEQUENCE
# ═══════════════════════════════════════════════════════════════════════════

# Display system info if available
if command -v fastfetch &>/dev/null; then
  fastfetch
elif command -v neofetch &>/dev/null; then
  neofetch
fi

# Display the KORA ASCII art using the function
if typeset -f "$KORA_LOGO_FUNC" >/dev/null; then
  $KORA_LOGO_FUNC
fi

# Auto-activate Python environment if in project directory
if typeset -f "auto_activate_venv" >/dev/null; then
  auto_activate_venv 2>/dev/null
fi

# KORA NEURAL MATRIX - Tmux Session Management
# -----------------------------------------------------------------------------
# Esta função verifica se uma sessão do tmux já existe e se conecta a ela.
# Se não existir, uma nova sessão é criada.

function kora_tmux_attach() {
  # Verifica se o tmux está disponível
  if ! command -v tmux >/dev/null 2>&1; then
    echo "󰣇 KORA: tmux não encontrado. Instalando..."
    # Você pode adicionar o comando de instalação aqui, se desejar.
    # Exemplo: sudo apt install tmux
    return 1
  fi

  # Nome da sessão principal
  local session_name="main"

  # Anexa-se à sessão 'main' se ela existir, caso contrário, cria uma nova.
  echo "󰣇 KORA: Tentando anexar à sessão neural '$session_name'..."
  tmux new-session -A -s "$session_name"
}

# Se o terminal não estiver dentro do tmux, inicia a sessão
if [[ -z "$TMUX" ]]; then
  kora_tmux_attach
fi
