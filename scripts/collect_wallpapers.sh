#!/usr/bin/env bash
set -euo pipefail
SRC_DIRS=(
  "$HOME/.config/hyde/themes"              # HyDE (todas as coleções)
  "$HOME/.config/kitty"                    # kitty backgrounds
  "$HOME/.config/hypr"                     # hyprlock wall e afins
)
DEST="$HOME/dotfiles/wallpapers/_flat"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

shopt -s nullglob globstar

# 2.1 copiar tudo que for imagem das fontes acima
for d in "${SRC_DIRS[@]}"; do
  [ -d "$d" ] || continue
  while IFS= read -r -d '' f; do
    cp -n "$f" "$TMP/" 2>/dev/null || true
  done < <(find "$d" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) -print0)
done

# 2.2 resolver symlinks wall.set / wall.hyprlock.png do HyDE (se existirem)
while IFS= read -r -d '' setfile; do
  tgt="$(readlink -f "$setfile" || true)"
  [ -f "$tgt" ] && cp -n "$tgt" "$TMP/" || true
done < <(find "$HOME/.config/hyde/themes" -type l \( -name 'wall.set' -o -name 'wall.hyprlock.png' \) -print0 2>/dev/null || true)

mkdir -p "$DEST"

# 2.3 deduplicar por SHA256 e salvar com nome estável (hash.ext)
for img in "$TMP"/*; do
  [ -f "$img" ] || continue
  ext="${img##*.}"; ext="${ext,,}"
  hash="$(sha256sum "$img" | awk '{print $1}')"
  out="$DEST/$hash.$ext"
  [ -e "$out" ] || cp "$img" "$out"
done

echo "OK: $(ls -1 "$DEST" | wc -l) imagens em $DEST"
