# KORA Project Archetype: GameDev (C)
# Creates a basic C game development project structure with a Makefile.

_mkproj_gamedev_c() {
    _kora_log "Construindo arena para GameDev (C)..."
    mkdir -p src include build assets
    cat > Makefile <<'EOF'
CC=gcc
CFLAGS=-Iinclude -Wall -g -lSDL2 -lSDL2_image

all: build/game

build/game: src/main.c
	$(CC) $(CFLAGS) -o $@ $^

run:
	./build/game

clean:
	rm -f build/*
EOF
    cat > src/main.c <<'EOF'
#include <stdio.h>

int main(int argc, char* argv[]) {
    printf("KORA Game Engine Initialized!\n");
    return 0;
}
EOF
}
