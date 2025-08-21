# _default.zsh — Handles the creation of a standard, minimal project structure.

# _mkproj_default: Creates basic directories and a README file.
_mkproj_default() {
    _kora_log "Creating standard project structure..."
    mkdir -p src tests docs
    touch README.md
}