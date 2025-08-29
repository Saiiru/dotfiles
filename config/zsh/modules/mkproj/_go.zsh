# KORA Project Archetype: Go
# Creates a basic Go project structure.

_mkproj_go() {
    local name=$1
    _kora_log "Criando projeto Go básico..."
    mkdir -p cmd pkg internal
    echo "package main\n\nimport \"fmt\"\n\nfunc main() {\n    fmt.Println(\"Hello, Go!\")\n}" > cmd/main.go
    go mod init "$name" > /dev/null 2>&1
    _kora_spin "Organizando módulos Go..."
    go mod tidy > /dev/null 2>&1
    local add_dockerfile=$(_kora_confirm "Deseja adicionar um Dockerfile básico?")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adicionando Dockerfile..."
        _kora_generate_dockerfile go > Dockerfile
        _kora_log "Dockerfile adicionado."
    fi
}
