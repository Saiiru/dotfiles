# Meus Dotfiles

Este repositório contém minhas configurações pessoais para um ambiente de desenvolvimento em Arch Linux, gerenciado com Git e implantado via symlinks.

## ✨ Visão Geral

O objetivo é ter um setup limpo, rápido e produtivo, centrado em torno de ferramentas de linha de comando e um gerenciador de janelas tiling.

- **SO**: Arch Linux
- **WM**: Hyprland (Wayland)
- **Terminal**: Ghostty / Kitty
- **Editor**: Neovim (configuração em Lua)
- **Shell**: Zsh com Starship e Oh My Posh
- **Barra de Status**: Waybar
- **Lançador**: Rofi

## 📂 Estrutura do Repositório

- `config/`: Contém todas as configurações de aplicativos (dotfiles), organizadas por nome de aplicativo.
- `scripts/`: Scripts de instalação e utilitários para automatizar o setup e tarefas comuns.
- `notes/`: Anotações pessoais sobre instalação e configuração do sistema.

## 🚀 Instalação em um Novo Sistema

1.  Clone o repositório para `~/dotfiles`:
    ```bash
    git clone <URL_DO_SEU_REPO_AQUI> ~/dotfiles
    ```

2.  Execute o script de deploy para criar os symlinks:
    ```bash
    cd ~/dotfiles/scripts
    # (Será necessário criar um script de deploy que execute os comandos ln -sfn)
    ./deploy.sh 
    ```

3.  Instale os pacotes necessários:
    ```bash
    ./package_install.sh
    ```