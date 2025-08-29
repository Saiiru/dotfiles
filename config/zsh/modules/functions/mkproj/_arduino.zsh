# _arduino.zsh: Arduino project creation for mkproj

_mkproj_arduino() {
    local name=$1
    _kora_log "Criando projeto Arduino..."
    mkdir -p src
    echo "void setup() {
  Serial.begin(9600);
  Serial.println(\"Hello, Arduino!\");
}

void loop() {
  // put your main code here, to run repeatedly:
}" > src/${name}.ino

    _kora_cli_compile --fqbn arduino:avr:uno src/${name}.ino > /dev/null 2>&1

    _kora_log "Projeto Arduino criado. Para compilar: arduino-cli compile --fqbn arduino:avr:uno src/${name}.ino"
    _kora_log "Para fazer upload: arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno src/${name}.ino"

    # Basic nvim config for Arduino
    mkdir -p .nvim
    cat > .nvim/ftplugin/arduino.vim <<EOF
" Arduino ftplugin
setlocal filetype=arduino
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

noremap <buffer> <F7> :!arduino-cli compile --fqbn arduino:avr:uno src/%:t<CR>
noremap <buffer> <F8> :!arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno src/%:t<CR>
EOF

    _kora_log "Configuração básica do nvim para Arduino adicionada em .nvim/ftplugin/arduino.vim"
}
