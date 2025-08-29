# keybinds.zsh — Custom keybindings for KORA shell.

# Ensure keybindings are only set in interactive shells.
if [[ $- != *i* ]]; then return 0; fi

bindkey -e # Emacs mode for keybindings.

# --- Basic Navigation and Editing ---
bindkey '^[[3~' delete-char          # Delete character under cursor.
bindkey '^[[H'   beginning-of-line    # Move cursor to the beginning of the line.
bindkey '^[[F'   end-of-line          # Move cursor to the end of the line.
bindkey '^[[1;5C' forward-word       # Move cursor one word forward (Ctrl + Right Arrow).
bindkey '^[[1;5D' backward-word      # Move cursor one word backward (Ctrl + Left Arrow).

# --- History Navigation ---
bindkey '^[[A' history-beginning-search-backward # Search backward in history from current input (Up Arrow).
bindkey '^[[B' history-beginning-search-forward # Search forward in history from current input (Down Arrow).

# --- Custom Widgets (FZF Integration) ---
# These widgets are defined in the completion_and_style.zsh module.
if command -v fzf >/dev/null 2>&1; then
  bindkey '^T' _kora_fzf_files    # Ctrl+T to fuzzy find files.
  bindkey '^R' _kora_fzf_history  # Ctrl+R to fuzzy find in history.
fi

# --- Custom Functions ---
bindkey '^o' kora-project # Ctrl+O to open the KORA project selector.