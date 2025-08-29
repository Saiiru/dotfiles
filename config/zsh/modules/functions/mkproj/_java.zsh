# _java.zsh: Java project creation for mkproj

_mkproj_java() {
    local name=$1
    _kora_log "Criando projeto Java com Gradle..."
    mkdir -p src/main/java/com/example
    echo "package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println(\"Hello, Java!\");
    }
}" > src/main/java/com/example/App.java

    _kora_spin "Inicializando Gradle..."
    gradle init --type java-application --dsl groovy --project-name "$name" --package com.example > /dev/null 2>&1

    _kora_log "Projeto Java criado. Para rodar: gradle run"

    # Basic nvim config for Java
    mkdir -p .nvim
    cat > .nvim/ftplugin/java.vim <<EOF
" Java ftplugin
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

noremap <buffer> <F7> :Gradle build<CR>
noremap <buffer> <F8> :Gradle run<CR>
EOF

    _kora_log "Configuração básica do nvim para Java adicionada em .nvim/ftplugin/java.vim"
}
