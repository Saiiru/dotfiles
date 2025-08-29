#!/usr/bin/env bash
# vega-deploy.sh - Deploy script idempotente para perfil VEGA no HyDE
set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis globais
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYDE_CONFIG_DIR="$HOME/.config/hypr"
BACKUP_DIR="$HOME/.config/cfg_backups"
VEGA_PROFILE_DIR="$HOME/dotfiles/hypr/profiles/vega"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Função para logs coloridos
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Função para detectar distribuição
detect_distro() {
  if command -v pacman >/dev/null 2>&1; then
    echo "arch"
  elif command -v apt >/dev/null 2>&1; then
    echo "debian"
  elif command -v dnf >/dev/null 2>&1; then
    echo "fedora"
  else
    echo "unknown"
  fi
}

# Função para instalar dependências
install_dependencies() {
  local distro=$(detect_distro)

  log_info "Detectado sistema: $distro"

  case "$distro" in
    "arch")
      local arch_packages=(
        "hyprland" "kitty" "tmux" "rofi" "waybar" "mako"
        "swww" "grimblast" "wl-clipboard" "jq" "fzf" "ripgrep"
        "btop" "pavucontrol" "networkmanager" "bluez-utils"
        "ttf-jetbrains-mono" "ttf-fira-code" "ttf-font-awesome"
        "brightnessctl" "playerctl" "polkit-gnome"
      )

      log_info "Instalando dependências do Arch..."
      if ! sudo pacman -S --needed "${arch_packages[@]}" --noconfirm; then
        log_error "Falha ao instalar dependências do Arch"
        return 1
      fi
      ;;

    "debian")
      log_warning "Sistema Debian/Ubuntu detectado. Algumas dependências podem precisar ser instaladas manualmente:"
      echo "- Hyprland (via PPA ou build manual)"
      echo "- grimblast (via cargo ou build manual)"
      echo "- swww (via cargo ou GitHub releases)"
      echo "- waybar (apt install waybar)"
      echo "- Outras: sudo apt install kitty tmux rofi mako-notifier wl-clipboard jq fzf ripgrep btop pavucontrol"
      ;;

    *)
      log_error "Distribuição não suportada automaticamente. Instale manualmente:"
      echo "hyprland kitty tmux rofi waybar mako swww grimblast wl-clipboard jq fzf ripgrep btop"
      ;;
  esac
}

# Função para criar backup
create_backup() {
  local file="$1"
  if [[ -f "$file" ]]; then
    local backup_file="${file}.bak-${TIMESTAMP}"
    log_info "Criando backup: $backup_file"
    cp "$file" "$backup_file"
  fi
}

# Função para criar diretórios necessários
create_directories() {
  log_info "Criando estrutura de diretórios..."

  local dirs=(
    "$VEGA_PROFILE_DIR"
    "$VEGA_PROFILE_DIR/hypr/core"
    "$VEGA_PROFILE_DIR/hypr/themes"
    "$VEGA_PROFILE_DIR/hypr/scripts"
    "$VEGA_PROFILE_DIR/kitty"
    "$VEGA_PROFILE_DIR/zsh"
    "$VEGA_PROFILE_DIR/waybar"
    "$VEGA_PROFILE_DIR/rofi"
    "$VEGA_PROFILE_DIR/tmux"
    "$VEGA_PROFILE_DIR/assets"
    "$HOME/.zsh-plugins"
    "$BACKUP_DIR"
  )

  for dir in "${dirs[@]}"; do
    mkdir -p "$dir"
  done

  log_success "Diretórios criados com sucesso"
}

# Função para copiar arquivos de configuração
deploy_configs() {
  log_info "Deployando configurações VEGA..."

  # Copiar todos os arquivos do perfil VEGA
  if [[ -d "$SCRIPT_DIR/profiles/vega" ]]; then
    cp -r "$SCRIPT_DIR/profiles/vega/"* "$VEGA_PROFILE_DIR/"
    log_success "Arquivos VEGA copiados para $VEGA_PROFILE_DIR"
  else
    log_error "Diretório profiles/vega não encontrado!"
    return 1
  fi

  # Tornar scripts executáveis
  find "$VEGA_PROFILE_DIR/hypr/scripts" -type f -name "*.sh" -exec chmod +x {} \;
  log_success "Scripts tornados executáveis"
}

# Função para configurar Zsh plugins
setup_zsh_plugins() {
  log_info "Configurando plugins do Zsh..."

  local plugins_dir="$HOME/.zsh-plugins"

  # Autosuggestions
  if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions" 2>/dev/null || {
      log_warning "Falha ao clonar zsh-autosuggestions. Clone manualmente em $plugins_dir"
    }
  fi

  # Syntax highlighting
  if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugins_dir/zsh-syntax-highlighting" 2>/dev/null || {
      log_warning "Falha ao clonar zsh-syntax-highlighting. Clone manualmente em $plugins_dir"
    }
  fi

  log_success "Plugins do Zsh configurados"
}

