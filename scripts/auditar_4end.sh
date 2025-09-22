#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/_audit_4end_$(date +%s)"
mkdir -p "$OUT"

# Versões e pacotes relevantes
{
  echo "=== HOST ==="; uname -a
  echo -e "\n=== PACOTES ==="
  for p in hyprland waybar quickshell swww jq yq wlroots qt6ct kvantum-qt5 kvantum; do
    printf "%-14s : " "$p"; pacman -Q $p 2>/dev/null || echo "não instalado"
  done
} | tee "$OUT/01_host_pkgs.txt"

# Estrutura do teu repo
{
  echo "DOTFILES: $HOME/dotfiles"
  tree -L 2 -a "$HOME/dotfiles" 2>/dev/null || ls -la "$HOME/dotfiles"
} > "$OUT/02_repo_tree.txt"

# .config ativo (topo) e itens-alvo
{
  echo "=== ~/.config (top) ==="
  ls -1A ~/.config | sort
  echo -e "\n=== itens-alvo ==="
  for d in hypr waybar quickshell kvantum Kvantum kitty zsh nvim "Code - OSS"; do
    echo "--- $d ---"
    [ -e "$HOME/.config/$d" ] && (file "$HOME/.config/$d"; (git -C "$HOME/.config/$d" rev-parse --is-inside-work-tree 2>/dev/null && echo "(é repo git EMBUTIDO!)" || true))
  done
} > "$OUT/03_config_scan.txt"

# Temas & assets centralizados
{
  echo "=== ~/.local/share symlinks ==="
  for d in icons themes cursors Kvantum; do
    printf "%-8s -> " "$d"
    readlink -f "$HOME/.local/share/$d" 2>/dev/null || echo "faltando"
  done
  echo -e "\n=== Conteúdo curto ==="
  for d in icons themes Kvantum; do
    echo "[$d]"; ls -1 "$HOME/.local/share/$d" 2>/dev/null | head -n 30
  done
} > "$OUT/04_themes_assets.txt"

# Hyprland: includes + refs HyDE + refs end-4
{
  CFG="$HOME/.config/hypr"
  echo "=== hyprland.conf (includes) ==="
  grep -nE '^\s*source\s*=' "$CFG/hyprland.conf" 2>/dev/null || echo "sem includes"
  echo -e "\n=== refs HyDE ==="
  grep -Rni 'hyde-shell\|/hyde/|HyDE' "$CFG" 2>/dev/null || echo "OK: sem HyDE"
  echo -e "\n=== refs end-4 ==="
  grep -Rni 'quickshell\|end-4\|qs-panel\|qs-' "$CFG" 2>/dev/null || echo "sem refs end-4 ainda"
} > "$OUT/05_hypr_scan.txt"

# Waybar: imports e módulos custom
{
  W="$HOME/.config/waybar"
  echo "=== waybar paths ==="
  echo "$W"
  [ -d "$W" ] && { 
    echo "files:"; ls -1 "$W"; 
    echo -e "\nimports suspeitos:"; grep -Rni '\.cache/hyde\|hyde' "$W" || echo "OK"
  } || echo "sem waybar"
} > "$OUT/06_waybar_scan.txt"

# Quickshell: conf
{
  Q="$HOME/.config/4end/quickshell"
  echo "=== quickshell ==="
  if [ -d "$Q" ]; then
    find "$Q" -maxdepth 2 -type f -printf "%P\n"
    quickshell --version 2>/dev/null || true
  else
    echo "sem ~/.config/4end/quickshell"
  fi
} > "$OUT/07_quickshell_scan.txt"

# Kitty & fontes
{
  K="$HOME/.config/kitty"
  echo "=== kitty ==="
  if [ -d "$K" ]; then
    grep -nE 'font_family|font_size|include' "$K"/kitty.conf 2>/dev/null || true
    echo -e "\n=== theme.conf cabeçalho ==="
    sed -n '1,40p' "$K/theme.conf" 2>/dev/null || true
  else
    echo "sem kitty"
  fi
  echo -e "\n=== fontes do sistema (amostra) ==="
  fc-list : family style | grep -Ei 'jetbrains|caskaydia|noto|sarasa|dr460' | head -n 40
} > "$OUT/08_kitty_fonts.txt"

# Firefox/Firedragon tweaks
{
  echo "=== firefox/firedragon chrome ==="
  find "$HOME/.mozilla" "$HOME/.firedragon" -maxdepth 3 -type f \( -name userChrome.css -o -name userContent.css \) 2>/dev/null
} > "$OUT/09_browsers.txt"

# VSCode OSS settings
{
  V="$HOME/.config/Code - OSS/User/settings.json"
  echo "=== Code - OSS settings.json ==="
  [ -f "$V" ] && jq 'del(.["security.workspace.trust.untrustedFiles"])' "$V" 2>/dev/null || echo "sem settings.json"
} > "$OUT/10_code_oss.txt"

# Resumo curto
{
  echo "OUT_DIR=$OUT"
  echo "repo=$(readlink -f ~/dotfiles)"
  echo "waybar=$(readlink -f ~/.config/waybar 2>/dev/null || echo NA)"
  echo "qs=$(readlink -f ~/.config/4end/quickshell 2>/dev/null || echo NA)"
  echo "hyde_refs=$(grep -Rli 'hyde-shell\|/hyde/' ~/.config/hypr 2>/dev/null | wc -l)"
} > "$OUT/_SUMMARY.txt"

echo "OK → $OUT"
