#!/bin/bash
# bootstrap_estudos_n1.sh: Carrega o plano de estudos inicial no Taskwarrior.

echo "Iniciando protocolo de carregamento de missões de estudo: Nível 1..."

# --- MÊS 1: O ALICERCE ---
task add "Definir o que é JDK e JVM. Anotar as diferenças." project:estudos.n1.java pri:H due:today+7d tags:java,core difficulty:D xp:10 quest_type:Study
task add "Instalar JDK e uma IDE (IntelliJ/VSCode). Compilar e rodar 'Olá, Mundo'." project:estudos.n1.java pri:H due:today+7d tags:java,setup difficulty:C xp:20 quest_type:Study
task add "Revisar operações aritméticas básicas na Khan Academy." project:estudos.n1.mat pri:M due:today+7d tags:matematica,fundamentos difficulty:E xp:5 quest_type:Study
task add "Definir Tensão, Corrente e Resistência. Estudar a Lei de Ohm." project:estudos.n1.eletronica pri:M due:today+7d tags:eletronica,teoria difficulty:D xp:10 quest_type:Study
task add "Navegar no sistema de arquivos usando cd, ls, pwd." project:estudos.n1.linux pri:H due:today+7d tags:linux,cli difficulty:E xp:5 quest_type:Study
task add "Criar, mover, copiar e remover arquivos/diretórios com mkdir, mv, cp, rm." project:estudos.n1.linux pri:H due:today+7d tags:linux,cli difficulty:E xp:5 quest_type:Study

echo "Carregamento de missões concluído. Execute 'kora' para iniciar a TUI."
