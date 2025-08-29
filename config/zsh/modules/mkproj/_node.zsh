# KORA Project Archetype: Node.js
# Creates a basic Node.js project structure.

_mkproj_node() {
    _kora_log "Criando projeto Node.js básico..."
    mkdir -p src tests
    echo "// index.js" > src/index.js
    echo "// test.js" > tests/test.js
    npm init -y > /dev/null 2>&1
    _kora_spin "Instalando dependências Node.js..."
    npm install > /dev/null 2>&1
    local add_dockerfile=$(_kora_confirm "Deseja adicionar um Dockerfile básico?")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adicionando Dockerfile..."
        _kora_generate_dockerfile node > Dockerfile
        _kora_log "Dockerfile adicionado."
    fi
}