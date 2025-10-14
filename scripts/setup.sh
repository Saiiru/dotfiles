#!/usr/bin/env bash
set -euo pipefail

# Define o diretório de scripts para que possamos chamar outros scripts de forma confiável
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Funções de log para uma saída mais clara
info() { printf "\e[1;34m[INFO]\e[0m %s\n" "$*"; }
success() { printf "\e[1;32m[SUCCESS]\e[0m %s\n" "$*"; }
warning() { printf "\e[1;33m[WARNING]\e[0m %s\n" "$*"; }

info "Iniciando a configuração do ambiente a partir do repositório dotfiles..."

# Passo 1: Instalar pacotes do sistema via yay
if [ -f "$SCRIPTS_DIR/package_install.sh" ]; then
    info "Executando a instalação de pacotes do sistema..."
    bash "$SCRIPTS_DIR/package_install.sh"
else
    warning "Script 'package_install.sh' não encontrado. Pulando."
fi

# Passo 2: Instalar pacotes Flatpak
if [ -f "$SCRIPTS_DIR/flatpak_install.sh" ]; then
    info "Executando a instalação de pacotes Flatpak..."
    bash "$SCRIPTS_DIR/flatpak_install.sh"
else
    warning "Script 'flatpak_install.sh' não encontrado. Pulando."
fi

# Passo 3: Criar symlinks para diretórios de configuração
if [ -f "$SCRIPTS_DIR/symlink_configs.sh" ]; then
    info "Criando symlinks para os diretórios de configuração..."
    bash "$SCRIPTS_DIR/symlink_configs.sh"
else
    warning "Script 'symlink_configs.sh' não encontrado. Pulando."
fi

# Passo 4: Criar symlinks para arquivos de configuração na HOME
if [ -f "$SCRIPTS_DIR/symlink_files.sh" ]; then
    info "Criando symlinks para os arquivos na HOME..."
    bash "$SCRIPTS_DIR/symlink_files.sh"
else
    warning "Script 'symlink_files.sh' não encontrado. Pulando."
fi

success "Configuração do ambiente concluída!"
