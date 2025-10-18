#!/usr/bin/env bash
set -euo pipefail

# --- Development Environment Setup --- #

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# shellcheck source=../lib/helpers.sh
source "$SCRIPTS_DIR/lib/helpers.sh"

# --- Config --- #
MISE_PKGS_FILE="$SCRIPTS_DIR/package_lists/mise_pkg_list.txt"
NPM_PKGS_FILE="$SCRIPTS_DIR/package_lists/npm_pkg_list.txt"
GO_TOOLS_FILE="$SCRIPTS_DIR/package_lists/go_tool_list.txt"
UV_TOOLS_FILE="$SCRIPTS_DIR/package_lists/uv_tool_list.txt"

# --- Helper Functions --- #

# Function to add activation string to a file if it's not already there
add_to_shell_config() {
    local config_file="$1"
    local activation_str="$2"
    local comment="$3"

    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$config_file")"
    touch "$config_file"

    if grep -qF "$comment" "$config_file"; then
        info "mise activation already present in $config_file."
    else
        info "Adding mise activation to $config_file..."
        echo -e "\n$comment\n$activation_str" >> "$config_file"
        success "mise activation added to $config_file."
    fi
}

# --- Main Installation Functions --- #

install_mise() {
    print_header "Setting up mise (Async Runtime Manager)"

    if command_exists mise; then
        info "'mise' is already installed. Skipping installation."
    else
        if confirm "'mise' not found. Install it now?"; then
            spin "Installing mise..." "curl -fsSL https://mise.run | sh"
            success "mise installed successfully."
        else
            error "mise is required to set up the development environment. Aborting."
            exit 1
        fi
    fi

    # Add mise to shell configs
    info "Configuring shell environments for mise..."
    add_to_shell_config "$HOME/.bashrc" 'eval "$(mise activate bash)"' "# mise shell integration"
    add_to_shell_config "$HOME/.zshrc" 'eval "$(mise activate zsh)"' "# mise shell integration"
    add_to_shell_config "$HOME/.config/fish/config.fish" 'status is-interactive; and eval (mise activate fish | psub)' "# mise shell integration"

    # Activate for current session to proceed with installations
    eval "$(mise activate bash)"
    success "Shells configured and mise activated for this session."
}

install_mise_packages() {
    print_header "Installing Runtimes & Tools with mise"

    if [ ! -f "$MISE_PKGS_FILE" ]; then
        warning "mise package list not found at '$MISE_PKGS_FILE'. Skipping."
        return
    fi

    info "Reading mise package list..."
    local packages_to_install
    packages_to_install=$(grep -vE '^\s*#|^\s*$' "$MISE_PKGS_FILE" | tr '\n' ' ')

    if [ -z "$packages_to_install" ]; then
        warning "No mise packages to install. Skipping."
        return
    fi

    info "The following packages will be installed globally via mise:"
    gum style --padding "0 1" "$(echo "$packages_to_install" | fmt -w 80)"
    echo

    if confirm "Proceed with mise package installation?"; then
        spin "Installing mise packages..." "mise use -g $packages_to_install"
        success "mise packages installed."
    else
        warning "mise package installation cancelled."
    fi
}

install_npm_packages() {
    print_header "Installing Global NPM Packages"

    if ! command_exists npm; then
        error "npm not found. Make sure Node.js was installed correctly via mise."
        return
    fi

    if [ ! -f "$NPM_PKGS_FILE" ]; then
        warning "NPM package list not found at '$NPM_PKGS_FILE'. Skipping."
        return
    fi

    info "Reading NPM package list..."
    
    # Use a while-read loop to correctly handle each line from the file
    grep -vE '^\s*#|^\s*$' "$NPM_PKGS_FILE" | while read -r pkg || [[ -n "$pkg" ]]; do
        local pkg_name
        pkg_name=$(echo "$pkg" | cut -d'@' -f1)
        
        if npm list -g --depth=0 | grep -q "^$pkg_name@"; then
            info "NPM package '$pkg_name' is already installed. Skipping."
        else
            if confirm "Install global NPM package '$pkg'?"; then
                spin "Installing $pkg..." "npm install -g $pkg"
                success "Installed $pkg."
            else
                warning "Skipped installation of $pkg."
            fi
        fi
    done
    success "Global NPM package installation complete."
}

install_go_tools() {
    print_header "Installing Global Go Tools"

    if ! command_exists go; then
        error "Go not found. Make sure Go was installed correctly via mise."
        return
    fi

    if [ ! -f "$GO_TOOLS_FILE" ]; then
        warning "Go tools list not found at '$GO_TOOLS_FILE'. Skipping."
        return
    fi

    info "Reading Go tools list..."
    local tools_to_install
    tools_to_install=$(grep -vE '^\s*#|^\s*$' "$GO_TOOLS_FILE")

    for tool in $tools_to_install; do
        local tool_name
        tool_name=$(basename "$tool" | cut -d'@' -f1)
        if command_exists "$tool_name"; then
            info "Go tool '$tool_name' is already installed. Skipping."
        else
            if confirm "Install global Go tool '$tool'?"; then
                spin "Installing $tool..." "go install $tool"
                success "Installed $tool."
            else
                warning "Skipped installation of $tool."
            fi
        fi
    done
    success "Global Go tool installation complete."
}

install_uv_tools() {
    print_header "Installing Python Tools with uv"

    if ! command_exists uv; then
        error "uv not found. Make sure uv was installed correctly as a system package."
        return
    fi

    if [ ! -f "$UV_TOOLS_FILE" ]; then
        warning "uv tools list not found at '$UV_TOOLS_FILE'. Skipping."
        return
    fi

    info "Reading uv tools list..."
    local tools_to_install
    tools_to_install=$(grep -vE '^\s*#|^\s*$' "$UV_TOOLS_FILE")

    for tool in $tools_to_install; do
        if command_exists "$tool"; then
            info "uv tool '$tool' is already installed. Skipping."
        else
            if confirm "Install Python tool '$tool' with uv?"; then
                spin "Installing $tool..." "uv tool install $tool"
                success "Installed $tool."
            else
                warning "Skipped installation of $tool."
            fi
        fi
    done
    success "Python tool installation with uv complete."
}

# --- Main Execution --- #
main() {
    install_mise
    install_mise_packages
    install_npm_packages
    install_go_tools
    install_uv_tools
    
    print_header "Development Environment Setup Complete!"
    info "Please restart your terminal or source your shell config (e.g., 'source ~/.zshrc') to apply all changes."
}

main
