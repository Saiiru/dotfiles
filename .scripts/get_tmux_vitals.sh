#!/usr/bin/env bash

# KORA Tmux Vitals - Combined Status Bar Helper
# Provides various system and development vitals for the Tmux status bar.

# --- Color Palette (from Tmux environment or default) ---
# These colors should ideally be propagated from Tmux or defined centrally.
# For now, using direct hex values for robustness if not propagated.
# In a full refactor, ensure these are passed from Tmux or sourced from a common file.
neural_primary="#7C3AED"
neural_cyan="#22D3EE"
neural_green="#10B981"
neural_pink="#EC4899"
neural_yellow="#F59E0B"
neural_red="#EF4444"
neural_text="#CDD6F4"
neural_muted="#7F849C"

# --- Git Branch ---
get_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    echo "#[fg=$neural_pink] $branch#[default]"
  fi
}

# --- Node.js Version ---
get_node_version() {
  if command -v node &>/dev/null; then
    local version
    version=$(node -v)
    echo "#[fg=$neural_yellow] $version#[default]"
  fi
}

# --- Battery Status ---
get_battery_status() {
    local status capacity icon
    if command -v acpi &>/dev/null; then
        status=$(acpi -b | awk -F'[,:%]' '{print $2}')
        capacity=$(acpi -b | awk -F'[,:%]' '{print $3}')
    elif command -v pmset &>/dev/null; then # macOS
        # pmset output parsing for macOS
        local pmset_output
        pmset_output=$(pmset -g batt)
        status=$(echo "$pmset_output" | grep -oE 'charging|discharging|charged|fully charged')
        capacity=$(echo "$pmset_output" | grep -oE '[0-9]+%' | sed 's/%//')
    else
        return
    fi

    if [[ "$status" == "Charging" || "$status" == "charged" || "$status" == "fully charged" ]]; then
        icon="#[fg=$neural_green]󰂄#[default]"
    elif [[ "$capacity" -le 20 ]]; then
        icon="#[fg=$neural_red]󰁻#[default]"
    elif [[ "$capacity" -le 50 ]]; then
        icon="#[fg=$neural_yellow]󰂀#[default]"
    else
        icon="#[fg=$neural_green]󰁹#[default]"
    fi
    echo "$icon $capacity%"
}

# --- Taskwarrior Pending Count ---
get_task_count() {
    if command -v task >/dev/null 2>&1; then
        local pending
        pending=$(task status:pending count 2>/dev/null || echo 0)
        if [[ $pending -gt 0 ]]; then
            echo "#[fg=$neural_cyan]⚑${pending}#[default]"
        fi
    fi
}

# --- System Load ---
get_load_average() {
    local load
    load=$(uptime | awk -F'load average:' '{print $2}' | awk '{printf "%.1f", $1}' 2>/dev/null || echo '0.0')
    echo "#[fg=$neural_text]󰍛 $load#[default]"
}

# --- Build Final Status String ---
status_parts=()

git_status=$(get_git_branch)
[[ -n "$git_status" ]] && status_parts+=("$git_status")

node_status=$(get_node_version)
[[ -n "$node_status" ]] && status_parts+=("$node_status")

battery_status=$(get_battery_status)
[[ -n "$battery_status" ]] && status_parts+=("$battery_status")

task_status=$(get_task_count)
[[ -n "$task_status" ]] && status_parts+=("$task_status")

load_status=$(get_load_average)
[[ -n "$load_status" ]] && status_parts+=("$load_status")

# Join parts with a separator
if [[ ${#status_parts[@]} -gt 0 ]]; then
    printf "%s" "$(IFS=" #[fg=$neural_muted]|#[default] " ; echo "${status_parts[*]}")"
else
    echo "" # Return empty if no vitals
fi
