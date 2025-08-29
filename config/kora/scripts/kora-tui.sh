#!/bin/bash
# kora-tui.sh - A TUI central para seu sistema de produtividade

# --- Cores e Estilos ---
KORA_PRIMARY="#7C3AED"
GUM_INPUT_PROMPT_FOREGROUND="$KORA_PRIMARY"
gum style --border-foreground "$KORA_PRIMARY" --border double --align center --width 50 --margin "1 2" --padding "1 2" "KORA SYSTEM ONLINE"

# --- Funções da TUI ---
show_player_status() {
    # (A lógica de status.sh seria colocada aqui ou chamada)
    echo "Nível, XP e missões diárias serão exibidos aqui."
    gum spin --spinner dot --title "Calculando status..." -- sleep 2
}

manage_missions() {
    gum style 'Gerenciador de Missões'
    MISSION=$(task +PENDING export | jq -r '.[] | .description' | gum filter --placeholder "Escolha uma missão para focar...")
    if [[ -n "$MISSION" ]]; then
        ACTION=$(gum choose "Ver Detalhes" "Iniciar Foco (Pomo)" "Completar")
        # Lógica para cada ação
    fi
}

create_project() {
    gum style 'KORA :: Project Creation Protocol'
    TYPE=$(gum choose "python" "node" "react" "go" "rust" "spring" "arduino" "gamedev-c")

    if [[ -n "$TYPE" ]]; then
        NAME=$(gum input --placeholder "Nome do projeto...")
        if [[ -n "$NAME" ]]; then
            # Chama a função mkproj real com as opções
            mkproj "$TYPE" "$NAME"
        fi
    fi
}

# --- Lógica do `mkproj` Refatorado ---
mkproj() {
    local type="$1" name="$2" base_dir="$PROJECTS_DIR/$type" project_dir="$base_dir/$name"
    mkdir -p "$project_dir" && cd "$project_dir" || exit 1

    gum spin --spinner dot --title "Criando projeto $name..." -- bash -c "
    case "$type" in
        spring)
            JAVA_VER=$(gum choose "21" "17" "11")
            BUILD_TOOL=$(gum choose "maven" "gradle")
            DEPS=$(gum input --placeholder "Dependências (e.g., web,data-jpa)")
            spring init --dependencies=\"$DEPS\" --java-version=\"$JAVA_VER\" --name=\"$name\" --build=\"$BUILD_TOOL\" --extract . 
            ;;
        arduino)
            arduino-cli sketch new \"$name\"
            mv \"$name\"/* .
            rmdir \"$name\"
            # Configurar IDE?
            ;;
        gamedev-c)
            # Exemplo de setup para C com Makefile
            echo '# Makefile para projeto C
CC=gcc
CFLAGS=-Iinclude -Wall -g

all: build/main

build/main: src/main.c
	$(CC) $(CFLAGS) -o $@ $^

run:
	./build/main

clean:
	rm -f build/*'
            mkdir -p src include build
            echo '#include <stdio.h>
int main() { printf("Hello, GameDev!\n"); return 0; }'
            ;;
        *)
            # Lógica padrão para outros tipos
            mkdir -p src tests
            ;;
    esac
    git init &>/dev/null && git add . &>/dev/null && git commit -m "Initial commit" &>/dev/null
    "

    gum style --foreground "$KORA_GREEN" "✅ Projeto '$name' criado em $project_dir"
}

# --- Menu Principal ---
while true; do
    CHOICE=$(gum choose "Status do Player" "Gerenciar Missões" "Criar Projeto" "Sair")
    case "$CHOICE" in
        "Status do Player") show_player_status ;;
        "Gerenciar Missões") manage_missions ;;
        "Criar Projeto") create_project ;;
        "Sair") break ;;
    esac
done
