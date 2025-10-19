#!/usr/bin/env bash
set -euo pipefail

# --- Symlink Configuration Files --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

DOTFILES_CONFIG_DIR="$HOME/dotfiles/config"

create_symlink() {
    local source_path="$1"
    local dest_path="$2"
    local description="$3"

    if [ ! -e "$source_path" ]; then
        warning "Source path '$source_path' does not exist. Skipping symlink for $description."
        return 1
    fi

    if [ -L "$dest_path" ] && [ "$(readlink "$dest_path")" == "$source_path" ]; then
        info "Symlink for $description already exists and is correct: '$dest_path' -> '$source_path'. Skipping."
        return 0
    fi

    if [ -e "$dest_path" ]; then
        warning "Existing file/directory found at '$dest_path'. Moving to backup: '$dest_path.bak'."
        mv "$dest_path" "$dest_path.bak"
    fi

    spin "Creating symlink for $description: '$dest_path' -> '$source_path'..." "ln -sf \"$source_path\" \"$dest_path\""
    success "Symlink created for $description."
}

main() {
    print_header "Creating Configuration File Symlinks"

    # Tmux
    create_symlink "$DOTFILES_CONFIG_DIR/tmux/tmux.conf" "$HOME/.tmux.conf" "Tmux config file"

    # Zsh (if not using ~/.config/zsh)
    # create_symlink "$DOTFILES_CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc" "Zsh RC file"
    # create_symlink "$DOTFILES_CONFIG_DIR/zsh/.zshenv" "$HOME/.zshenv" "Zsh ENV file"
    # create_symlink "$DOTFILES_CONFIG_DIR/zsh/.zprofile" "$HOME/.zprofile" "Zsh Profile file"

    # Starship (if not using ~/.config/starship)
    # create_symlink "$DOTFILES_CONFIG_DIR/starship.toml" "$HOME/.config/starship.toml" "Starship config file"

    success "All configuration file symlinks processed."
}

main
