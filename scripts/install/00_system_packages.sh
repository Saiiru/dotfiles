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

    # Consolidate only system package lists
    info "Reading system package lists..."
    local pkg_list_files=(
        "$SCRIPTS_DIR/package_lists/common_pkg_list.txt"
        "$SCRIPTS_DIR/package_lists/gaming_amd_pkg_list.txt"
        "$SCRIPTS_DIR/package_lists/audio_pkg_list.txt"
        "$SCRIPTS_DIR/package_lists/dev_pkg_list.txt"
        "$SCRIPTS_DIR/package_lists/gaming_pkg_list.txt"
        "$SCRIPTS_DIR/package_lists/wayland_pkg_list.txt"
    )

    local all_packages=""
    for file in "${pkg_list_files[@]}"; do
        if [ -f "$file" ]; then
            # Read packages from file, filter comments and empty lines, append to all_packages
            all_packages+=" $(grep -h -vE '^\s*#|^\s*$' "$file" | tr '\n' ' ')"
        else
            warning "Package list file '$file' not found. Skipping."
        fi
done

    # Trim leading/trailing whitespace from all_packages
    all_packages=$(echo "$all_packages" | xargs)

    if [ -z "$all_packages" ]; then
        warning "No packages to install from system lists. Skipping."
        exit 0
    fi

    info "The following system packages will be installed (if not already present):"
    # Use gum for a nicer formatted list
    gum style --padding "0 1" "$(echo "$all_packages" | fmt -w 80)"
    echo

    if confirm "Proceed with installation?"; then
        spin "Installing packages with yay..." "yay -S --needed --noconfirm $all_packages"
        
        if [ $? -eq 0 ]; then
            success "System package installation complete."
        else
            error "System package installation failed."
            exit 1
        fi
    else
        warning "Installation cancelled by user."
        exit 0
    fi
}

main