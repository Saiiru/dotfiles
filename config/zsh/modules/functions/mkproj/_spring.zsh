# _spring.zsh — Handles the creation of a Spring Boot project.

# _mkproj_spring: Sets up a Spring Boot project using Spring Initializr.
_mkproj_spring() {
    _kora_log "Initiating Spring Initializr protocol..."
    local name=$1 project_dir=$2

    local java_version=$(gum choose "21" "17" "11" --header "Java Version")
    local build_tool=$(gum choose "maven" "gradle" --header "Build Tool")
    local deps=$(gum input --placeholder "web,data-jpa,devtools" --header "Dependencies (comma-separated)")

    _kora_spin "Contacting Spring Initializr..."
    spring init --dependencies="$deps" --java-version="$java_version" --name="$name" --groupId="dev.kora" --artifactId="$name" --package-name="dev.kora.$name" --build="$build_tool" --extract .
}