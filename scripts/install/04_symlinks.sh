#!/usr/bin/env bash
set -euo pipefail

# --- Symlink Creation --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

main() {
    print_header "Creating Symlinks"

    info "Running symlink_configs.sh..."
    bash "$SCRIPTS_DIR/symlink/symlink_configs.sh"

    info "Running symlink_files.sh..."
    bash "$SCRIPTS_DIR/symlink/symlink_files.sh"

    success "All symlinks processed."
}

main
