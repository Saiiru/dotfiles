#!/usr/bin/env bash
set -euo pipefail

PROFILE_DIR="${1:-/home/sairu/.mozilla/si0fy9p4.kora}"
DOTDIR="${DOTDIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)}/config/firefox"

echo "[info] Perfil alvo: $PROFILE_DIR"
mkdir -p "$PROFILE_DIR/chrome"

# user.js
ln -sf "$DOTDIR/profile/user.js" "$PROFILE_DIR/user.js"

# chrome/ (userChrome + userContent)
ln -sf "$DOTDIR/profile/chrome/userChrome.css" "$PROFILE_DIR/chrome/userChrome.css"
ln -sf "$DOTDIR/profile/chrome/userContent.css" "$PROFILE_DIR/chrome/userContent.css"

# policies.json opcional (se tiver permissão de escrita)
if [ -f "$DOTDIR/policies/policies.json" ]; then
  if [ -d /usr/lib/firefox ]; then
    sudo mkdir -p /usr/lib/firefox/distribution
    sudo ln -sf "$DOTDIR/policies/policies.json" /usr/lib/firefox/distribution/policies.json
  elif [ -d "$HOME/.var/app/org.mozilla.firefox" ]; then
    mkdir -p "$HOME/.var/app/org.mozilla.firefox/.mozilla/firefox/distribution"
    ln -sf "$DOTDIR/policies/policies.json" "$HOME/.var/app/org.mozilla.firefox/.mozilla/firefox/distribution/policies.json"
  fi
fi

# Wayland/AMD: ative VA-API por ambiente (systemd --user)
UNIT="$HOME/.config/systemd/user/firefox-vaapi.env"
mkdir -p "$(dirname "$UNIT")"
cat > "$UNIT" <<'EOF'
[Unit]
Description=Env Firefox VA-API

[Service]
Type=oneshot
Environment=MOZ_ENABLE_WAYLAND=1
Environment=LIBVA_DRIVER_NAME=radeonsi
RemainAfterExit=yes
ExecStart=/usr/bin/true

[Install]
WantedBy=default.target
EOF

systemctl --user enable --now firefox-vaapi.env || true

echo "[done] Links aplicados."
echo "Reinicie o Firefox. Em about:config verifique: widget.dmabuf.force-enabled=true e media.ffmpeg.vaapi.enabled=true."
