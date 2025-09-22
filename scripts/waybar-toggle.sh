#!/usr/bin/env bash
if pgrep -x waybar >/dev/null; then
  pkill -SIGTERM waybar
else
  nohup waybar >/dev/null 2>&1 &
fi
