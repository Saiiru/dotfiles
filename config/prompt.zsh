# ╔════════════════════════════════════════════════════════════════════════╗
# ║  KORA DRAGON CYBERPUNK ZSH PROMPT · FULL INTEGRAÇÃO (Runner, LSP, tmux, lazygit, pyenv, git) ║
# ╚═══════════════════════════════════════════════════════════════════════╝

autoload -Uz colors && colors

# --- Color Palette (Neon/Cyberpunk/NerdFont)
C_RESET='%f%k'
C_PRIMARY='%F{141}'     # Deep Purple
C_CYAN='%F{51}'         # Neon Cyan
C_GREEN='%F{118}'       # Neon Green
C_PINK='%F{213}'        # Neon Pink
C_YELLOW='%F{220}'      # Bright Yellow
C_RED='%F{196}'         # Red
C_BLUE='%F{39}'         # Blue
C_GRAY='%F{244}'
C_WHITE='%F{15}'

# --- Icons
ICON_DRAGON=""
ICON_FIRE=""
ICON_SCALE=""
ICON_LINK=""
ICON_NODE=""
ICON_KEY=""
ICON_QBIT=""
ICON_BRANCH=""
ICON_PYTHON=""
ICON_NODEJS=""
ICON_REACT=""
ICON_NEXT="󰡄"
ICON_JAVA=""
ICON_RUST=""
ICON_GO=""
ICON_DOCKER=""
ICON_DIRTY=""
ICON_CLEAN=""
ICON_UP=""
ICON_DOWN=""
ICON_SERVER=""
ICON_STATUS_OK="✓"
ICON_STATUS_FAIL="✗"
ICON_TIME=""
ICON_VENV=""
ICON_PROMPT="─"

# --- Project Context Icon
kora_project_icon() {
  [[ -f package.json ]] && grep -q '"react"' package.json 2>/dev/null && echo "$ICON_REACT" && return
  [[ -f package.json ]] && grep -q '"next"' package.json 2>/dev/null && echo "$ICON_NEXT" && return
  [[ -f package.json ]] && echo "$ICON_NODEJS" && return
  [[ -f pyproject.toml || -f requirements.txt || -f Pipfile ]] && echo "$ICON_PYTHON" && return
  [[ -f Cargo.toml ]] && echo "$ICON_RUST" && return
  [[ -f go.mod ]] && echo "$ICON_GO" && return
  [[ -f Dockerfile || -f docker-compose.yml ]] && echo "$ICON_DOCKER" && return
  [[ -f pom.xml || -f build.gradle* ]] && echo "$ICON_JAVA" && return
  echo "$ICON_LINK"
}

# --- Python Environment Info (pyenv or venv)
kora_python_env() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local pyver=""
    [[ -x "$VIRTUAL_ENV/bin/python" ]] && pyver=$("$VIRTUAL_ENV/bin/python" --version 2>/dev/null | cut -d' ' -f2 | cut -d. -f1,2)
    echo "${C_GREEN}${ICON_PYTHON} ${pyver}${C_RESET}"
    return
  fi
  if command -v pyenv &>/dev/null; then
    local pyenv_version="$(pyenv version-name 2>/dev/null)"
    [[ -n "$pyenv_version" && "$pyenv_version" != "system" ]] && echo "${C_GREEN}${ICON_PYTHON} $pyenv_version${C_RESET}"
  fi
}

# --- mise/pyenv/asdf versions (multi-language, short)
kora_version_info() {
  if command -v mise &>/dev/null; then
    local pyv=$(mise current python 2>/dev/null | awk '{print $2}' | head -1)
    local nodev=$(mise current node 2>/dev/null | awk '{print $2}' | head -1)
    local javav=$(mise current java 2>/dev/null | awk '{print $2}' | head -1)
    local text=""
    [[ $pyv ]]   && text+="py:$pyv "
    [[ $nodev ]] && text+="node:$nodev "
    [[ $javav ]] && text+="java:$javav"
    [[ $text ]] && echo "${C_CYAN}$text${C_RESET}"
  fi
}

