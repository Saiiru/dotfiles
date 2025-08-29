#!/usr/bin/env bash

# ~/.local/bin/kitty-bg.sh
# KORA: Script para gerar uma imagem de fundo cyberpunk para o Kitty usando ImageMagick.

# Verifica se o ImageMagick está instalado
if ! command -v convert &> /dev/null
then
    echo "ImageMagick (convert) não encontrado. Por favor, instale-o."
    exit 1
fi

# Define o diretório de destino
BG_DIR="$HOME/.config/kitty"
BG_FILE="$BG_DIR/background.png"

# Cores e padrões cyberpunk
CYBERPUNK_COLOR="#201C46"
ACCENT_COLOR="#22D3EE"
GRID_COLOR="#7C3AED"
GLITCH_COLOR="#FF0000"

log() { echo "🐉 KORA BG: $1"; }
error() { echo "❌ KORA BG: Erro - $1"; exit 1; }

log "Gerando background cyberpunk para o Kitty..."

# Cria uma imagem de fundo sólida e adiciona um padrão de grade
convert -size 2000x1200 xc:"$CYBERPUNK_COLOR" \
    -fill "$GRID_COLOR" -draw "line 0,0 2000,1200" \
    -fill "$GRID_COLOR" -draw "line 0,1200 2000,0" \
    -fill "$ACCENT_COLOR" -pointsize 150 -font Fira-Code-Retina \
    -annotate +50+150 "KORA" \
    -blur 0x2 \
    "$BG_FILE" || error "Falha ao criar o background."

log "Adicionando efeito de glitch..."
convert "$BG_FILE" \
    -channel R -fx "rand() < 0.1 ? r*1.2 : r" \
    -channel G -fx "rand() < 0.1 ? g*1.2 : g" \
    -channel B -fx "rand() < 0.1 ? b*1.2 : b" \
    -fill "$GLITCH_COLOR" -draw "line 100,200 1200,800" \
    "$BG_FILE" || error "Falha ao adicionar o efeito de glitch."

log "Fundo gerado com sucesso: $BG_FILE"
echo "O Kitty usará esta imagem automaticamente na próxima vez que for iniciado."
