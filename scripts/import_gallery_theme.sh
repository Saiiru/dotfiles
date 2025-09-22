#!/usr/bin/env bash
set -euo pipefail
NAME="${1:-Hack-the-Box}"   # ex: Hack-the-Box | Vanta-Black | Bad-Blood
REMOTE="https://github.com/HyDE-Project/hyde-gallery.git"

rm -rf "$WD"
git clone --depth 1 --filter=blob:none --sparse "$REMOTE" "$WD"
git -C "$WD" sparse-checkout set "$NAME"

SRC="$WD/$NAME"
# extrai pacotes (Icon_*.tar.gz, Gtk_*.tar.gz, Cursor_*.tar.gz, Kvantum etc.)
if [ -d "$SRC/Source" ]; then
  for tgz in "$SRC/Source/"*.tar.gz 2>/dev/null; do
    [ -e "$tgz" ] || continue
    b="$(basename "$tgz")"
    case "$b" in
      Icon_*.tar.gz)   tar -xzf "$tgz" -C "$HOME/dotfiles/.local/share/icons"   ;;
      Gtk_*|GTK_*.tar.gz)
                       tar -xzf "$tgz" -C "$HOME/dotfiles/.local/share/themes"  ;;
      Cursor_*|Cursors_*.tar.gz)
                       tar -xzf "$tgz" -C "$HOME/dotfiles/.local/share/icons"   ;;
      *) # Kvantum, etc.
         if tar -tzf "$tgz" | grep -qi '^Kvantum/'; then
           tar -xzf "$tgz" -C "$HOME/dotfiles/.local/share"
         else
           tar -xzf "$tgz" -C "$HOME/dotfiles/.local/share/themes"
         fi
      ;;
    esac
  done
fi
# wallpapers
if [ -d "$SRC/wallpapers" ]; then
  mkdir -p "$HOME/dotfiles/wallpapers/$NAME"
  rsync -a --delete "$SRC/wallpapers/" "$HOME/dotfiles/wallpapers/$NAME/"
fi
# snippets (kitty/hypr/waybar/kvantum)
DST="$HOME/dotfiles/config/themes/$NAME"
mkdir -p "$DST"
for f in hypr.theme kitty.theme rofi.theme waybar.theme theme.dcol; do
  [ -f "$SRC/$f" ] && cp -f "$SRC/$f" "$DST/"
done
[ -d "$SRC/kvantum" ] && { mkdir -p "$DST/kvantum"; cp -f "$SRC/kvantum/"* "$DST/kvantum/"; }

echo "✔ Gallery: '$NAME' importado."