# --- Git Status: branch, dirty, ahead/behind, staged, untracked, stashed
kora_git_status() {
  command -v git >/dev/null && git rev-parse --is-inside-work-tree &>/dev/null || return
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local dirty="" staged="" untracked="" stashed="" ahead="" behind=""
  git diff --quiet --ignore-submodules --cached || staged=" ${C_GREEN}${C_RESET}"
  [[ -n $(git status --porcelain 2>/dev/null | grep '^??') ]] && untracked=" ${C_PINK}${C_RESET}"
  [[ -n $(git status --porcelain 2>/dev/null | grep -v '^??') ]] && dirty=" ${C_YELLOW}${ICON_DIRTY}${C_RESET}"
  git rev-parse --verify refs/stash >/dev/null 2>&1 && stashed=" ${C_BLUE}${C_RESET}"
  if git rev-parse --abbrev-ref @{upstream} &>/dev/null; then
    local ahead_behind=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if [[ "$ahead_behind" == *$'\t'* ]]; then
      local ab_ahead ab_behind; ab_behind=$(cut -f1 <<<"$ahead_behind"); ab_ahead=$(cut -f2 <<<"$ahead_behind")
      (( ab_ahead > 0 )) && ahead=" ${C_CYAN}${ICON_UP}${ab_ahead}${C_RESET}"
      (( ab_behind > 0 )) && behind=" ${C_RED}${ICON_DOWN}${ab_behind}${C_RESET}"
    fi
  fi
  echo "${C_YELLOW}${ICON_BRANCH} $branch${dirty}${staged}${untracked}${stashed}${ahead}${behind}${C_RESET}"
}

# --- Timer and Exit Code Status (robusto para ambientes sem 'date')
typeset -g _kora_cmd_start_time=""
typeset -g _kora_last_exit_code=0

kora_preexec_hook() {
  if command -v date &>/dev/null; then
    _kora_cmd_start_time=$(date +%s 2>/dev/null)
  else
    _kora_cmd_start_time=""
  fi
}

kora_precmd_hook() {
  _kora_last_exit_code=$?
  case "$TERM" in
    xterm*|rxvt*|tmux*|screen*)
      print -Pn "\033]0;%n@%m:%~\007"
      ;;
  esac
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec kora_preexec_hook
add-zsh-hook precmd kora_precmd_hook

kora_exec_time() {
  [[ -n "$_kora_cmd_start_time" ]] || return
  if command -v date &>/dev/null; then
    local end_time=$(date +%s 2>/dev/null)
    local duration=$((end_time - _kora_cmd_start_time))
    if (( duration > 2 )); then
      echo " ${C_YELLOW}${ICON_TIME} ${duration}s${C_RESET}"
    fi
  fi
  _kora_cmd_start_time=""
}

kora_exit_status() {
  [[ $_kora_last_exit_code -ne 0 ]] && echo " ${C_RED}${ICON_STATUS_FAIL} $_kora_last_exit_code${C_RESET}"
}

# --- Host/SSH/Root Context
kora_host_symbol() {
  [[ $UID -eq 0 ]] && echo "${C_YELLOW}${C_RESET}" && return
  [[ -n "$SSH_CONNECTION" ]] && echo "${C_PINK}${ICON_NODE}${C_RESET}" && return
  echo "${C_GREEN}${ICON_DRAGON}${C_RESET}"
}

# --- Prompt Runner/LazyGit/Kitty/Tmux/LSP Integration helpers ---
alias kora-run="kora-run.sh"
alias kora-lazygit="tmux new-window -n lazygit 'lazygit'"
alias kora-lsp="nvim ."
alias kora-tmux="tmux"
alias kora-kitty="kitty"

# --- Main Prompt Function
kora_build_prompt() {
  local user_host="[${C_PRIMARY}%n${C_GRAY}@${C_PINK}%m${C_GRAY}]"
  local path="[${C_CYAN}$(kora_project_icon) %~${C_GRAY}]"
  local pyenv_info=""
  local git_info=""
  local version_info=""
  pyenv_info="$(kora_python_env)"
  version_info="$(kora_version_info)"
  git_info="$(kora_git_status)"
  [[ -n "$pyenv_info" ]] && pyenv_info=" - [${pyenv_info}]"
  [[ -n "$version_info" ]] && version_info=" - [${version_info}]"
  [[ -n "$git_info" ]] && git_info=" - [${git_info}]"

  local exec_time="$(kora_exec_time)"
  local exit_status="$(kora_exit_status)"
  local host_symbol="$(kora_host_symbol)"

  # Top line: [user@host] - [project path] - [pyenv] - [mise] - [git] {timer} {exit}
  local top_line="${C_GRAY}┌──${user_host}-${path}${pyenv_info}${version_info}${git_info}${exec_time}${exit_status}"

  local bottom_line="${C_GRAY}└${ICON_PROMPT}${C_RESET} "
  echo "$top_line"$'\n'"$bottom_line"
}

setopt PROMPT_SUBST
PROMPT='$(kora_build_prompt)'
RPROMPT=''

# --- Continuation prompts
PS2="${C_GRAY}└${ICON_PROMPT}${C_RESET} "
PS3="${C_CYAN}Select: ${C_RESET}"
PS4="${C_GRAY}+${C_CYAN}%N${C_GRAY}:${C_BLUE}%i${C_GRAY}> ${C_RESET}"
