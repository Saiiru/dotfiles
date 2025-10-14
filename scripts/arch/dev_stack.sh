#!/usr/bin/env bash
set -euo pipefail

# --- Variáveis e Configurações Iniciais ---
TS=$(date +%Y%m%d-%H%M%S)
DOTFILES_DIR="$HOME/dotfiles"
ZSH_CONFIG_DIR="$DOTFILES_DIR/config_dotfiles/config/zsh"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

ROOTLESS_MODE=false
CLUSTER_TYPE=""
AUR_HELPER=""

# --- Funções de Log ---
info() { printf "\e[1;34m[INFO]\e[0m %s\n" "$*"; }
success() { printf "\e[1;32m[SUCCESS]\e[0m %s\n" "$*"; }
warning() { printf "\e[1;33m[WARNING]\e[0m %s\n" "$*"; }
error() { printf "\e[1;31m[ERROR]\e[0m %s\n" "$*" >&2; exit 1; }

# --- Funções de Lógica ---

# 1) Parse de Flags
parse_flags() {
  for arg in "$@"; do
    case $arg in
      --rootless)
        ROOTLESS_MODE=true
        shift
        ;;
      --cluster=*) 
        CLUSTER_TYPE="${arg#*=}"
        shift
        ;;
    esac
  done
}

# 2) Detecção de AUR Helper
detect_aur_helper() {
  if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
  elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
  fi
}

