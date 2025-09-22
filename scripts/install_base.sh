#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Syu --needed --noconfirm \
  base-devel git curl unzip zip rsync zsh neovim kitty fastfetch eza bat ripgrep fd fzf zoxide btop \
  pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack pavucontrol \
  networkmanager bluez bluez-utils polkit \
  hyprland waybar wofi grim slurp satty wl-clipboard cliphist mako playerctl brightnessctl \
  xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland \
  ttf-jetbrains-mono-nerd ttf-rubik noto-fonts noto-fonts-emoji

systemctl --user enable --now cliphist.service || true
sudo systemctl enable --now NetworkManager bluetooth

# Wayland env
sudo mkdir -p /etc/environment.d
sudo tee /etc/environment.d/10-wayland.conf >/dev/null <<'EOT'
XDG_CURRENT_DESKTOP=Hyprland
XDG_SESSION_TYPE=wayland
GDK_BACKEND=wayland,x11
QT_QPA_PLATFORM=wayland
SDL_VIDEODRIVER=wayland
CLUTTER_BACKEND=wayland
MOZ_ENABLE_WAYLAND=1
EOT

# SDDM
sudo pacman -S --needed --noconfirm sddm
sudo systemctl enable --now sddm

# ZRAM
sudo pacman -S --needed --noconfirm zram-generator
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<'EOT'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
EOT
sudo systemctl daemon-reload
# ativa no boot automaticamente; sobe já:
sudo systemctl start dev-zram0.swap || sudo systemctl start /dev/zram0.swap || true

echo "✔ base pronta."
