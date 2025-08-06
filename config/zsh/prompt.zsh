#!/usr/bin/env zsh
# ╔═══════════════════════════════════════════════════════════════════════════
# 龍 KORA PROMPT :: CYBERPUNK NEON HUD - CLEAN VERSION
# ╚═══════════════════════════════════════════════════════════════════════════

# Cyberpunk Neon Colors (ultra-vibrant)
KORA_PURPLE="%F{171}"    # #D975FC (brighter purple)
KORA_CYAN="%F{51}"       # #00FFFF (bright cyan)
KORA_BLUE="%F{39}"       # #61AFEF (electric blue)
KORA_GREEN="%F{118}"     # #5DFF35 (neon green)
KORA_RED="%F{203}"       # #FF5C7A (hot pink/red)
KORA_YELLOW="%F{226}"    # #FFFF00 (bright yellow)
KORA_MAGENTA="%F{201}"   # #FF00FF (magenta)
KORA_ORANGE="%F{214}"    # #FFAD00 (bright orange)
KORA_WHITE="%F{255}"     # #FFFFFF (pure white)
KORA_GRAY="%F{244}"      # #808080 (medium gray)
KORA_RESET="%f"

# Cyberpunk Icons (nerd font required)
ICON_USER="龍"            # Dragon kanji
ICON_FOLDER="󰉋"          # Folder icon
ICON_GIT="󰊢"            # Git branch
ICON_PYTHON="󰌠"          # Python
ICON_NODE="󰎙"            # Node.js - MANTENDO
ICON_RUST=""            # Rust - MANTENDO
ICON_GO="󰟓"              # Go - MANTENDO
ICON_JAVA=""            # Java - MANTENDO
ICON_TIME="󰥔"            # Timer/clock
ICON_CLOCK="󱑎"           # Digital clock
ICON_SSH="󰢹"             # Network/remote
ICON_ARROW="❯"           # Command arrow - connected style

# Git information setup with enhanced formatting
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Configure git status display with cyberpunk colors - SÓ BRANCH, SEM STATUS
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "${KORA_PURPLE}[${ICON_GIT} ${KORA_CYAN}%b${KORA_PURPLE}]${KORA_RESET}"
zstyle ':vcs_info:git:*' actionformats "${KORA_PURPLE}[${ICON_GIT} ${KORA_CYAN}%b${KORA_RED}|%a${KORA_PURPLE}]${KORA_RESET}"

# Custom path with home directory symbol instead of ~
kora_path() {
  local path_str="${PWD/#$HOME/⌂}"
  if [[ "$path_str" == "⌂" ]]; then
    echo "${KORA_PURPLE}[${KORA_BLUE}⌂${KORA_PURPLE}]${KORA_RESET}"
  else
    echo "${KORA_PURPLE}[${ICON_FOLDER} ${KORA_BLUE}${path_str}${KORA_PURPLE}]${KORA_RESET}"
  fi
}

# Language/environment detection functions - MANTENDO TODAS
is_node_project() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/package.json" ]]; then return 0; fi
    dir="$(dirname "$dir")"
  done
  return 1
}

is_rust_project() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/Cargo.toml" ]]; then return 0; fi
    dir="$(dirname "$dir")"
  done
  return 1
}

is_go_project() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/go.mod" ]]; then return 0; fi
    dir="$(dirname "$dir")"
  done
  return 1
}

# Virtual environment display (Python/Conda)
kora_env_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "${KORA_GREEN}[${ICON_PYTHON} $(basename "$VIRTUAL_ENV")]${KORA_RESET}"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    echo "${KORA_GREEN}[${ICON_PYTHON} ${CONDA_DEFAULT_ENV}]${KORA_RESET}"
  fi
}

