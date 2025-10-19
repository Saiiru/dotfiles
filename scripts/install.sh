#!/usr/bin/env bash
set -euo pipefail

# --- Main Installer Script --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPTS_DIR/install"

# Check for non-interactive flag
export FORCE_YES=false
if [[ "${1:-}" == "-y" || "${1:-}" == "--yes" ]]; then
  export FORCE_YES=true
fi

# Bootstrap gum first, as the entire UI depends on it.
if ! command -v gum &> /dev/null; then
    echo "[BOOTSTRAP] 'gum' not found. It is required for the installer UI."
    # In non-interactive mode, we can't ask, so we assume no and exit.
    if [[ "$FORCE_YES" == "true" ]]; then
        echo "[BOOTSTRAP-ERROR] 'gum' must be installed to run in non-interactive mode. Please install it first." >&2
        exit 1
    fi
    read -p "Attempt to install 'gum' via pacman? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! command -v sudo &> /dev/null; then
            echo "[BOOTSTRAP-ERROR] 'sudo' not found. Please install 'gum' manually and rerun." >&2
            exit 1
        fi
        if ! sudo pacman -S --noconfirm --needed gum; then
            echo "[BOOTSTRAP-ERROR] Failed to install 'gum'. Please install it manually and rerun." >&2
            exit 1
        fi
    else
        echo "[BOOTSTRAP-ABORT] 'gum' is required to proceed. Aborting." >&2
        exit 1
    fi
fi

# Now that gum is available, source helpers and start the main menu.
# shellcheck source=lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

run_all_installers() {
    print_header "Running all installers (Non-interactive mode)"
    bash "$INSTALL_DIR/00_system_packages.sh"
    bash "$INSTALL_DIR/01_flatpak.sh"
    bash "$INSTALL_DIR/02_dev_environment.sh"
    bash "$INSTALL_DIR/03_fonts.sh"
}

run_interactive_menu() {
    print_header "Dotfiles Installer Menu"

    info "Welcome! This script will help you set up your environment."
    info "Choose which parts of the installation you want to run."
    info "You can select multiple options with Tab or Shift+Tab.\n"

    # Define options for the checklist
    options=(
        "System Packages (yay)" 
        "Flatpak Apps"
        "Development Environment (mise, npm, go, uv)"
        "Fonts"
        "All of the above"
    )

    # Use gum to create an interactive checklist
    selection=$(gum choose --no-limit --height 10 "${options[@]}")

    if [ -z "$selection" ]; then
        warning "No options selected. Exiting."
        exit 0
    fi

    # Determine if "All" was selected
    run_all=false
    if echo "$selection" | grep -q "All of the above"; then
        run_all=true
    fi

    # Execute scripts based on selection
    if $run_all || echo "$selection" | grep -q "System Packages"; then
        bash "$INSTALL_DIR/00_system_packages.sh"
    fi

    if $run_all || echo "$selection" | grep -q "Flatpak Apps"; then
        bash "$INSTALL_DIR/01_flatpak.sh"
    fi

    if $run_all || echo "$selection" | grep -q "Development Environment"; then
        bash "$INSTALL_DIR/02_dev_environment.sh"
    fi

    if $run_all || echo "$selection" | grep -q "Fonts"; then
        bash "$INSTALL_DIR/03_fonts.sh"
    fi
}

main() {
    if [[ "$FORCE_YES" == "true" ]]; then
        run_all_installers
    else
        run_interactive_menu
    fi

    success "Installation process finished!"
    info "Please restart your terminal or source your shell config to apply all changes."
}

main
