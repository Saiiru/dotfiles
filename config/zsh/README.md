# Arquitetura de Configuração Zsh

Bem-vindo à configuração central do Zsh. Este diretório implementa uma estrutura Zsh modular, limpa e compatível com a Especificação de Diretório Base XDG.

## Filosofia

O objetivo é evitar um arquivo `.zshrc` monolítico. Em vez disso, a configuração é dividida em módulos lógicos e auto-contidos que são carregados em uma ordem previsível. Isso torna o gerenciamento, a depuração e a personalização significativamente mais fáceis.

## O Fluxo de Carregamento

Entender a ordem de carregamento é fundamental para trabalhar com esta configuração.

1.  **O Ponto de Entrada (`~/.zshenv`)**
    O Zsh começa lendo `~/.zshenv`. Este é o **único arquivo** que deve estar no seu diretório home (`$HOME`). Seu único propósito é dizer ao Zsh onde o resto da sua configuração vive, definindo a variável de ambiente `$ZDOTDIR`.

2.  **O Carregador Principal (`$ZDOTDIR/.zshrc`)**
    Uma vez que `$ZDOTDIR` está definido, o Zsh sabe onde procurar o `.zshrc`. Este arquivo não contém nenhuma configuração real. Ele atua como um orquestrador que simplesmente carrega todos os nossos módulos na ordem correta usando laços `for`.

3.  **Os Módulos (`$ZDOTDIR/modules/`)**
    É aqui que toda a configuração reside. Os arquivos no diretório `modules` são prefixados com números para garantir uma ordem de carregamento determinística. Eles são carregados em sequência, de `00-*` a `60-*`.

## Detalhamento da Estrutura de Arquivos

```
.
├── .zshrc          # O carregador principal que executa os módulos.
├── zshenv          # O arquivo de bootstrap (destinado a ser linkado para ~/.zshenv).
└── modules/
    ├── 00-env.zsh
    ├── 10-core.zsh
    ├── 20-aliases.zsh
    ├── 30-completion_and_style.zsh
    ├── 40-keybinds.zsh
    ├── 45-zinit_bootstrap.zsh
    ├── 50-plugins.zsh
    ├── 60-prompt.zsh
    ├── functions/      # Contém funções de shell personalizadas.
    │   ├── ff.zsh
    │   ├── mkcd.zsh
    │   └── ...
    └── functions/mkproj/ # Arquétipos para o utilitário de criação de projetos.
        ├── _default.zsh
        ├── _node.zsh
        └── ...
```

-   **`zshenv`**: Define `$ZDOTDIR`. Deve ser linkado simbolicamente para `~/.zshenv`.
-   **`.zshrc`**: Executa laços para carregar todos os arquivos `.zsh` dos diretórios de módulos.
-   **`modules/`**:
    -   `00-env.zsh`: Variáveis de ambiente, `$PATH`, e configurações globais.
    -   `10-core.zsh`: Opções fundamentais do Zsh (`setopt`), configurações de histórico.
    -   `20-aliases.zsh`: Seus aliases de comando (`alias g='git'`).
    -   `30-completion_and_style.zsh`: Configuração do sistema de autocompletar (`compinit`, `zstyle`).
    -   `40-keybinds.zsh`: Atalhos de teclado personalizados (`bindkey`).
    -   `45-zinit_bootstrap.zsh`: Instala e inicializa o gerenciador de plugins Zinit.
    -   `50-plugins.zsh`: Declarações de plugins a serem carregados pelo Zinit.
    -   `60-prompt.zsh`: Configuração do prompt (Oh My Posh, etc.).
-   **`modules/functions/`**: Cada arquivo `.zsh` aqui é carregado como uma função de shell.
-   **`modules/functions/mkproj/`**: Um diretório especial para o utilitário `mkproj`. Veja o `README.md` dentro dele para mais detalhes.

## Como Personalizar

-   **Para Adicionar um Novo Alias**: Simplesmente adicione uma nova linha ao arquivo `modules/20-aliases.zsh`.
-   **Para Adicionar uma Nova Função**: Crie um novo arquivo `minha_funcao.zsh` dentro de `modules/functions/`. Ele será carregado automaticamente.
-   **Para Adicionar um Novo Plugin**: Adicione uma nova linha `zinit load ...` ao arquivo `modules/50-plugins.zsh`.

Seguindo este padrão, você pode manter sua configuração organizada e fácil de gerenciar.