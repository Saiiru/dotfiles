# KORA · Cheatsheet (Grimório Neo-Noir)

Este cheatsheet contém os atalhos essenciais para navegar e interagir com seu ambiente de desenvolvimento KORA, otimizado para a estética "grimório neo-noir".

## Tmux (Prefixo: `C-a`)

| Atalho      | Descrição                                       |
| :---------- | :---------------------------------------------- |
| `C-a s`     | Selecionar sessão Sesh (pop-up)                 |
| `C-a i`     | Relatório de inteligência Sesh (pop-up)         |
| `C-a K`     | Alternar sessão Sesh (pop-up principal)         |
| `C-a L`     | Voltar para a última sessão Sesh                |
| `C-a c`     | Criar nova janela no diretório atual            |
| `C-a |`     | Dividir painel verticalmente                    |
| `C-a -`     | Dividir painel horizontalmente                  |
| `C-a h/j/k/l` | Navegar entre painéis (Vim-style)               |
| `C-a C-h/j/k/l` | Navegar entre painéis (com integração Neovim) |
| `C-a H/J/K/L` | Redimensionar painel (5 unidades)               |
| `C-a M-h/j/k/l` | Redimensionar painel (1 unidade)                |
| `C-a Tab`   | Alternar para a última janela                   |
| `C-a C-h/l` | Alternar entre janelas                          |
| `C-a v`     | Entrar no modo de cópia                         |
| `C-a p`     | Colar do buffer do Tmux                         |
| `C-a C-p`   | Escolher buffer para colar                      |
| `C-a r`     | Recarregar configuração do Tmux                 |
| `C-a B`     | Alternar visibilidade da status bar             |
| `C-a Y`     | Alternar sincronização de painéis               |
| `C-a x`     | Fechar painel atual                             |
| `C-a X`     | Fechar janela atual                             |
| `C-a C-l`   | Limpar tela do painel                           |
| `C-a F1`    | Abrir monitor de sistema (btop/htop)            |
| `C-a F2`    | Abrir logs (journalctl/tail)                    |
| `C-a F3`    | Abrir Lazygit                                   |
| `C-a F4`    | Editar `~/.tmux.conf`                           |
| `C-a F5`    | Monitor de sistema simples                      |
| `C-a e`     | Abrir Neovim no diretório atual                 |
| `C-a f`     | Abrir gerenciador de arquivos (ranger/lf)       |

## Neovim

Os atalhos do Neovim são configurados para um workflow Vim-like, com foco em navegação rápida e edição eficiente. Muitos atalhos são contextuais e dependem dos plugins instalados.

| Atalho      | Descrição                                       |
| :---------- | :---------------------------------------------- |
| `<leader>ee`| Alternar visibilidade do NvimTree               |
| `<leader>ef`| Alternar NvimTree no arquivo atual              |
| `<leader>ec`| Recolher NvimTree                               |
| `<leader>er`| Atualizar NvimTree                              |
| `C-h/j/k/l` | Navegar entre janelas (com `tmux-navigator`)    |
| `:colorscheme cybersynth` | Ativar o colorscheme Grimório Neo-Noir |

### Neovim - Navegação e Edição (Vim Motions Essenciais)

| Comando | Descrição                                         |
| :------ | :------------------------------------------------ |
| `h`     | Mover cursor para a esquerda                      |
| `j`     | Mover cursor para baixo                           |
| `k`     | Mover cursor para cima                            |
| `l`     | Mover cursor para a direita                       |
| `w`     | Mover para o início da próxima palavra            |
| `b`     | Mover para o início da palavra anterior           |
| `e`     | Mover para o final da palavra atual               |
| `0`     | Mover para o início da linha                      |
| `$`     | Mover para o final da linha                       |
| `gg`    | Mover para o início do arquivo                    |
| `G`     | Mover para o final do arquivo                     |
| `H`     | Mover para o topo da tela                         |
| `M`     | Mover para o meio da tela                         |
| `L`     | Mover para a base da tela                         |
| `zz`    | Centralizar a linha atual na tela                 |
| `zt`    | Mover a linha atual para o topo da tela           |
| `zb`    | Mover a linha atual para a base da tela           |
| `i`     | Entrar no modo de inserção (antes do cursor)      |
| `a`     | Entrar no modo de inserção (depois do cursor)     |
| `o`     | Entrar no modo de inserção (nova linha abaixo)    |
| `O`     | Entrar no modo de inserção (nova linha acima)     |
| `x`     | Deletar caractere sob o cursor                    |
| `dw`    | Deletar palavra                                   |
| `dd`    | Deletar linha                                     |
| `yy`    | Copiar linha                                      |
| `p`     | Colar (depois do cursor/linha)                    |
| `P`     | Colar (antes do cursor/linha)                     |
| `u`     | Desfazer                                          |
| `Ctrl+r`| Refazer                                           |
| `.`     | Repetir última alteração                          |
| `/`     | Buscar (para frente)                              |
| `?`     | Buscar (para trás)                                |
| `n`     | Próxima ocorrência da busca                       |
| `N`     | Ocorrência anterior da busca                      |
| `:%s/old/new/g` | Substituir todas as ocorrências de 'old' por 'new' |
| `v`     | Entrar no modo visual (seleção de caracteres)     |
| `V`     | Entrar no modo visual de linha                    |
| `Ctrl+v`| Entrar no modo visual de bloco                    |
| `:w`    | Salvar arquivo                                    |
| `:q`    | Sair do Neovim                                    |
| `:wq`   | Salvar e sair                                     |
| `:q!`   | Sair sem salvar                                   |
| `:e <file>` | Abrir arquivo                                   |
| `:split`| Dividir janela horizontalmente                    |
| `:vsplit`| Dividir janela verticalmente                     |
| `Ctrl+w h/j/k/l` | Navegar entre janelas do Neovim            |
| `Ctrl+w w` | Alternar entre janelas do Neovim               |
| `Ctrl+w c` | Fechar janela do Neovim                        |
| `Ctrl+w o` | Fechar todas as janelas, exceto a atual        |

