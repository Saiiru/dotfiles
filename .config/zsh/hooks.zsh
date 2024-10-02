# Hooks do Zsh

# Define o que acontece ao mudar o diretório
chpwd() {
  command -v nvim >/dev/null && nvim .
}

# Comando para auto completar o Python
function _python_autocomplete() {
  local completions
  completions=$(ls *.py)
  compadd $completions
}

zstyle ':completion:*:complete:python' list-dirs-first true

