#!/usr/bin/env bash
set -euo pipefail
dest="$HOME/dotfiles/wallpapers/_flat"
man="$HOME/dotfiles/wallpapers/manifests/manifest.txt"
mkdir -p "$dest"
while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  url="${line%% -> *}"; name="${line##* -> }"
  tmp="$(mktemp)"
  echo "baixando $name ..."
  curl -fsSL "$url" -o "$tmp"
  ext="${name##*.}"; ext="${ext,,}"
  hash="$(sha256sum "$tmp" | awk '{print $1}')"
  out="$dest/$hash.$ext"
  mv -f "$tmp" "$out"
done < "$man"
echo "OK: baixados para $dest"