# 3) Instalação de Pacotes
install_packages() {
  info "Iniciando instalação de pacotes..."
  local pkgs=(
    "git" "curl" "unzip" "zip" "rsync" # Base
    "docker" "docker-buildx" # Docker
    "kubectl" "helm" "kustomize" "minikube" "kind" "kubectx" "kubens" "stern" # K8s
    "lazydocker" "dive" # Extras
  )

  # Lógica para docker-compose
  if pacman -Si docker-compose-plugin &>/dev/null; then
    pkgs+=("docker-compose-plugin")
  elif pacman -Si docker-compose &>/dev/null; then
    pkgs+=("docker-compose")
  else
    warning "Nenhum pacote docker-compose encontrado nos repositórios oficiais."
  fi

  local failed_pkgs=()
  for pkg in "${pkgs[@]}"; do
    if ! sudo pacman -Syu --needed --noconfirm "$pkg" >/dev/null 2>&1; then
      failed_pkgs+=("$pkg")
    else
      success "Pacote '$pkg' instalado via pacman."
    fi
  done

  if [ ${#failed_pkgs[@]} -gt 0 ] && [ -n "$AUR_HELPER" ]; then
    info "Tentando instalar pacotes faltantes via AUR com $AUR_HELPER..."
    for pkg in "${failed_pkgs[@]}"; do
      if "$AUR_HELPER" -S --needed --noconfirm "$pkg" >/dev/null 2>&1; then
        success "Pacote '$pkg' instalado via $AUR_HELPER."
      else
        error "Falha ao instalar '$pkg' via pacman e $AUR_HELPER."
      fi
    done
  elif [ ${#failed_pkgs[@]} -gt 0 ]; then
    error "Falha ao instalar os seguintes pacotes e nenhum AUR helper foi encontrado: ${failed_pkgs[*]}"
  fi
}

# 4) Configuração do Docker
setup_docker() {
  info "Configurando o Docker..."
  if [ "$ROOTLESS_MODE" = true ]; then
    info "Modo Rootless selecionado."
    sudo pacman -S --needed --noconfirm fuse-overlayfs slirp4netns
    if [ ! -f "$HOME/.config/systemd/user/docker.service" ]; then
      dockerd-rootless-setuptool.sh install
    else
      info "Docker Rootless já parece estar configurado."
    fi
    
    local env_dir="$HOME/.config/environment.d"
    local env_file="$env_dir/30-docker-rootless.conf"
    mkdir -p "$env_dir"
    echo "DOCKER_HOST=unix:///run/user/$UID/docker.sock" > "$env_file"
    info "Variável DOCKER_HOST configurada em '$env_file'."
    warning "É necessário fazer relogin ou reiniciar o sistema para o modo rootless funcionar corretamente."
  else
    info "Modo Rootful (padrão) selecionado."
    if getent group docker | grep -q "\b$USER\b"; then
      info "Usuário '$USER' já pertence ao grupo 'docker'."
    else
      info "Adicionando usuário '$USER' ao grupo 'docker'."
      sudo usermod -aG docker "$USER"
      warning "É necessário fazer relogin para que a permissão do grupo docker tenha efeito."
    fi
    
    if systemctl is-active --quiet docker; then
      info "Serviço Docker já está ativo."
    else
      info "Habilitando e iniciando o serviço Docker."
      sudo systemctl enable --now docker
    fi
  fi
}

# 5) Configuração do Cluster K8s
setup_k8s_cluster() {
  if [ -z "$CLUSTER_TYPE" ]; then
    info "Nenhum cluster K8s solicitado. Pulando."
    return
  fi

  info "Configurando cluster Kubernetes local: $CLUSTER_TYPE"
  case $CLUSTER_TYPE in
    minikube)
      minikube start --driver=docker
      ;;
    kind)
      if kind get clusters | grep -q '^kind$'; then
        info "Cluster 'kind' já existe."
      else
        kind create cluster
      fi
      ;;
    *)
      warning "Tipo de cluster desconhecido: '$CLUSTER_TYPE'. Use 'minikube' ou 'kind'."
      ;;
  esac
}

# 6) Geração de Completions para Zsh
generate_completions() {
  info "Gerando arquivos de completion para Zsh em '$CACHE_DIR'..."
  mkdir -p "$CACHE_DIR"

  local tools_to_complete=("docker" "kubectl" "helm" "minikube" "kind" "stern")
  for tool in "${tools_to_complete[@]}"; do
    local comp_file="$CACHE_DIR/_$tool"
    local tool_bin
    tool_bin=$(command -v "$tool")

    if [ -x "$tool_bin" ] && [ ! -f "$comp_file" ] || [ "$tool_bin" -nt "$comp_file" ]; then
      info "Gerando completion para '$tool'..."
      case $tool in
        docker) docker completion zsh > "$comp_file" ;; 
        kubectl) kubectl completion zsh > "$comp_file" ;; 
        helm) helm completion zsh > "$comp_file" ;; 
        minikube) minikube completion zsh > "$comp_file" ;; 
        kind) kind completion zsh > "$comp_file" ;; 
        stern) stern --completion zsh > "$comp_file" || true ;; 
      esac
    else
      info "Completion para '$tool' já está atualizado."
    fi
  done
  
  # Lógica especial para docker-compose
  local compose_comp_file="$CACHE_DIR/_docker-compose"
  if command -v docker-compose >/dev/null 2>&1; then
      docker-compose completion zsh > "$compose_comp_file"
      info "Gerando completion para 'docker-compose'."
  elif command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
      docker compose completion zsh > "$compose_comp_file"
      info "Gerando completion para 'docker compose'."
  fi
}

# 7) Integração com Zsh (Aliases e Helpers)
integrate_zsh() {
  info "Integrando aliases e helpers no Zsh..."
  local DST_FILE="$ZSH_CONFIG_DIR/conf.d/30_dev_cli.zsh"
  
  # Conteúdo exato do arquivo a ser criado
  read -r -d '' ZSH_CONTENT << 'ZSH_EOF'
# Dev CLI: Docker + Kubernetes
# Histórico e compdump na HOME
export HISTFILE="$HOME/.zsh_history"
typeset -g ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
# compinit com cache na HOME
autoload -Uz compinit
compinit -d "$HOME/.zcompdump"

# fpath: incluir completions geradas em cache
local _zc="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$_zc" ]] && fpath=($_zc $fpath)

