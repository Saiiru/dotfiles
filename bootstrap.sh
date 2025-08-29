#!/usr/bin/env bash
# KORA v4 - Dotfiles Bootstrap Script

# --- Color Palette ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'

# --- Helper Functions ---
_log() {
    echo -e "${C_BLUE}[KORA-BOOTSTRAP]${C_RESET} $1"
}

_success() {
    echo -e "${C_GREEN}[SUCCESS]${C_RESET} $1"
}

_warn() {
    echo -e "${C_YELLOW}[WARNING]${C_RESET} $1"
}

_error() {
    echo -e "${C_RED}[ERROR]${C_RESET} $1"
    exit 1
}

_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- Main Script ---

_log "Starting KORA dotfiles refactoring and installation..."

# --- Dependency Check ---
_log "Checking for essential dependencies..."
PACKAGES_TO_INSTALL=""

# List of essential packages
ESSENTIAL_PACKAGES=("zsh" "git" "curl" "eza" "bat" "fzf" "fd" "ripgrep" "btop" "neovim" "tmux" "kitty" "ghostty" "oh-my-posh" "lazygit" "mise")

for pkg in "${ESSENTIAL_PACKAGES[@]}"; do
    if ! _command_exists "$pkg"; then
        _warn "Dependency '$pkg' not found."
        PACKAGES_TO_INSTALL+="$pkg "
    fi
done

# --- Package Installation ---
if [[ -n "$PACKAGES_TO_INSTALL" ]]; then
    _log "Attempting to install missing packages..."
    if _command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y $PACKAGES_TO_INSTALL
    elif _command_exists dnf; then
        sudo dnf install -y $PACKAGES_TO_INSTALL
    elif _command_exists pacman; then
        # Assuming yay for AUR packages like oh-my-posh, ghostty, etc.
        if ! _command_exists yay; then
            _error "This script requires 'yay' AUR helper on Arch Linux to install all dependencies. Please install it first."
        fi
        yay -S --noconfirm $PACKAGES_TO_INSTALL
    elif _command_exists brew; then
        brew install $PACKAGES_TO_INSTALL
    else
        _error "Could not find a supported package manager (apt, dnf, pacman, brew). Please install dependencies manually: $PACKAGES_TO_INSTALL"
    fi
else
    _success "All essential dependencies are already installed."
fi

# --- Configuration Setup ---
_log "Setting up configuration files..."

# Define source and target directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Backup existing configs
_log "Backing up existing configurations to ${CONFIG_DIR}/_backup_kora..."
BACKUP_DIR="${CONFIG_DIR}/_backup_kora_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

CONFIGS_TO_BACKUP=("zsh" "oh-my-posh" "kitty" "ghostty" "tmux" "btop" "lazygit")
for cfg in "${CONFIGS_TO_BACKUP[@]}"; do
    if [[ -e "${CONFIG_DIR}/${cfg}" ]]; then
        mv "${CONFIG_DIR}/${cfg}" "${BACKUP_DIR}/${cfg}" >/dev/null 2>&1
        _log "Backed up ${cfg}."
    fi
done

# Symlink new configurations
_log "Creating symlinks for new KORA configurations..."

# The script assumes it is in the root of the dotfiles repo.
# It will symlink the .config directory from the repo to the user's home .config
# This is a simple approach. A more robust one would use `stow`.

# For this script, we will just ensure the files are in the right place.
# The user should have cloned the repo and be running this script from within it.

# Ensure target directories exist
mkdir -p "$CONFIG_DIR"

# Copy the new config files (assuming this script is in the dotfiles root)
cp -r "${DOTFILES_DIR}/.config/"* "${CONFIG_DIR}/"

_success "Configuration files have been placed in ${CONFIG_DIR}."

# --- Final Steps ---

# Change default shell to Zsh if it isn't already
if [[ "$SHELL" != *"zsh"* ]]; then
    _log "Changing default shell to Zsh. You may be prompted for your password."
    if chsh -s "$(which zsh)"; then
        _success "Default shell changed to Zsh."
    else
        _error "Failed to change shell. Please do it manually."
    fi
else
    _success "Zsh is already the default shell."
fi

# --- Bootstrap Instructions ---
_log "-------------------------------------------------"
_log "KORA v4 Bootstrap Complete!"
_log ""
_log "Instructions:"
_log "1. Create your grimoire background image at: ~/.config/assets/grimoire.png"
_log "2. Restart your terminal or start a new zsh session to load the new environment."
_log "3. Run 	mux" to start the new session."
_log "4. Enjoy your new tactical DevOps environment!"
_log "-------------------------------------------------"

