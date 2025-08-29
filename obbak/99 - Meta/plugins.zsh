export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"

if [[ ! -d "$ZSH" ]]; then
  echo "🚀 Initiating Oh My Zsh deployment sequence..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

plugins=(
  git docker docker-compose kubectl
  fzf extract zsh-completions
  zsh-autosuggestions zsh-syntax-highlighting fzf-tab
  aliases command-not-found colored-man-pages web-search
  copypath copyfile copybuffer dirhistory
  npm yarn golang rust python pip
  systemd archlinux sudo
)

declare -A plugin_repos=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["fzf-tab"]="https://github.com/Aloxaf/fzf-tab"
  ["zsh-you-should-use"]="https://github.com/MichaelAquilina/zsh-you-should-use"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
)
for plugin in "${(@k)plugin_repos}"; do
  dst="$ZSH_CUSTOM/plugins/$plugin"
  [[ ! -d "$dst" ]] && git clone --quiet --depth=1 "${plugin_repos[$plugin]}" "$dst"
done

source "$ZSH/oh-my-zsh.sh"
