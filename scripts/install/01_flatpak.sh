#!/usr/bin/env bash
set -euo pipefail

# --- Flatpak Package Installation --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

main() {
    print_header "Installing Flatpak Packages"

    if ! command_exists flatpak; then
        error "'flatpak' not found. Please install it first."
        exit 1
    fi

    local pkg_list_file="$SCRIPTS_DIR/package_lists/flatpak_pkg_list.txt"

    if [ ! -f "$pkg_list_file" ]; then
        warning "Flatpak package list not found at '$pkg_list_file'. Skipping."
        exit 0
    fi

    info "Reading Flatpak package list..."

    # Read file line by line, skipping comments and empty lines
    while IFS= read -r app_id || [[ -n "$app_id" ]]; do
        # Skip empty lines and comments
        if [[ "$app_id" =~ ^\s*# ]] || [[ -z "$app_id" ]]; then
            continue
        fi

        # Check if the app is already installed
        if flatpak list --app --columns=application | grep -q "^${app_id}$"; then
            info "Flatpak app '$app_id' is already installed. Skipping."
        else
            if confirm "Install Flatpak app '$app_id'?"; then
                spin "Installing '$app_id'..." "flatpak install -y flathub $app_id"
                success "Installed '$app_id'."
            else
                warning "Skipped installation of '$app_id'."
            fi
        fi
    done < "$pkg_list_file"

    success "Flatpak package installation process complete."
}

main
