#!/usr/bin/env bash
# Este script baixa o repositório de dotfiles e inicia a instalação.

set -euo pipefail

DOTFILES_REPO="https://github.com/Saiiru/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "Clonando o repositório de dotfiles..."
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

echo "Iniciando o script de configuração..."
bash "$DOTFILES_DIR/scripts/setup.sh"
