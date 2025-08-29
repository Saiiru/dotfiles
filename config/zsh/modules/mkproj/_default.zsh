# KORA Project Archetype: Default
# Creates a basic project structure.

_mkproj_default() {
    _kora_log "Criando estrutura de projeto padrão..."
    mkdir -p src tests docs
    touch README.md
}