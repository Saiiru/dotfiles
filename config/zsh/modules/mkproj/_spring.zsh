# KORA Project Archetype: Spring Boot
# Creates a Spring Boot project using Spring Initializr.

_mkproj_spring() {
    local name=$1 project_dir=$2
    _kora_log "Iniciando protocolo Spring Initializr..."
    local java_version=$(_kora_choose "Versão do Java" "21" "17" "11")
    local build_tool=$(_kora_choose "Build Tool" "maven" "gradle")
    local deps=$(_kora_input "web,data-jpa,devtools" "Dependências (separadas por vírgula)")
    _kora_spin "Contatando Spring Initializr..."
    spring init --dependencies="$deps" --java-version="$java_version" --name="$name" --groupId="dev.kora" --artifactId="$name" --package-name="dev.kora.$name" --build="$build_tool" --extract .
}