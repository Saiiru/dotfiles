# KORA Project Archetype: Python
# Creates a basic Python project structure with Poetry and Mise integration.

_mkproj_python() {
    local name=$1
    _kora_log "Criando projeto Python básico..."
    mkdir -p src tests
    touch src/__init__.py
    echo "# main.py" > src/main.py
    echo "# test_main.py" > tests/test_main.py
    echo "[tool.poetry]\nname = \"$name\"\nversion = \"0.1.0\"\ndescription = \"\"\nauthors = [\"Your Name <you@example.com>\"]\nreadme = \"README.md\"\n\n[tool.poetry.dependencies]\npython = \"^3.12\"\n\n[build-system]\nrequires = [\"poetry-core\"]\nbuild-backend = \"poetry.core.masonry.api\"\n" > pyproject.toml
    _kora_spin "Inicializando ambiente virtual com Poetry..."
    poetry install --no-root > /dev/null 2>&1
    _kora_log "Ambiente virtual criado. Ative com 'poetry shell'."
    echo "[tools]\npython = \"3.12\" # Specify the Python version you want to use for the venv\n\n[env]\n_.python.venv = { path = \".venv\", create = true }\n" > mise.toml
    _kora_log "mise.toml adicionado para ativação automática do ambiente virtual."
    local add_dockerfile=$(_kora_confirm "Deseja adicionar um Dockerfile básico?")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adicionando Dockerfile..."
        _kora_generate_dockerfile python > Dockerfile
        _kora_log "Dockerfile adicionado."
    fi
}
