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
