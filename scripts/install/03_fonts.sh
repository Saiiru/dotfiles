#!/usr/bin/env bash
set -euo pipefail

# --- Font Installation --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

FONT_DIR="$HOME/.local/share/fonts"
FONT_LIST_FILE="$SCRIPTS_DIR/package_lists/fonts_list.txt"
DOTFILES_FONTS_DIR="$HOME/dotfiles/.fonts"

main() {
    print_header "Installing Fonts"

    # First, ensure fonts are downloaded
    info "Ensuring fonts are downloaded..."
    bash "$SCRIPTS_DIR/install/03_download_fonts.sh"

    if [ ! -d "$DOTFILES_FONTS_DIR" ]; then
        warning "Source font directory '$DOTFILES_FONTS_DIR' not found. Skipping font installation."
        return
    fi

    if [ ! -f "$FONT_LIST_FILE" ]; then
        warning "Font list file '$FONT_LIST_FILE' not found. Skipping font installation."
        return
    fi

    info "Creating font directory: $FONT_DIR"
    mkdir -p "$FONT_DIR"

    info "Reading font list from '$FONT_LIST_FILE'..."
    local fonts_to_install
    fonts_to_install=$(grep -vE '^\s*#|^\s*$' "$FONT_LIST_FILE")

    if [ -z "$fonts_to_install" ]; then
        warning "No fonts listed for installation. Skipping."
        return
    fi

    info "The following fonts will be installed:"
    gum style --padding "0 1" "$(echo "$fonts_to_install" | fmt -w 80)"
    echo

    if confirm "Proceed with font installation?"; then
        for font_file in $fonts_to_install; do
            local src_path="$DOTFILES_FONTS_DIR/$font_file"
            local dest_path="$FONT_DIR/$font_file"

            if [ -f "$src_path" ]; then
                if [ -f "$dest_path" ]; then
                    info "Font '$font_file' already exists in destination. Skipping."
                else
                    spin "Installing font '$font_file'..." "cp -f \"$src_path\" \"$FONT_DIR\""
                    success "Installed '$font_file'."
                fi
            else
                warning "Source font file '$src_path' not found. Skipping '$font_file'."
            fi
        done

        spin "Updating font cache..." "fc-cache -fv"
        success "Font cache updated."
        success "Font installation complete."
    else
        warning "Font installation cancelled by user."
    fi
}

main
