emulate -L zsh

# mise: shims + completions
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# uv: completions
if command -v uv >/dev/null 2>&1; then
  local _zcc="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"; mkdir -p "$_zcc"
  [[ -s "$_zcc/_uv" ]] || uv generate-shell-completion zsh >"$_zcc/_uv" 2>/dev/null || true
  fpath=("$_zcc" $fpath)
fi

# atalhos Python/uv
export PYTHONDONTWRITEBYTECODE=1 PIP_DISABLE_PIP_VERSION_CHECK=1 UV_NO_SYNC=1
alias py='python'
alias uvr='uv run'; alias uvx='uvx'