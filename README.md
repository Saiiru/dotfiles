# My workstation configs

This repository contains my personal configurations for an Arch Linux development environment, managed with Git and deployed via symlinks.

## ✨ Overview

The goal is to have a clean, fast, and productive setup, centered around command-line tools and a tiling window manager.

- **OS**: Arch Linux
- **WM**: Hyprland (Wayland)
- **Terminal**: Ghostty / Kitty
- **Editor**: Neovim (Lua configuration)
- **Shell**: Zsh with Starship and Oh My Posh
- **Status Bar**: Waybar
- **Launcher**: Rofi

## 📂 Repository Structure

- `config/`: Contains all application configurations (dotfiles), organized by application name.
- `scripts/`: Installation scripts and utilities to automate setup and common tasks.
- `notes/`: Personal notes on system installation and configuration.

## 🚀 Installation on a New System

1.  Clone the repository to `~/dotfiles`:
    ```bash
    git clone https://github.com/Saiiru/dotfiles.git ~/dotfiles
    ```

2.  Run the setup script to install packages and create symlinks:
    ```bash
    cd ~/dotfiles/scripts
    ./setup.sh
    ```

3.  After running `setup.sh`, you might need to log out and log back in (or reboot) for all changes (like Docker group membership) to take effect.
