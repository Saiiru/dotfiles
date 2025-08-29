# KORA Project Archetype: Rust
# Creates a basic Rust project structure.

_mkproj_rust() {
    local name=$1
    _kora_log "Criando projeto Rust básico..."
    cargo new "$name" --bin
    _kora_spin "Compilando projeto Rust..."
    cargo build > /dev/null 2>&1
    local add_dockerfile=$(_kora_confirm "Deseja adicionar um Dockerfile básico?")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adicionando Dockerfile..."
        _kora_generate_dockerfile rust "$name" > Dockerfile
        _kora_log "Dockerfile adicionado."
    fi
}