#!/bin/bash
# -----------------------------------------------------------------------------
# KORA Mission Bootstrap: Nível 1 (Mês 1)
# Carrega o plano de estudos inicial no Taskwarrior.
# -----------------------------------------------------------------------------

echo "Iniciando protocolo de carregamento de missões de estudo: Nível 1..."

# --- MÊS 1: O ALICERCE ---

# Semana 1: Primeiros Passos
echo "Carregando missões da Semana 1..."
task add "Definir o que é JDK e JVM. Anotar as diferenças." project:estudos.n1.java pri:H due:today+7d tags:java,core
task add "Instalar JDK e uma IDE (IntelliJ/VSCode). Compilar e rodar 'Olá, Mundo'." project:estudos.n1.java pri:H due:today+7d tags:java,setup
task add "Revisar operações aritméticas básicas na Khan Academy." project:estudos.n1.mat pri:M due:today+7d tags:matematica,fundamentos
task add "Definir Tensão, Corrente e Resistência. Estudar a Lei de Ohm." project:estudos.n1.eletronica pri:M due:today+7d tags:eletronica,teoria
task add "Navegar no sistema de arquivos usando cd, ls, pwd." project:estudos.n1.linux pri:H due:today+7d tags:linux,cli
task add "Criar, mover, copiar e remover arquivos/diretórios com mkdir, mv, cp, rm." project:estudos.n1.linux pri:H due:today+7d tags:linux,cli

# Semana 2: Continuação dos Fundamentos
echo "Carregando missões da Semana 2..."
task add "Estudar tipos de dados primitivos em Java (int, double, boolean, char)." project:estudos.n1.java pri:H due:today+14d tags:java,core
task add "Declarar e inicializar variáveis de cada tipo primitivo." project:estudos.n1.java pri:H due:today+14d tags:java,pratica
task add "Identificar componentes: O que é uma protoboard, um LED e um resistor." project:estudos.n1.eletronica pri:M due:today+14d tags:eletronica,componentes
task add "Revisar frações e decimais na Khan Academy." project:estudos.n1.mat pri:M due:today+14d tags:matematica,fundamentos
task add "Visualizar conteúdo de arquivos com cat, less, head, tail." project:estudos.n1.linux pri:H due:today+14d tags:linux,cli

# Semana 3: Estruturas de Controle
echo "Carregando missões da Semana 3..."
task add "Estudar operadores lógicos e relacionais em Java (==, !=, &&, ||)." project:estudos.n1.java pri:H due:today+21d tags:java,core
task add "Implementar estruturas de controle if, else, else if." project:estudos.n1.java pri:H due:today+21d tags:java,pratica
task add "Montar o circuito 'Blink' no simulador (TinkerCAD/Wokwi)." project:estudos.n1.eletronica pri:M due:today+21d tags:eletronica,simulacao
task add "Entender o código 'Blink': setup(), loop(), pinMode(), digitalWrite(), delay()." project:estudos.n1.eletronica pri:M due:today+21d tags:eletronica,arduino
task add "Estudar equações de 1º grau na Khan Academy." project:estudos.n1.mat pri:M due:today+21d tags:matematica,algebra
task add "Aprender a usar 'grep' para pesquisar texto dentro de arquivos." project:estudos.n1.linux pri:H due:today+21d tags:linux,cli

# Semana 4: Continuação das Estruturas
echo "Carregando missões da Semana 4..."
task add "Criar um programa Java que resolve um problema simples usando if/else (ex: verificar se é maior de idade)." project:estudos.n1.java pri:H due:today+28d tags:java,projeto
task add "Montar o circuito 'Blink' fisicamente com o kit Arduino." project:estudos.n1.eletronica pri:H due:today+28d tags:eletronica,pratica
task add "Estudar o plano cartesiano na Khan Academy." project:estudos.n1.mat pri:M due:today+28d tags:matematica,algebra
task add "Entender permissões de arquivo. Usar 'chmod' para alterar permissões." project:estudos.n1.linux pri:M due:today+28d tags:linux,cli

echo "Carregamento de missões concluído. Execute 'task list' para ver todas as tarefas."
echo "Execute 'kora briefing' para o relatório diário de missão.