# Função para configurar tmux TPM
setup_tmux_tpm() {
  log_info "Configurando Tmux Plugin Manager..."

  local tpm_dir="$HOME/.tmux/plugins/tpm"

  if [[ ! -d "$tpm_dir" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir" 2>/dev/null || {
      log_warning "Falha ao clonar TPM. Clone manualmente: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
    }
  fi

  log_success "TPM configurado"
}

# Função para aplicar overlay ao HyDE
apply_hyde_overlay() {
  log_info "Aplicando overlay VEGA ao HyDE..."

  # Verificar se userprefs.conf existe
  local userprefs="$HYDE_CONFIG_DIR/userprefs.conf"
  if [[ ! -f "$userprefs" ]]; then
    log_error "Arquivo userprefs.conf não encontrado. Certifique-se que o HyDE está instalado."
    return 1
  fi

  # Backup do userprefs.conf
  create_backup "$userprefs"

  # Adicionar include condicional se não existir
  if ! grep -q "# VEGA PROFILE OVERLAY" "$userprefs"; then
    cat >>"$userprefs" <<'EOF'

# VEGA PROFILE OVERLAY - Auto-generated by vega-deploy.sh
# Uncomment the line below to enable VEGA profile
# source = ./profiles/vega/vega-main.conf
EOF
    log_success "Include VEGA adicionado ao userprefs.conf"
  else
    log_info "Include VEGA já existe no userprefs.conf"
  fi
}

# Função para mostrar instruções pós-instalação
show_post_install_instructions() {
  echo -e "\n${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║                    INSTALAÇÃO CONCLUÍDA!                     ║${NC}"
  echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

  echo -e "${CYAN}Para ativar o perfil VEGA:${NC}"
  echo -e "1. Edite ${YELLOW}~/.config/hypr/userprefs.conf${NC}"
  echo -e "2. Descomente a linha: ${BLUE}source = ./profiles/vega/vega-main.conf${NC}"
  echo -e "3. Recarregue o Hyprland: ${BLUE}hyprctl reload${NC}"

  echo -e "\n${CYAN}Keybinds principais VEGA:${NC}"
  echo -e "• ${YELLOW}SUPER + Return${NC}       - Terminal normal"
  echo -e "• ${YELLOW}SUPER + Shift + Return${NC} - Terminal flutuante"
  echo -e "• ${YELLOW}SUPER + T${NC}             - Terminal fullscreen"
  echo -e "• ${YELLOW}SUPER + D${NC}             - Rofi launcher"
  echo -e "• ${YELLOW}SUPER + R${NC}             - Rofi runner"
  echo -e "• ${YELLOW}SUPER + X${NC}             - Menu power"
  echo -e "• ${YELLOW}SUPER + A${NC}             - Screenshot manager"
  echo -e "• ${YELLOW}SUPER + P${NC}             - Color palette"
  echo -e "• ${YELLOW}SUPER + E${NC}             - Emoji picker"

  echo -e "\n${CYAN}Terminal com tmux:${NC}"
  echo -e "• Startup session automático com tabs Dev/Web/Shell"
  echo -e "• Prefix tmux: ${YELLOW}Ctrl+A${NC}"
  echo -e "• Instalar plugins tmux: ${YELLOW}Ctrl+A + I${NC}"

  echo -e "\n${CYAN}Waybar VEGA (opcional):${NC}"
  echo -e "• Para usar Waybar ao invés da barra HyDE:"
  echo -e "• Export ${YELLOW}VEGA_USE_WAYBAR=1${NC} no seu shell"
  echo -e "• Ou edite vega-main.conf e descomente as linhas do Waybar"

  echo -e "\n${CYAN}Arquivos importantes:${NC}"
  echo -e "• Configuração VEGA: ${BLUE}~/.config/hypr/profiles/vega/${NC}"
  echo -e "• Logs: ${BLUE}journalctl --user -f${NC}"
  echo -e "• Backups: ${BLUE}~/.config/cfg_backups/${NC}"

  echo -e "\n${PURPLE}Para suporte: https://github.com/HyDE-Project/HyDE${NC}"
}

# Função para verificar pré-requisitos
check_prerequisites() {
  log_info "Verificando pré-requisitos..."

  if [[ ! -d "$HYDE_CONFIG_DIR" ]]; then
    log_error "HyDE não detectado. Instale o HyDE primeiro: https://github.com/HyDE-Project/HyDE"
    return 1
  fi

  if ! command -v hyprctl >/dev/null 2>&1; then
    log_error "Hyprland não está instalado ou em execução"
    return 1
  fi

  log_success "Pré-requisitos verificados"
}

# Função principal
main() {
  echo -e "${PURPLE}"
  cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║ ██╗   ██╗███████╗ ██████╗  █████╗     ██████╗ ███████╗██████╗ ║
║ ██║   ██║██╔════╝██╔════╝ ██╔══██╗    ██╔══██╗██╔════╝██╔══██╗║
║ ██║   ██║█████╗  ██║  ███╗███████║    ██║  ██║█████╗  ██████╔╝║
║ ╚██╗ ██╔╝██╔══╝  ██║   ██║██╔══██║    ██║  ██║██╔══╝  ██╔═══╝ ║
║  ╚████╔╝ ███████╗╚██████╔╝██║  ██║    ██████╔╝███████╗██║     ║
║   ╚═══╝  ╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝     ║
║                                                               ║ 
║                  HyDE Profile Overlay                        ║
║              NeoGotham/Zen-Twilight Theme                    ║
╚═══════════════════════════════════════════════════════════════╝
EOF
  echo -e "${NC}\n"

  # Verificar argumentos
  local install_deps=false
  for arg in "$@"; do
    case $arg in
      --install-deps)
        install_deps=true
        shift
        ;;
      --help | -h)
        echo "Uso: $0 [--install-deps] [--help]"
        echo "  --install-deps  Instalar dependências automaticamente"
        echo "  --help          Mostrar esta ajuda"
        exit 0
        ;;
    esac
  done

  # Executar passos de instalação
  if ! check_prerequisites; then
    exit 1
  fi

  if [[ "$install_deps" == "true" ]]; then
    install_dependencies
  fi

  create_directories
  deploy_configs
  setup_zsh_plugins
  setup_tmux_tpm
  apply_hyde_overlay

  show_post_install_instructions

  log_success "Deploy VEGA concluído com sucesso!"
}

# Executar função principal com todos os argumentos
main "$@"
