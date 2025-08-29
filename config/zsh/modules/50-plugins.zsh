# lua/kora/modules/plugins.zsh
# KORA · ZSH Plugins & Zinit Configuration (Grimório Neo-Noir)
#
# Gerenciamento eficiente de plugins Zsh via Zinit, focado em performance e funcionalidade.
# Este arquivo carrega os plugins essenciais e configura suas integrações.

# Zinit Bootstrap: Garante que o Zinit esteja instalado e carregado.
export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  print -P -- "%F{#F59E0B}Downloading Zinit...%f" # Mensagem de download
  command mkdir -p "$(dirname "$ZINIT_HOME")"
  command git clone --quiet --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" >/dev/null 2>&1
fi
# shellcheck disable=SC1090
[[ -f "$ZINIT_HOME/zinit.zsh" ]] && source "$ZINIT_HOME/zinit.zsh"

# Plugins Essenciais: Carregados de forma leve para otimizar a inicialização.
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf-bin
zinit light ajeetdsouza/zoxide

# Destaque de Sintaxe: Carregado de forma assíncrona para não bloquear o prompt.
zinit wait lucid for atload'ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern); ZSH_HIGHLIGHT_STYLES[comment]=fg=#7F849C' zsh-users/zsh-syntax-highlighting

# Integração FZF: Configurações de atalhos e completions.
if command -v fzf >/dev/null 2>&1; then
  [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
  [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
fi

# Integração Zoxide: Inicializa para navegação inteligente de diretórios.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Estilo de Autosuggestions: Personaliza a aparência e o comportamento.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7C3AED'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Estilo de Completions e FZF-tab: Configurações visuais e de cache.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"
zstyle ':completion:*' list-colors "di=34:fi=0:ln=36:pi=35:so=32:bd=33:cd=33:or=31:mi=5:ex=1:*.zsh=38;5;213"


# Relatório de Performance (apenas em modo debug):
if [[ "$KORA_DEBUG" == "1" ]]; then
  local zinit_end=$SECONDS
  local zinit_time=$((zinit_end - zinit_start))
  print -P "%F{#22D3EE}🐉 KORA: Plugin system loaded in ${zinit_time}ms%f"
fi
