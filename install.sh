#!/bin/bash
# KORA Matrix v3: Solo Leveling Edition - Script de Instalação

set -e

# --- 1. Funções de Log ---
log_info() { echo -e "\e[1;34m[INFO]\e[0m $1"; }
log_success() { echo -e "\e[1;32m[SUCCESS]\e[0m $1"; }
log_warn() { echo -e "\e[1;33m[WARN]\e[0m $1"; }
log_error() { echo -e "\e[1;31m[ERROR]\e[0m $1"; exit 1; }

# --- 2. Instalação de Dependências Core ---
log_info "Atualizando pacotes do sistema..."
sudo pacman -Syu --noconfirm || log_error "Falha ao atualizar o sistema."

log_info "Instalando pacotes essenciais via pacman..."
sudo pacman -S --needed --noconfirm \
  kitty zsh tmux neovim eza bat fd fzf ripgrep procs btop lazygit \
  docker docker-compose unzip wget curl git ufw \
  || log_error "Falha ao instalar pacotes essenciais."

log_info "Instalando AUR helper (yay)..."
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git || log_error "Falha ao instalar base-devel/git."
  git clone https://aur.archlinux.org/yay.git /tmp/yay || log_error "Falha ao clonar yay."
  (cd /tmp/yay && makepkg -si --noconfirm) || log_error "Falha ao instalar yay."
  rm -rf /tmp/yay
else
  log_info "yay já está instalado."
fi

log_info "Instalando pacotes AUR via yay..."
yay -S --needed --noconfirm sessionx gum spring-boot-cli || log_error "Falha ao instalar pacotes AUR."

# --- 3. Configuração do Mise (Universal Version Manager) ---
log_info "Configurando Mise..."
if ! command -v mise &>/dev/null; then
  curl https://mise.run | sh || log_error "Falha ao instalar mise."
  # Adiciona mise ao PATH para a sessão atual
  export PATH="$HOME/.local/bin:$PATH"
  eval "$(mise activate zsh)"
fi

mkdir -p "$HOME/.config/mise"
cat <<EOF > "$HOME/.config/mise/config.toml"
# ~/.config/mise/config.toml — KORA Global Toolchain
[settings]
experimental = true
[env]
default_tool_versions_file = "~/.config/mise/.tool-versions"
EOF

cat <<EOF > "$HOME/.config/mise/.tool-versions"
python lts
node lts
java lts
golang latest
rust latest
EOF

log_info "Instalando toolchains globais com mise (isso pode levar alguns minutos)..."
mise install -- -g || log_error "Falha ao instalar toolchains com mise."
log_success "Toolchains globais instaladas."

# --- 4. Configuração do Firewall (UFW) ---
log_info "Configurando firewall UFW..."
sudo ufw enable || log_error "Falha ao habilitar UFW."
sudo ufw default deny incoming || log_error "Falha ao definir regra de entrada UFW."
sudo ufw default allow outgoing || log_error "Falha ao definir regra de saída UFW."
log_success "Firewall UFW ativado com regras padrão seguras."

# --- 5. Copiar Dotfiles ---
log_info "Copiando dotfiles para ~/.config/zsh..."
mkdir -p "$HOME/.config/zsh"
cp -r "$HOME/dotfiles/config/zsh/." "$HOME/.config/zsh/" || log_error "Falha ao copiar dotfiles Zsh."

log_info "Copiando configurações do Kitty..."
mkdir -p "$HOME/.config/kitty"
cp "$HOME/dotfiles/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf" || log_error "Falha ao copiar kitty.conf."

log_info "Copiando configurações do Tmux..."
cp "$HOME/dotfiles/config/tmux/tmux.conf" "$HOME/.tmux.conf" || log_error "Falha ao copiar tmux.conf."

log_info "Copiando configurações do Oh My Posh..."
mkdir -p "$HOME/.config/oh-my-posh"
cp "$HOME/dotfiles/config/oh-my-posh/kora-solo-leveling.omp.json" "$HOME/.config/oh-my-posh/kora-solo-leveling.omp.json" || log_error "Falha ao copiar tema OMP."

log_info "Copiando scripts para ~/.scripts..."
mkdir -p "$HOME/.scripts"
cp "$HOME/dotfiles/.scripts/mkproj" "$HOME/.scripts/mkproj" || log_error "Falha ao copiar mkproj."
cp "$HOME/dotfiles/.scripts/kora-cheat" "$HOME/.scripts/kora-cheat" || log_error "Falha ao copiar kora-cheat."
chmod +x "$HOME/.scripts/mkproj" "$HOME/.scripts/kora-cheat" || log_error "Falha ao dar permissão de execução aos scripts."

log_info "Copiando configurações do Hyprland..."
mkdir -p "$HOME/.config/hypr"
cp -r "$HOME/dotfiles/.config/hypr/." "$HOME/.config/hypr/" || log_error "Falha ao copiar configs Hyprland."

log_info "Copiando documentação de segurança..."
mkdir -p "$HOME/dotfiles/security"
cp "$HOME/dotfiles/security/README.md" "$HOME/dotfiles/security/README.md" || log_error "Falha ao copiar README de segurança."

# --- 6. Configuração do Zsh como Shell Padrão ---
log_info "Definindo Zsh como shell padrão..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)" || log_error "Falha ao definir Zsh como shell padrão. Por favor, faça manualmente: chsh -s $(which zsh)"
else
  log_info "Zsh já é o shell padrão."
fi

log_success "Instalação KORA Matrix v3 concluída!"
log_info "Por favor, reinicie seu terminal ou faça logout/login para que as mudanças tenham efeito completo."
