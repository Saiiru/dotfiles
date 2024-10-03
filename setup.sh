#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -eq 0 ]; then
    echo "Por favor, não execute como root."
    exit
fi

# Diretório atual
DOTFILES_DIR=$(pwd)

# List of common packages for various distributions
declare -a common_packages=(
    curl wget git zsh tmux bat fzf eza unzip ripgrep ncdu ranger vim zoxide
)

# AUR packages for Arch-based systems
declare -a aur_packages=(
    topgrade neovim-git hyprland-git qt5-wayland qt6-wayland swww xdg-desktop-portal-hyprland-git
    pamixer pavucontrol pipewire-pulse polkit-kde-agent ffmpegthumbnailer file-roller
    gvfs thunar thunar-archive-plugin btop brightnessctl feh mpv newsboat 
    nm-connection-editor noto-fonts-emoji tldr stow wl-clipboard unzip yt-dlp kitty exa grim slurp swaylock-effects
)

# Font packages
declare -a font_packages=(
    ttf-roboto-mono-nerd ttf-jetbrains-mono-nerd ttf-noto-nerd ttf-hack-nerd ttf-firacode-nerd ttf-segoe-ui-variable
)

# Function to install packages for Arch-based systems
install_arch() {
    sudo pacman -S "${common_packages[@]}" github-cli fd git-delta lazygit wl-clipboard --needed --noconfirm
    AUR_HELPER="paru" # Use your preferred AUR helper
    $AUR_HELPER -S "${aur_packages[@]}" --needed --noconfirm
}

# Function to install packages for Fedora-based systems
install_fedora() {
    sudo dnf copr enable atim/lazygit -y
    sudo dnf install "${common_packages[@]}" gh lazygit fd-find wl-clipboard git-delta --assumeyes
}

# Function to install packages for Debian-based systems
install_debian() {
    sudo apt install "${common_packages[@]}" gh fd-find xclip autorandr nala topgrade --assume-yes
    sudo ln -sfnv /usr/bin/fdfind /usr/bin/fd
    sudo ln -sfnv /usr/bin/batcat /usr/bin/bat
}

# Function to install packages based on the detected system
install_packages() {
    system_kind=$(get_system_info)
    echo -e "\u001b[7m Installing packages for $system_kind...\u001b[0m"

    case $system_kind in
    manjaro|arch|endeavouros) install_arch ;;
    ubuntu|debian|pop|kali) install_debian ;;
    fedora|fedora-asahi-remix) install_fedora ;;
    *) echo "Unknown system!" && exit 1 ;;
    esac
}

# Function to create symbolic links for configurations
setup_symlinks() {
    echo -e "\u001b[7m Setting up symlinks... \u001b[0m"
    
    ln -sf "$DOTFILES_DIR/.config/dunst/dunstrc" ~/.config/dunst/dunstrc
    ln -sf "$DOTFILES_DIR/.config/fastfetch/fastfetch.conf" ~/.config/fastfetch/fastfetch.conf
    ln -sf "$DOTFILES_DIR/.config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
    ln -sf "$DOTFILES_DIR/.config/starship/starship.toml" ~/.config/starship.toml
    ln -sf "$DOTFILES_DIR/.config/tmux/tmux.conf" ~/.config/tmux/tmux.conf
    ln -sf "$DOTFILES_DIR/.config/zsh/.zshrc" ~/.zshrc
    ln -sf "$DOTFILES_DIR/firefox/user.js" ~/.mozilla/firefox/*.default-release/user.js

    echo "Configurações vinculadas com sucesso!"
}

# Function to perform the full setup
setup_dotfiles() {
    echo -e "\u001b[7m Setting up dots2k... \u001b[0m"
    install_packages
    setup_symlinks
    echo -e "\u001b[7m Done! \u001b[0m"
}

# Function to show a menu for the setup
show_menu() {
    echo -e "\u001b[32;1m Setting up your env with dots2k...\u001b[0m"
    echo -e " \u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
    echo -e "  \u001b[34;1m (0) Setup Everything \u001b[0m"
    echo -e "  \u001b[34;1m (1) Install Packages \u001b[0m"
    echo -e "  \u001b[34;1m (2) Setup Symlinks \u001b[0m"
    echo -e "  \u001b[31;1m (*) Anything else to exit \u001b[0m"
    echo -en "\u001b[32;1m ==> \u001b[0m"

    read -r choice
    case $choice in
    0) setup_dotfiles ;;
    1) install_packages ;;
    2) setup_symlinks ;;
    *) exit 0 ;;
    esac
    show_menu
}

# Function to detect the operating system
get_system_info() {
    if [ -e /etc/os-release ]; then
        source /etc/os-release
        echo "${ID:-Unknown}"
    elif [ -e /etc/lsb-release ]; then
        source /etc/lsb-release
        echo "${DISTRIB_ID:-Unknown}"
    elif [ "$(uname)" == "Darwin" ]; then
        echo "mac"
    elif [ "$(uname -o)" == "Android" ]; then
        echo "termux"
    else
        echo "Unknown"
    fi
}

# Start the script
show_menu

