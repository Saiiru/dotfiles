#!/usr/bin/env bash
set -euo pipefail

# --- Symlink Configuration Directories --- #

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
    print_header "Creating Configuration Symlinks"

    # Neovim
    create_symlink "$DOTFILES_CONFIG_DIR/nvim" "$HOME/.config/nvim" "Neovim config"

    # Hyprland
    create_symlink "$DOTFILES_CONFIG_DIR/hypr" "$HOME/.config/hypr" "Hyprland config"

    # Kitty
    create_symlink "$DOTFILES_CONFIG_DIR/kitty" "$HOME/.config/kitty" "Kitty config"

    # Rofi
    create_symlink "$DOTFILES_CONFIG_DIR/rofi" "$HOME/.config/rofi" "Rofi config"

    # Waybar
    create_symlink "$DOTFILES_CONFIG_DIR/waybar_configs" "$HOME/.config/waybar" "Waybar config"

    # Wlogout
    create_symlink "$DOTFILES_CONFIG_DIR/wlogout" "$HOME/.config/wlogout" "Wlogout config"

    # Fuzzel
    create_symlink "$DOTFILES_CONFIG_DIR/fuzzel" "$HOME/.config/fuzzel" "Fuzzel config"

    # Mako
    create_symlink "$DOTFILES_CONFIG_DIR/mako" "$HOME/.config/mako" "Mako config"

    # Ghostty
    create_symlink "$DOTFILES_CONFIG_DIR/ghostty" "$HOME/.config/ghostty" "Ghostty config"

    # Cava
    create_symlink "$DOTFILES_CONFIG_DIR/cava" "$HOME/.config/cava" "Cava config"

    # Matugen
    create_symlink "$DOTFILES_CONFIG_DIR/matugen" "$HOME/.config/matugen" "Matugen config"

    # Mise
    create_symlink "$DOTFILES_CONFIG_DIR/mise" "$HOME/.config/mise" "Mise config"

    # Qt5ct
    create_symlink "$DOTFILES_CONFIG_DIR/qt5ct" "$HOME/.config/qt5ct" "Qt5ct config"

    # Qt6ct
    create_symlink "$DOTFILES_CONFIG_DIR/qt6ct" "$HOME/.config/qt6ct" "Qt6ct config"

    # Zathura
    create_symlink "$DOTFILES_CONFIG_DIR/zathura" "$HOME/.config/zathura" "Zathura config"

    # Zsh
    create_symlink "$DOTFILES_CONFIG_DIR/zsh" "$HOME/.config/zsh" "Zsh config"

    # Taskwarrior
    create_symlink "$DOTFILES_CONFIG_DIR/taskwarrior" "$HOME/.config/taskwarrior" "Taskwarrior config"

    success "All configuration symlinks processed."
}

main
