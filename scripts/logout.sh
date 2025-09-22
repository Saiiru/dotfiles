#!/usr/bin/env bash
# fecha sessão Hyprland
hyprctl dispatch exit || loginctl terminate-user "$USER"
