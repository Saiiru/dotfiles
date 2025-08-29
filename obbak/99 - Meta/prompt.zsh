#!/usr/bin/env zsh
# KORA VEGA SYSTEM - Prompt - BLUE-VEGA (v2.3 - Refinado)
# -------------------------------------------------------------
# Prompt dual-line com colchetes e cores unificadas.

# Cores do Tema (Ciano Unificado)
c_blue="%F{#00e0ff}"
c_gray="%F{#52525B}"
c_reset="%f"

# Símbolos Nerd Font
icon_user="󰠔"
icon_project_default=""
icon_git="󰊢"
icon_ssh="󰒢"
icon_success="λ"
icon_fail=""
icon_in_progress="…"
icon_duration=""

# Variáveis de estado
_start_time=0
_end_time=0
_last_exit_code=0
_is_preexec=0

# --- Hooks para Indicador de Status e Duração ---
function kora_preexec_hook() {
  _start_time=$(($(date +%s%N) / 1000000))
  _is_preexec=1
  print -n "\n╰─${c_blue}${icon_in_progress}${c_reset} "
}

function kora_precmd_hook() {
  _end_time=$(($(date +%s%N) / 1000000))
  _last_exit_code=$?
  _is_preexec=0

  tput cuu1
  tput el
}

# Adiciona os hooks para o prompt
autoload -Uz add-zsh-hook
add-zsh-hook preexec kora_preexec_hook
add-zsh-hook precmd kora_precmd_hook

# --- Funções do Prompt ---
function project_icon() {
  local project_icon_char="${icon_project_default}"
  if [ -f "package.json" ]; then
    project_icon_char="󰎙"
  elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    project_icon_char=""
  elif [ -f "pom.xml" ] || [ -d "src/main/java" ]; then
    project_icon_char=""
  elif [ -f "tsconfig.json" ]; then
    project_icon_char=""
  fi
  echo "${c_blue}${project_icon_char}${c_reset}"
}

function kora_prompt_top_left() {
  local user_host_part="${c_blue}${icon_user}${c_reset} %n@%m"
  local project_part="$(project_icon)"
  local dir_part="%2~"
  local git_branch=""
  local git_part=""
  local ssh_part=""

  if [[ -n "$SSH_CLIENT" ]]; then ssh_part="${c_blue}${icon_ssh} "; fi
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$git_branch" == "main" ]]; then
      git_part="${c_gray}[${c_blue}${icon_git} ${git_branch}${c_gray}]"
    else
      git_part="${c_gray}[${c_blue}${icon_git} ${git_branch}${c_gray}]"
    fi
  fi

  echo -n "${c_gray}╭─${ssh_part}(${c_blue}%n@%m${c_gray})-(${project_part}${c_blue}${dir_part}${c_gray})${git_part}"
}

function kora_prompt_time_duration() {
  local time_part="${c_blue}%* ${c_gray}─╮"
  local duration_part=""

  if [[ "$_end_time" -ne 0 ]] && [[ "$_start_time" -ne 0 ]]; then
    local duration=$((_end_time - _start_time))
    if [[ "$duration" -gt 2000 ]]; then
      duration_part="${c_blue}${icon_duration} ${duration}ms "
    fi
  fi
  echo -n "${duration_part}${time_part}"
}

function kora_prompt_bottom() {
  local status_icon=""
  if [[ "$_last_exit_code" == 0 ]]; then status_icon="${icon_success}"; else status_icon="${icon_fail}"; fi
  echo -n "${c_gray}╰─${c_blue}${status_icon}${c_reset} "
}

# --- Configura o Prompt ---
PROMPT="$(kora_prompt_top_left)%F{${c_gray}}
$(kora_prompt_bottom)"
RPROMPT="$(kora_prompt_time_duration)"
