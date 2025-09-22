#!/usr/bin/env bash
set -euo pipefail
DF="$HOME/dotfiles"; TS="$(date +%s)"
bk(){ [ -e "$1" ] && [ ! -L "$1" ] && mv -v "$1" "$1.bak.$TS" || true; }

mkdir -p "$HOME/.config"
# linka tudo de config/*
find "$DF/config" -mindepth 1 -maxdepth 1 -printf "%f\n" | while read -r n; do
  s="$DF/config/$n"; d="$HOME/.config/$n"; bk "$d"; ln -sfn "$s" "$d"
done

# assets visuais
for d in icons themes cursors Kvantum; do
  mkdir -p "$DF/.local/share/$d" "$HOME/.local/share"
  bk "$HOME/.local/share/$d"
  ln -sfn "$DF/.local/share/$d" "$HOME/.local/share/$d"
done

# wallpapers
bk "$HOME/wallpapers"
ln -sfn "$DF/wallpapers" "$HOME/wallpapers"
echo "Symlinks prontos."
