#!/usr/bin/env bash
set -euo pipefail
REMOTE="https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-dr460nized.git"
WD="$HOME/.cache/dr460nized"
rm -rf "$WD"
git clone --depth 1 "$REMOTE" "$WD"

# tenta coletar assets típicos em usr/share/{icons,themes,wallpapers,Kvantum}
for dir in icons themes backgrounds wallpapers Kvantum; do
  if [ -d "$WD/usr/share/$dir" ]; then
    case "$dir" in
      backgrounds|wallpapers)
        mkdir -p "$HOME/dotfiles/wallpapers/dr460nized"
        rsync -a "$WD/usr/share/$dir/" "$HOME/dotfiles/wallpapers/dr460nized/"
        ;;
      *)
        mkdir -p "$HOME/dotfiles/.local/share/$dir"
        rsync -a "$WD/usr/share/$dir/" "$HOME/dotfiles/.local/share/$dir/"
        ;;
    esac
  fi
done

# snippets (se houver temas .conf/.css etc no repo)
DST="$HOME/dotfiles/config/themes/dr460nized"
mkdir -p "$DST"
find "$WD" -maxdepth 3 -type f \( -name '*kitty*theme*' -o -name '*hypr*theme*' -o -name '*waybar*theme*' -o -name '*.kvconfig' -o -name '*.svg' \) -print -exec cp -f {} "$DST/" \; || true

echo "✔ dr460nized importado."
