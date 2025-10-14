emulate -L zsh
export PYTHONDONTWRITEBYTECODE=1
export PIP_DISABLE_PIP_VERSION_CHECK=1
export UV_NO_SYNC=1
if command -v uv >/dev/null 2>&1; then
  _zcc="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"; mkdir -p "$_zcc"
  [[ -s "$_zcc/_uv" ]] || uv generate-shell-completion zsh >"$_zcc/_uv" 2>/dev/null || true
  fpath=("$_zcc" $fpath)
fi
alias py='python'
alias uvr='uv run'
alias uvx='uvx'
[[ -d /usr/lib/jvm/java-21-openjdk ]] && export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
alias mvn='mvn -T1C -q'
alias grad='gradle --console=plain'
alias nr='npm run'; alias ni='npm i'
alias pr='pnpm run'; alias pi='pnpm i'
alias yr='yarn run'
command -v zoxide >/dev/null 2>&1 && znap eval zoxide 'zoxide init zsh'