# aliases Docker
alias d='docker'
alias dps='docker ps'
alias di='docker images'
alias dlog='docker logs -f --tail=200'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -af --volumes'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down -v'
alias dcl='docker compose logs -f --tail=200'

# helpers Docker
dkc() { docker exec -it "$1" sh -lc "${*:2}"; }      # dkc <container> [cmd]
dbash() { docker exec -it "$1" bash || docker exec -it "$1" sh; }

# aliases K8s
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias kdel='kubectl delete -f'
alias klogs='kubectl logs -f --tail=200'
alias kpf='kubectl port-forward'
alias kctx='kubectx'
alias kns='kubens'
alias kctxns='echo "ctx=$(kubectl config current-context) ns=$(kubectl config view --minify --output 'jsonpath={..namespace}')"'

# helm
alias h='helm'
alias hl='helm ls -A'

# minikube/kind
alias mk='minikube'
alias kdock='kubectl get pods -A -o wide'

# lazydocker
command -v lazydocker >/dev/null 2>&1 && alias ld='lazydocker'
ZSH_EOF

  mkdir -p "$(dirname "$DST_FILE")"
  if [ -f "$DST_FILE" ]; then
    # Usando diff para verificar se há mudanças. Se houver, faz backup.
    if ! diff -q <(echo "$ZSH_CONTENT") "$DST_FILE" >/dev/null; then
      warning "Arquivo '$DST_FILE' existe e é diferente. Fazendo backup."
      mv "$DST_FILE" "$DST_FILE.bak-$TS"
      echo "$ZSH_CONTENT" > "$DST_FILE"
      success "Novo arquivo '30_dev_cli.zsh' escrito."
    else
      info "Arquivo '30_dev_cli.zsh' já está atualizado."
    fi
  else
    echo "$ZSH_CONTENT" > "$DST_FILE"
    success "Arquivo '30_dev_cli.zsh' criado."
  fi
}

# 8) Validações Finais
run_validations() {
  info "--- Resumo da Configuração ---"
  
  echo -e "\n\e[1;36m[VERSÕES DAS FERRAMENTAS]\e[0m"
  docker --version
  if command -v docker-compose >/dev/null 2>&1; then docker-compose --version; else docker compose version; fi
  kubectl version --client --output=yaml | head -n 5
  helm version --short
  
  echo -e "\n\e[1;36m[STATUS DO DOCKER]\e[0m"
  if getent group docker | grep -q "\b$USER\b"; then
    success "Usuário '$USER' pertence ao grupo 'docker'."
  else
    warning "Usuário '$USER' NÃO pertence ao grupo 'docker'. Faça relogin."
  fi
  if systemctl is-active --quiet docker; then
    success "Serviço Docker está ativo."
  else
    warning "Serviço Docker NÃO está ativo."
  fi

  echo -e "\n\e[1;36m[COMPLETIONS GERADAS EM '$CACHE_DIR']\e[0m"
  ls -1 "$CACHE_DIR" | grep -E '^_docker$|_kubectl$|_helm$|_minikube$|_kind$|_docker-compose$|_stern$' || warning "Nenhum arquivo de completion encontrado."

  echo -e "\n\e[1;36m[INTEGRAÇÃO ZSH]\e[0m"
  if [ -f "$ZSH_CONFIG_DIR/conf.d/30_dev_cli.zsh" ]; then
    success "Arquivo '30_dev_cli.zsh' está presente."
  else
    error "Arquivo '30_dev_cli.zsh' NÃO foi criado."
  fi
  
  warning "Para que os aliases e completions funcionem, inicie uma nova sessão Zsh (com 'exec zsh') ou abra um novo terminal."
}


# --- Função Principal ---
main() {
  parse_flags "$@"
  detect_aur_helper
  install_packages
  setup_docker
  setup_k8s_cluster
  generate_completions
  integrate_zsh
  run_validations
}

# --- Execução ---
main "$@"
