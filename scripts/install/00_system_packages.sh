#!/usr/bin/env bash
set -euo pipefail

# --- System Package Installation --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"

# --- Bootstrap gum ---
# We need gum for the helpers, so we ensure it's installed before sourcing them.
if ! command -v gum &> /dev/null; then
    echo "[BOOTSTRAP] 'gum' not found. Attempting to install it..."
    if ! command -v sudo &> /dev/null; then
        echo "[BOOTSTRAP-ERROR] 'sudo' not found. Please install 'gum' manually and rerun." >&2
        exit 1
    fi
    if ! sudo pacman -S --noconfirm --needed gum; then
        echo "[BOOTSTRAP-ERROR] Failed to install 'gum'. Please install it manually and rerun." >&2
        exit 1
    fi
    echo "[BOOTSTRAP] 'gum' installed successfully."
fi

# Now we can safely source the helpers
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

main() {
    print_header "Installing System Packages"

    # Check for yay
    if ! command_exists yay; then
        error "'yay' not found. Please install it first."
        exit 1
    fi

    # Consolidate all package lists into one
    info "Reading package lists..."
    local pkg_list_files
pkg_list_files=$(find "$SCRIPTS_DIR/package_lists" -type f -name "*.txt" ! -name "flatpak_pkg_list.txt")

    if [ -z "$pkg_list_files" ]; then
        warning "No package list files found. Skipping."
        exit 0
    fi

    # Read all packages, filter out comments and empty lines, and suppress filenames
    local packages
packages=$(grep -h -vE '^\s*#|^\s*$' $pkg_list_files | tr '\n' ' ')

    if [ -z "$packages" ]; then
        warning "No packages to install. Skipping."
        exit 0
    fi

    info "The following system packages will be installed (if not already present):"
    # Use gum for a nicer formatted list
    gum style --padding "0 1" "$(echo "$packages" | fmt -w 80)"
    echo

    if confirm "Proceed with installation?"; then
        spin "Installing packages with yay..." "yay -S --needed --noconfirm $packages"
        success "System package installation complete."
    else
        warning "Installation cancelled by user."
    fi
}

main
