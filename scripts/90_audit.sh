#!/usr/bin/env bash
set -euo pipefail

HDR(){ printf "\n=== %s ===\n" "$*"; }
OK(){ printf "✔ %s\n" "$*"; }
WARN(){ printf "⚠ %s\n" "$*"; }
ERR(){ printf "✖ %s\n" "$*"; }

DF="${DF_ROOT:-$HOME/dotfiles}"

HDR "HOST"
uname -a

HDR "DOTFILES ROOT"
echo "$DF"
[ -d "$DF" ] || { ERR "dotfiles ausente"; exit 1; }

HDR "SYMLINKS L&F (.local/share)"
for d in icons themes cursors Kvantum; do
  tgt="$HOME/.local/share/$d"
  echo -n "$d -> "
  if [ -L "$tgt" ]; then readlink -f "$tgt"; else WARN "não é symlink"; fi
done

HDR ".local/share conteúdos (top-level)"
for d in icons themes cursors Kvantum; do
  p="$DF/.local/share/$d"
  if [ -d "$p" ]; then
    echo "[$d] $(ls -1 "$p" | wc -l) entradas"
    ls -1 "$p" | head -n 25
    [ "$(ls -1 "$p" | wc -l)" -gt 25 ] && echo "…"
  else WARN "$p faltando"; fi
done

HDR "WALLPAPERS"
WP="$HOME/wallpapers"
echo -n "link ~/wallpapers -> "; [ -L "$WP" ] && readlink -f "$WP" || WARN "sem link"
[ -d "$DF/wallpapers" ] && find "$DF/wallpapers" -maxdepth 1 -type f | wc -l | xargs -I{} echo "Total: {}"

HDR "HYPR (includes & refs HyDE)"
HCFG="$HOME/.config/hypr"
grep -nE 'source = \./(keybindings|windowrules|monitors|userprefs)\.conf' "$HCFG/hyprland.conf" || WARN "includes base não encontrados"


HDR "HYPR THEME SNAPSHOT"
THEME="$HCFG/themes/theme.conf"
if [ -f "$THEME" ]; then
  awk 'NR<=80{print}' "$THEME"
else WARN "theme.conf não encontrado"; fi

HDR "WAYBAR"
WCFG="$HOME/.config/waybar"
[ -f "$WCFG/config.jsonc" ] || WARN "config.jsonc ausente"
[ -f "$WCFG/theme.css" ] || WARN "theme.css ausente"

INC="$WCFG/includes/includes.json"
[ -f "$INC" ] && jq -r '.include[]?' "$INC" 2>/dev/null | sed 's|^|include: |' || true

HDR "KVANTUM"
KV="$HOME/.config/Kvantum/kvantum.kvconfig"
if [ -f "$KV" ]; then
  awk '/^\[General\]/{f=1} f && NR<=20{print}' "$KV"
  theme=$(awk -F= '/^theme=/{print $2}' "$KV" | tr -d '\r')
  [ -n "${theme:-}" ] && [ -d "$HOME/.local/share/Kvantum/$theme" ] && OK "Tema Kvantum ok: $theme" || WARN "Tema Kvantum inválido"
else WARN "kvantum.kvconfig ausente"; fi

HDR "GTK/XSETTINGSD"
XS="$HOME/.config/xsettingsd/xsettingsd.conf"
if [ -f "$XS" ]; then
  cat "$XS"
  gtk=$(awk -F\" '/Gtk\/ThemeName/{print $2}' "$XS"); ico=$(awk -F\" '/Net\/IconThemeName/{print $2}' "$XS")
  cur=$(awk -F\" '/Gtk\/CursorThemeName/{print $2}' "$XS")
  [ -d "$HOME/.local/share/themes/$gtk" ] && OK "GTK ok: $gtk" || WARN "GTK theme faltando: $gtk"
  [ -d "$HOME/.local/share/icons/$ico" ] && OK "Icon ok: $ico" || WARN "Icon faltando: $ico"
  [ -d "$HOME/.local/share/icons/$cur" ] && OK "Cursor ok: $cur" || WARN "Cursor faltando: $cur"
else WARN "xsettingsd.conf ausente"; fi

HDR "KITTY"
KC="$HOME/.config/kitty/kitty.conf"
[ -f "$KC" ] && { grep -n '^include .*theme\.conf' "$KC" || WARN "kitty sem include theme.conf"; grep -n '^font_size' "$KC" || true; } || WARN "kitty.conf ausente"

HDR "PACOTES-CHAVE"
need=(hyprland waybar swww xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland mako wl-clipboard grim slurp steam gamemode gamescope mangohud protontricks kitty kvantum-qt5 kvantum-qt6 qt6ct qt5ct)
for p in "${need[@]}"; do pacman -Q "$p" &>/dev/null && echo "ok: $p" || echo "miss: $p"; done

HDR "SERVIÇOS"
systemctl --user is-active xdg-desktop-portal && OK "xdg-desktop-portal (user) ativo" || WARN "portal (user) inativo"
systemctl --user is-active xdg-desktop-portal-hyprland && OK "portal-hyprland ativo" || WARN "portal-hyprland inativo"
systemctl is-enabled sddm &>/dev/null && OK "sddm habilitado" || WARN "sddm não habilitado"

HDR "ZRAM / SWAP"
swapon --show || true
lsblk -o NAME,TYPE,SIZE,MOUNTPOINT | awk '/zram/ || NR==1{print}'
journalctl -b -u 'zram*' --no-pager -n 20 2>/dev/null || true

HDR "GAMING"
systemctl is-active gamemoded &>/dev/null && OK "gamemoded ativo" || WARN "gamemoded inativo"
command -v protontricks >/dev/null && OK "protontricks ok" || WARN "protontricks faltando"
[ -d "$HOME/.steam" ] || [ -d "$HOME/.local/share/Steam" ] && OK "Steam presente" || WARN "Steam não inicializado"

HDR "MISE / DEV"
if command -v mise >/dev/null; then
  OK "mise instalado: $(mise --version)"
  grep -R "mise activate" "$HOME/.config/zsh/zshenv" >/dev/null && OK "zsh integra mise" || WARN "zshenv sem mise activate"
else WARN "mise não encontrado"; fi

HDR "NVIM"
command -v nvim >/dev/null && { nvim --version | head -n1; [ -d "$HOME/.config/nvim" ] && OK "nvim config presente"; } || WARN "nvim ausente"

HDR "DUPLICATAS vs SYMLINKS (.config)"
while IFS= read -r d; do
  base="$(basename "$d")"
  tgt="$HOME/.config/$base"
  [ -e "$tgt" ] && [ ! -L "$tgt" ] && WARN "~/.config/$base não é symlink (pode conflitar)"
done < <(find "$DF/config" -mindepth 1 -maxdepth 1 -type d)

HDR "GIT STATUS (dotfiles)"
git -C "$DF" rev-parse --is-inside-work-tree &>/dev/null && git -C "$DF" status -s || WARN "repo git não inicializado"

HDR "FIM"

