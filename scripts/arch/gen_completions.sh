#!/usr/bin/env bash
set -euo pipefail

COMPDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
mkdir -p "$COMPDIR"

gen() { # gen <cmd> <outfile> <producer...>
  local cmd="$1" out="$2"; shift 2
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "· $cmd → $out"
    "$@" > "$COMPDIR/$out".new 2>/dev/null || true
    [[ -s "$COMPDIR/$out".new ]] && mv "$COMPDIR/$out".new "$COMPDIR/$out"
  else
    echo "· skip $cmd"
  fi
}

# Kubernetes
gen kubectl        "_kubectl"        kubectl completion zsh
gen helm           "_helm"           helm completion zsh
gen minikube       "_minikube"       minikube completion zsh
gen k9s            "_k9s"            k9s completion zsh || true

# Docker
gen docker         "_docker"         docker completion zsh
# docker compose (subcomando moderno)
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  echo "· docker compose → _docker-compose"
  docker compose completion zsh > "$COMPDIR/_docker-compose".new 2>/dev/null || true
  [[ -s "$COMPDIR/_docker-compose".new ]] && mv "$COMPDIR/_docker-compose".new "$COMPDIR/_docker-compose"
fi

# GitHub CLI
gen gh             "_gh"             gh completion -s zsh

# mise (toolchain)
gen mise           "_mise"           mise completion zsh

# uv (Python)
gen uv             "_uv"             uv generate-shell-completion zsh

# Permissões de leitura
chmod -R a+r "$COMPDIR"

echo
echo "OK. Completions em: $COMPDIR"
echo "Inclua-o no fpath e rode compinit."
