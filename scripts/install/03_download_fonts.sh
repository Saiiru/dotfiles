#!/usr/bin/env bash
set -euo pipefail

# --- Font Download Script --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

FONT_LIST_FILE="$SCRIPTS_DIR/package_lists/fonts_list.txt"
DEST_DIR="$HOME/dotfiles/.fonts"

main() {
    print_header "Downloading Fonts"

    mkdir -p "$DEST_DIR"

    if [ ! -f "$FONT_LIST_FILE" ]; then
        warning "Font list file '$FONT_LIST_FILE' not found. Skipping font download."
        return
    fi

    info "Reading font list from '$FONT_LIST_FILE'..."
    local fonts_to_download
    fonts_to_download=$(grep -vE '^\s*#|^\s*$' "$FONT_LIST_FILE")

    if [ -z "$fonts_to_download" ]; then
        warning "No fonts listed for download. Skipping."
        return
    fi

    info "Attempting to download the following fonts:"
    gum style --padding "0 1" "$(echo "$fonts_to_download" | fmt -w 80)"
    echo

    for font_name in $fonts_to_download; do
        local download_url=""
        local dest_file="$DEST_DIR/$font_name"

        if [ -f "$dest_file" ]; then
            info "Font '$font_name' already exists in '$DEST_DIR'. Skipping download."
            continue
        fi

        case "$font_name" in
            # Nerd Fonts (assuming latest release from GitHub)
            *NerdFont*.ttf) 
                # Example for 3270 Nerd Font
                if [[ "$font_name" == "3270NerdFont"* ]]; then
                    download_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/3270/complete/${font_name}"
                fi
                ;;
            # Cascadia Code (from Microsoft GitHub)
            CascadiaCode*.ttf|CascadiaCodePL*.ttf) 
                download_url="https://github.com/microsoft/cascadia-code/raw/main/ttf/${font_name}"
                ;;
            # Cascadia Mono (from Microsoft GitHub)
            CascadiaMono*.ttf|CascadiaMonoPL*.ttf) 
                download_url="https://github.com/microsoft/cascadia-code/raw/main/ttf/${font_name}"
                ;;
            # Font Awesome (from Font Awesome GitHub)
            fa-*.ttf) 
                download_url="https://github.com/FortAwesome/Font-Awesome/raw/6.x/webfonts/${font_name}"
                ;;
            # Specific fonts that might need direct URLs or manual placement
            Audiowide) download_url="https://fonts.google.com/download?family=Audiowide" ;;
            Roboto) download_url="https://fonts.google.com/download?family=Roboto" ;;
            # Add more specific URLs here if known
            *) 
                warning "No direct download URL known for '$font_name'. Please place it manually in '$DEST_DIR' or update the script."
                continue
                ;;
        esac

        if [ -n "$download_url" ]; then
            spin "Downloading '$font_name'..." "curl -L -o \"$dest_file\" \"$download_url\""
            if [ $? -eq 0 ]; then
                success "Downloaded '$font_name'."
            else
                error "Failed to download '$font_name' from '$download_url'."
            fi
        fi
    done

    success "Font download process complete."
}

main
