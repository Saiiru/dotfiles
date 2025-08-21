#!/usr/bin/env zsh
# mkproj.zsh — KORA Universal Project Creator (Interactive TUI Edition).

# Source modular components for project archetypes.
for f in "${0:h}/mkproj"/*.zsh(N); do
  source "$f"
done

# mkproj: Main function to guide the user through project creation.
mkproj() {
    gum style \
        --border double \
        --align center \
        --width 60 \
        --margin "1 2" \
        --padding "1 2" \
        --foreground "$KORA_PRIMARY" \
        "KORA :: PROJECT CREATION PROTOCOL"

    local project_types=(
        "web: Basic web project (HTML, CSS, JS)"
        "python: Python project (Poetry)"
        "node: Node.js project (npm)"
        "go: Go project (go mod)"
        "rust: Rust project (cargo)"
        "spring: Spring Boot project (Spring Initializr)"
        "arduino: Arduino project (Arduino CLI)"
        "c: Basic C project"
        "java: Java project (Gradle)"
        "gamedev-c: GameDev project in C (SDL2)"
        "devops: Structure for DevOps projects"
        "fullstack: Fullstack project (frontend + backend)"
        "default: Standard project structure"
    )

    local type_choice=$(gum choose --header "Select project archetype:" \
                                   --cursor.foreground "$KORA_CYAN" \
                                   --selected.foreground "$KORA_GREEN" \
                                   --item.foreground "$KORA_TEXT" \
                                   --height 15 \
                                   "${project_types[@]}" | cut -d':' -f1)

    [[ -z $type_choice ]] && _kora_log "Creation cancelled." && return 1

    local name=$(gum input --placeholder "project-name" \
                           --header "Enter project name:" \
                           --cursor.foreground "$KORA_CYAN" \
                           --prompt.foreground "$KORA_YELLOW" \
                           --width 50)
    [[ -z $name ]] && _kora_log "Invalid name. Creation cancelled." && return 1

    local base_dir="${PROJECTS_DIR:-$HOME/workspace/projects}/$type_choice"
    local project_dir="$base_dir/$name"

    if [[ -d "$project_dir" ]]; then
        _kora_log "Error: Project directory already exists." && return 1
    fi

    _kora_log "Initializing '$name' project of type '$type_choice' in $project_dir"
    mkdir -p "$project_dir" && cd "$project_dir" || return 1

    case "$type_choice" in
        web)            _mkproj_web "$name" ;;
        python)         _mkproj_python "$name" ;;
        node)           _mkproj_node "$name" ;;
        go)             _mkproj_go "$name" ;;
        rust)           _mkproj_rust "$name" ;;
        spring)         _mkproj_spring "$name" "$project_dir" ;;
        arduino)        _mkproj_arduino "$name" ;;
        c)              _mkproj_c "$name" ;;
        java)           _mkproj_java "$name" ;;
        gamedev-c)      _mkproj_gamedev_c "$name" ;;
        devops)         _kora_log "DevOps functionality not yet implemented." ;; # Placeholder
        fullstack)      _kora_log "Fullstack functionality not yet implemented." ;; # Placeholder
        default)        _mkproj_default "$name" ;;
        *)
            _kora_log "Unknown project type: $type_choice"
            return 1
            ;;
    esac

    _kora_spin "Finalizing and versioning..."
    git init &>/dev/null
    git add . &>/dev/null
    git commit -m "KORA: Initial commit for project '$name' (type: $type_choice)" &>/dev/null

    gum style --foreground "$KORA_GREEN" "✅ Project '$name' created and ready for development."
    _kora_log "Starting tmux session with sesh..."
    sesh connect "$name"
}
