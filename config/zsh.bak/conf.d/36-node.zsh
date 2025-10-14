emulate -L zsh

# NPM / PNPM / Yarn / Bun completions
command -v npm  >/dev/null 2>&1 && source <(npm completion)          2>/dev/null || true
command -v pnpm >/dev/null 2>&1 && source <(pnpm completion zsh)     2>/dev/null || true
command -v yarn >/dev/null 2>&1 && yarn completion zsh >/dev/null 2>&1 && source <(yarn completion zsh) || true
command -v bun  >/dev/null 2>&1 && bun completions zsh >/dev/null 2>&1 && source <(bun completions zsh) || true

# Atalhos
alias nr='npm run'; alias ni='npm i'
alias pr='pnpm run'; alias pi='pnpm i'
alias yr='yarn run'