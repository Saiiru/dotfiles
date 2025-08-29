# _c.zsh: Basic C project creation for mkproj

_mkproj_c() {
    local name=$1
    _kora_log "Criando projeto C básico..."
    mkdir -p src build
    cat > src/main.c <<'EOF'
#include <stdio.h>

int main() {
    printf("Hello, C!\n");
    return 0;
}
EOF

    cat > Makefile <<EOF
CC = gcc
CFLAGS = -Wall -g

all: build/$(name)

build/$(name): src/main.c
	$(CC) $(CFLAGS) -o $@ $<

run:
	./build/$(name)

clean:
	rm -f build/*
EOF

    # Basic nvim config for C
    mkdir -p .nvim
    cat > .nvim/ftplugin/c.vim <<EOF
" C ftplugin
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

noremap <buffer> <F7> :make<CR>
noremap <buffer> <F8> :!./build/%:r<CR>
EOF

    _kora_log "Configuração básica do nvim para C adicionada em .nvim/ftplugin/c.vim"
}