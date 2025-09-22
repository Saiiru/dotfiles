#!/usr/bin/env bash
set -euo pipefail

DF="$HOME/dotfiles"
TS="$(date +%s)"

backup_link () {
  local dst="$1"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv -v "$dst" "$dst.bak.$TS"
  fi
}

echo "[.config] symlinkando pastas do repo"
mkdir -p "$HOME/.config"
find "$DF/config" -mindepth 1 -maxdepth 1 -printf "%f\n" | while read -r name; do
  src="$DF/config/$name"
  dst="$HOME/.config/$name"
  backup_link "$dst"
  ln -sfn "$src" "$dst"
done

echo "[.local/share] symlinkando assets"
mkdir -p "$HOME/.local/share"
for d in icons themes cursors Kvantum; do
  src="$DF/.local/share/$d"
  dst="$HOME/.local/share/$d"
  mkdir -p "$src"
  backup_link "$dst"
  ln -sfn "$src" "$dst"
done

echo "[wallpapers] criando link na HOME"
src="$DF/wallpapers"
dst="$HOME/wallpapers"
mkdir -p "$src"
backup_link "$dst"
ln -sfn "$src" "$dst"

echo "OK. symlinks prontos."