### Neovim - Text Objects (Movimentos Avançados)

Text objects são uma das características mais poderosas do Vim. Eles permitem que você execute ações (como deletar, alterar ou copiar) em blocos de texto, como palavras, sentenças, parágrafos, ou o conteúdo dentro de delimitadores.

A sintaxe geral é `[ação][i/a][delimitador]`, onde:
-   `ação`: `d` (delete), `c` (change), `y` (yank/copy)
-   `i`: "inside" (dentro do delimitador)
-   `a`: "around" (ao redor do delimitador, incluindo o delimitador)
-   `delimitador`: `w` (word), `s` (sentence), `p` (paragraph), `"` (aspas duplas), `'` (aspas simples), `( )` (parênteses), `[ ]` (colchetes), `{ }` (chaves), `t` (tags HTML/XML)

| Comando     | Descrição                                                              |
| :---------- | :--------------------------------------------------------------------- |
| `ciw`       | Change Inside Word (alterar palavra atual)                             |
| `daw`       | Delete Around Word (deletar palavra atual e um espaço)                 |
| `cis`       | Change Inside Sentence (alterar a sentença atual)                      |
| `das`       | Delete Around Sentence (deletar a sentença atual e um espaço)          |
| `cip`       | Change Inside Paragraph (alterar o parágrafo atual)                    |
| `dap`       | Delete Around Paragraph (deletar o parágrafo atual e uma linha em branco) |
| `ci"`       | Change Inside Quotes (alterar o texto dentro de aspas duplas)          |
| `da"`       | Delete Around Quotes (deletar o texto e as aspas duplas)               |
| `ci(` ou `cib` | Change Inside Parentheses (alterar o texto dentro de parênteses)       |
| `da(` ou `dab` | Delete Around Parentheses (deletar o texto e os parênteses)          |
| `ci{` ou `ciB` | Change Inside Braces (alterar o texto dentro de chaves)                |
| `da{` ou `daB` | Delete Around Braces (deletar o texto e as chaves)                   |
| `cit`       | Change Inside Tag (alterar o conteúdo de uma tag HTML/XML)             |
| `dat`       | Delete Around Tag (deletar o conteúdo e a tag HTML/XML)                |

### Neovim - Navegação Intra-linha

| Comando | Descrição                                                              |
| :------ | :--------------------------------------------------------------------- |
| `f{char}` | Find (encontrar) o próximo caractere `{char}` na linha atual          |
| `F{char}` | Find (encontrar) o caractere `{char}` anterior na linha atual         |
| `t{char}` | Till (até) o próximo caractere `{char}` na linha atual (cursor para antes) |
| `T{char}` | Till (até) o caractere `{char}` anterior na linha atual (cursor para antes) |
| `;`       | Repetir o último comando `f`, `F`, `t`, ou `T`                         |
| `,`       | Repetir o último comando `f`, `F`, `t`, ou `T` na direção oposta      |

## Kitty

| Atalho          | Descrição                                       |
| :-------------- | :---------------------------------------------- |
| `Ctrl+Shift+T`  | Abrir nova aba (Zsh)                            |
| `Ctrl+Shift+Enter` | Abrir nova janela (Zsh)                       |
| `Ctrl+Shift+N`  | Abrir Neovim em nova aba                        |
| `Ctrl+Shift+G`  | Abrir Lazygit em nova aba                       |
| `Ctrl+Shift+C`  | Copiar seleção para clipboard                   |
| `Ctrl+Shift+V`  | Colar do clipboard                              |
| `Ctrl+Shift+S`  | Lançar Sesh (pop-up)                            |

## Ghostty

| Atalho          | Descrição                                       |
| :-------------- | :---------------------------------------------- |
| `Ctrl+Shift+N`  | Abrir nova aba                                  |
| `Ctrl+Shift+T`  | Abrir nova aba                                  |
| `Ctrl+Shift+W`  | Fechar janela                                   |
| `Ctrl+Shift+Q`  | Fechar aba                                      |
| `Ctrl+Shift+L`  | Próxima aba                                     |
| `Ctrl+Shift+H`  | Aba anterior                                    |
| `Ctrl+Shift+G`  | Lançar Lazygit                                  |
| `Ctrl+Shift+F`  | Lançar FZF                                      |
| `Ctrl+Shift+S`  | Lançar Spring Initializr CLI                    |
| `Ctrl+Shift+D`  | Lançar Docker Compose Up                        |
| `Ctrl+Shift+A`  | Lançar Arduino IDE                              |
| `Ctrl+Shift+L`  | Lançar Sesh (pop-up)                            |