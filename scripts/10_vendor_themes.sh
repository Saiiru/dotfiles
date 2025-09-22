#!/usr/bin/env bash
set -euo pipefail
DF="$HOME/dotfiles"
AS="$HOME/.cache/theme-vendor"
mkdir -p "$AS" "$DF/.local/share"/{icons,themes,cursors,Kvantum,wallpapers}
cd "$AS"

# Vanta-Black
[ -d Vanta-Black ] || git clone --depth=1 https://github.com/rishav12s/Vanta-Black.git
rsync -a --delete Vanta-Black/ "$DF/.local/share/themes/Vanta-Black/"

# HyDE gallery (Bad-Blood + Hack-the-Box)
for BRANCH in Bad-Blood Hack-the-Box; do
  D="hyde-gallery-$BRANCH"
  [ -d "$D" ] || git clone --depth=1 -b "$BRANCH" https://github.com/HyDE-Project/hyde-gallery "$D"
  rsync -a "$D"/icons/   "$DF/.local/share/icons/"    2>/dev/null || true
  rsync -a "$D"/themes/  "$DF/.local/share/themes/"   2>/dev/null || true
  rsync -a "$D"/Kvantum/ "$DF/.local/share/Kvantum/"  2>/dev/null || true
  rsync -a "$D"/wallpapers/ "$DF/wallpapers/$BRANCH/" 2>/dev/null || true
done

# DR460nized
[ -d dr460nized ] || git clone --depth=1 https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-dr460nized.git dr460nized
rsync -a dr460nized/icons/     "$DF/.local/share/icons/"    2>/dev/null || true
rsync -a dr460nized/gtk/       "$DF/.local/share/themes/"   2>/dev/null || true
rsync -a dr460nized/Kvantum/   "$DF/.local/share/Kvantum/"  2>/dev/null || true
rsync -a dr460nized/wallpapers "$DF/wallpapers/dr460nized/" 2>/dev/null || true

# limpa .git internos se algum veio
find "$DF/.local/share" "$DF/wallpapers" -type d -name .git -prune -exec rm -rf {} +
echo "Vendor OK."
