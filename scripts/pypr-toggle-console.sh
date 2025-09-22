#!/usr/bin/env bash
if command -v pypr >/dev/null 2>&1; then
  pypr toggle console
else
  # fallback: scratchpad com kitty
  hyprctl dispatch exec "[workspace special:scratchpad silent] kitty --class dropterm"
  hyprctl dispatch togglespecialworkspace
fi