# SSH connection indicator
kora_ssh_info() {
  [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && echo "${KORA_YELLOW}${ICON_SSH} ${KORA_RESET}"
}

# Command execution duration
kora_cmd_duration() {
  [[ -n $KORA_CMD_DURATION && $KORA_CMD_DURATION -gt 2 ]] && echo "${KORA_PURPLE}[${KORA_YELLOW}${ICON_TIME} ${KORA_CMD_DURATION}s${KORA_PURPLE}]${KORA_RESET}"
}

# Language environment indicators - MANTENDO TODAS
kora_node_info() {
  if command -v node &>/dev/null && is_node_project; then
    local node_version=$(node -v 2>/dev/null | sed 's/v//')
    [[ -n "$node_version" ]] && echo "${KORA_GREEN}[${ICON_NODE} ${node_version}]${KORA_RESET}"
  fi
}

kora_rust_info() {
  if command -v rustc &>/dev/null && is_rust_project; then
    local rust_version=$(rustc --version 2>/dev/null | cut -d ' ' -f 2)
    [[ -n "$rust_version" ]] && echo "${KORA_ORANGE}[${ICON_RUST} ${rust_version}]${KORA_RESET}"
  fi
}

kora_go_info() {
  if command -v go &>/dev/null && is_go_project; then
    local go_version=$(go version 2>/dev/null | cut -d ' ' -f 3 | sed 's/go//')
    [[ -n "$go_version" ]] && echo "${KORA_BLUE}[${ICON_GO} ${go_version}]${KORA_RESET}"
  fi
}

kora_java_info() {
  if command -v java &>/dev/null && [[ -n "$JAVA_HOME" ]]; then
    local java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    [[ -n "$java_version" ]] && echo "${KORA_RED}[${ICON_JAVA} ${java_version}]${KORA_RESET}"
  fi
}

# Command timing and error tracking
preexec() { KORA_CMD_START=$SECONDS; }
precmd() {
  RETVAL=$?
  if [[ -n $KORA_CMD_START ]]; then
    KORA_CMD_DURATION=$((SECONDS - KORA_CMD_START))
    unset KORA_CMD_START
  else
    unset KORA_CMD_DURATION
  fi
  vcs_info
}

# PROMPT COM INDICADORES DE LINGUAGEM, SEM GIT STATUS DETALHADO
PROMPT='${KORA_PURPLE}╭─[${KORA_RESET}$(kora_ssh_info)${KORA_MAGENTA}${ICON_USER} ${KORA_CYAN}%n${KORA_GRAY}@${KORA_CYAN}%m${KORA_PURPLE}]${KORA_RESET}$(kora_env_info)$(kora_node_info)$(kora_rust_info)$(kora_go_info)$(kora_java_info)$(kora_path)${vcs_info_msg_0_}$(kora_cmd_duration)
${KORA_PURPLE}╰─%(?:${KORA_PURPLE}:${KORA_RED})${ICON_ARROW}${KORA_RESET} '

# Minimal right prompt with time
RPROMPT='${KORA_PURPLE}[${KORA_CYAN}${ICON_CLOCK} %D{%H:%M:%S}${KORA_PURPLE}]${KORA_RESET}'

# Create a properly formatted ASCII art logo
print_kora_logo() {
  print -P "${KORA_PURPLE}    ╦╔═╔═╗╦═╗╔═╗    ${KORA_CYAN}╔═╗╦ ╦╔═╗╔╦╗╔═╗╔╦╗"
  print -P "${KORA_PURPLE}    ║║║ ║╠╦╝╠═╣    ${KORA_CYAN}╚═╗╚╦╝╚═╗ ║ ║╣ ║║║"
  print -P "${KORA_PURPLE}    ╝╚╚═╝╩╚═╩ ╩    ${KORA_CYAN}╚═╝ ╩ ╚═╝ ╩ ╚═╝╩ ╩"
  print -P ""
  print -P "${KORA_WHITE}           [ ${KORA_MAGENTA}NEURAL${KORA_BLUE}-${KORA_CYAN}INTERFACE${KORA_BLUE}-${KORA_GREEN}ONLINE${KORA_WHITE} ]"
  print -P "${KORA_CYAN}╔═════════════════════════════════════════════╗"
  print -P "${KORA_CYAN}║ ${KORA_GREEN}DATE${KORA_RESET}: 2025-08-05   ${KORA_GREEN}TIME${KORA_RESET}: 13:37:29  ${KORA_CYAN}║"
  print -P "${KORA_CYAN}║ ${KORA_GREEN}USER${KORA_RESET}: Saiiru       ${KORA_GREEN}HOST${KORA_RESET}: archsairu      ${KORA_CYAN}║"
  print -P "${KORA_CYAN}╚═════════════════════════════════════════════╝"
  print -P "${KORA_PURPLE}:: Perception · Precision · Protocol ::${KORA_RESET}"
  print -P ""
  print -P "${KORA_CYAN}:: KORA Neural Interface ${KORA_PURPLE}Activated${KORA_RESET}"
}

# Store the function for the startup script to call
export KORA_LOGO_FUNC=print_kora_logo
