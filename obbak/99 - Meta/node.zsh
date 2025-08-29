if [[ ! -d "$HOME/.fnm" ]]; then
  echo "🚀 Installing FNM (Fast Node Manager)..."
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir ~/.fnm --skip-shell
fi

export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"

alias nvm='fnm'
alias nvm-install='fnm install'
alias nvm-use='fnm use'
alias nvm-list='fnm list'
alias nvm-current='fnm current'
