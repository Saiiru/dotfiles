emulate -L zsh
if command -v docker >/dev/null 2>&1; then
  source <(docker completion zsh)            2>/dev/null || true
  source <(docker compose completion zsh)    2>/dev/null || true
fi
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh) 2>/dev/null || true
command -v helm    >/dev/null 2>&1 && source <(helm completion zsh)    2>/dev/null || true
[[ -r /usr/share/kubectx/completion/kubectx.zsh ]] && source /usr/share/kubectx/completion/kubectx.zsh
[[ -r /usr/share/kubectx/completion/kubens.zsh  ]] && source /usr/share/kubectx/completion/kubens.zsh