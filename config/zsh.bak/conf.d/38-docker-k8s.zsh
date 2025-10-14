emulate -L zsh

# Docker
command -v docker >/dev/null 2>&1 && {
  source <(docker completion zsh)           2>/dev/null || true
  source <(docker compose completion zsh)   2>/dev/null || true
}
alias d='docker'; alias dc='docker compose'
alias dps='docker ps'; alias di='docker images'; alias drm='docker rm'; alias drmi='docker rmi'
dcu(){ docker compose up -d "$@"; }
dcd(){ docker compose down "$@"; }

# Kubernetes
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh) 2>/dev/null || true
command -v helm    >/dev/null 2>&1 && source <(helm completion zsh)    2>/dev/null || true
[[ -r /usr/share/kubectx/completion/kubectx.zsh ]] && source /usr/share/kubectx/completion/kubectx.zsh
[[ -r /usr/share/kubectx/completion/kubens.zsh  ]] && source /usr/share/kubectx/completion/kubens.zsh

alias k='kubectl'
alias kg='kubectl get'; alias kd='kubectl describe'; alias kl='kubectl logs'
alias kga='kubectl get pods,svc,deploy,ingress'
alias kctx='kubectx'; alias kns='kubens'
kpf(){ kubectl port-forward "$@"; }
