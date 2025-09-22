#!/usr/bin/env bash
set -euo pipefail

# 1) garantir runtimes via mise
mise use -g

# 2) Node (LSPs/formatters globais)
corepack enable || true
pnpm add -g \
  typescript typescript-language-server \
  @vtsls/language-server \
  vscode-langservers-extracted \
  @tailwindcss/language-server \
  prettier prettier-plugin-tailwindcss \
  @fsouza/prettierd \
  cspell \
  oxlint \
  npm-check-updates

# 3) Python (via uv → executáveis em ~/.local/bin)
uv tool install --upgrade pyright ruff black isort codespell

# 4) Go (LSP/formatadores)
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/mgechev/revive@latest

echo "Ferramentas dev instaladas."

