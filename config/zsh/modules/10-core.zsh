# core.zsh — Core Zsh configurations

# --- Shell Options ---
setopt NO_HUP               # Keep background jobs running when shell exits
setopt AUTO_CD              # Change directory by typing its name
setopt HIST_IGNORE_DUPS     # Do not save duplicated commands in history
setopt HIST_FIND_NO_DUPS    # Do not show duplicated commands when searching history
setopt inc_append_history   # Append history incrementally
setopt SHARE_HISTORY        # Share history between all shell sessions

# --- History Settings (XDG-safe) ---
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000
mkdir -p "$(dirname "$HISTFILE")"

# --- Autocompletion System ---
autoload -Uz compinit

# Avoid slow reinitializations by using a cache if available.
if [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(N.mh+24) ]]; then
  compinit -i -C
else
  compinit -i
fi

# --- Automatic Virtual Environment Activation (chpwd hook) ---
# This function is called every time the current directory changes.
_auto_venv_activate() {
  local venv_path=".venv"
  local activate_script="${venv_path}/bin/activate"

  # If a virtual environment is currently active
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Check if moving OUT of the current virtual environment's directory
    if [[ "$PWD" != "$VIRTUAL_ENV"* ]]; then
      # Deactivate only if the deactivate function exists
      if type deactivate &>/dev/null; then
        deactivate
      else
        # Fallback if deactivate is not a function
        unset VIRTUAL_ENV
        hash -r # Clear command hash to ensure correct binaries are found
      fi
    fi
  fi

  # Check if a .venv exists in the current directory and activate it
  if [[ -d "$venv_path" && -f "$activate_script" ]]; then
    # Activate only if not already in this specific venv
    if [[ "$VIRTUAL_ENV" != "$(realpath $PWD/$venv_path)" ]]; then
      source "$activate_script"
      echo "🐍 [KORA] venv activated automatically."
    fi
  fi
}

# Add the function to the chpwd hook array
# This ensures it runs every time the directory changes.
chpwd_functions+=( _auto_venv_activate )
