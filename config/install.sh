#!/bin/bash
# KORA - Cyberdream Suite Installer
# Script para instalar todas as dependências necessárias em um ambiente Arch Linux.

# --- Verificação de Dependências Essenciais ---
if ! command -v git &> /dev/null; then
    echo "Git não encontrado. Instalando git..."
    sudo pacman -S --noconfirm git
fi

if ! command -v yay &> /dev/null; then
    echo "O helper AUR 'yay' não foi encontrado. É recomendado para instalar pacotes AUR como 'sessionx'."
    echo "Você pode instalá-lo com:"
    echo "sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    read -p "Deseja continuar sem o yay? (s/N) " choice
    case "$choice" in
      s|S ) echo "Continuando sem yay. Pacotes AUR não serão instalados.";;
      * ) exit 1;;
    esac
fi

# --- Lista de Pacotes ---
official_packages=(
    kitty zsh oh-my-posh tmux neovim eza bat fd fzf ripgrep procs btop lazygit
    docker docker-compose nodejs npm pnpm python python-pip pyenv taskwarrior xclip wl-clipboard
)

aur_packages=(
    sessionx-git # Usando sessionx-git para a versão mais recente
)

# --- Instalação ---
echo "Instalando pacotes oficiais via pacman..."
sudo pacman -S --needed --noconfirm "${official_packages[@]}"

if command -v yay &> /dev/null; then
    echo "Instalando pacotes do AUR via yay..."
    yay -S --needed --noconfirm "${aur_packages[@]}"
fi

# --- Pós-instalação ---
echo "Ativando serviço do Docker..."
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

echo "Instalação concluída! É recomendado reiniciar o shell ou fazer logout/login."
echo "Para usar o Docker sem sudo, você precisa reiniciar a sessão."

