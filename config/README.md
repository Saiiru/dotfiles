# KORA · Ambiente de Desenvolvimento (Grimório Neo-Noir)

Este diretório contém a configuração centralizada para o seu ambiente de desenvolvimento KORA, projetado para um workflow minimalista, coeso e de alta performance, com uma estética "grimório neo-noir" inspirada em cyberpunk e ficção científica sombria.

## Filosofia e Recursos Principais

Nosso objetivo é um ambiente:

-   **Visualmente Coeso:** Cores, fontes e opacidade sincronizadas entre Neovim, Tmux, Kitty e Ghostty, criando uma experiência imersiva e discreta.
-   **Produtivo e Performático:** Otimizações no Zsh e integração inteligente entre as ferramentas garantem velocidade e responsividade.
-   **Navegação Fluida:** Atalhos e pop-ups dedicados para gerenciamento de sessões (Sesh), navegação de arquivos (NvimTree) e acesso rápido a ferramentas.
-   **Fácil de Manter e Estender:** Estrutura modular com comentários claros, facilitando futuras personalizações.
-   **Estética "Grimório Neo-Noir":** Fundo escuro, translúcido, com acentos neon vibrantes que guiam o olhar sem poluir a interface.

## Componentes Integrados

Este ambiente integra e otimiza os seguintes componentes:

-   **[Tmux](https://github.com/tmux/tmux):** Multiplexador de terminal. Gerencia sessões, janelas e painéis. É o coração do workflow, com status bar minimalista e integração profunda com Sesh e Neovim.
-   **[Sesh](https://github.com/joshmedeski/sesh):** Gerenciador de sessões de terminal e projetos. Permite navegar e reconectar rapidamente a projetos, com integração via pop-ups no Tmux.
-   **[Kitty](https://sw.kovidgoyal.org/kitty/):** Emulador de terminal rápido e rico em recursos. Configurado com fontes, cores e opacidade alinhadas ao tema.
-   **[Ghostty](https://github.com/ghostty/ghostty):** Emulador de terminal moderno (opcional). Configurado para replicar a estética do Kitty.
-   **[Neovim](https://neovim.io/):** Editor de texto. Integrado visualmente com o colorscheme `cybersynth` e funcionalmente com navegação de painéis do Tmux e NvimTree.
-   **[Zsh](https://www.zsh.org/):** Shell. Otimizado para performance com Zinit e configurações modulares para plugins, completions e prompt.

## Guia de Configuração e Instalação (Symlinks)

Para ativar este ambiente, você deve criar symlinks dos arquivos de configuração neste diretório (`~/dotfiles/config/`) para o seu diretório de configuração padrão (`~/.config/`).

**Passos:**

1.  **Faça backup** de suas configurações existentes em `~/.config/` antes de prosseguir:
    ```bash
    mkdir -p ~/.config.bak
    mv ~/.config/tmux ~/.config.bak/tmux 2>/dev/null
    mv ~/.config/kitty ~/.config.bak/kitty 2>/dev/null
    mv ~/.config/nvim ~/.config.bak/nvim 2>/dev/null
    mv ~/.config/zsh ~/.config.bak/zsh 2>/dev/null
    mv ~/.config/sesh ~/.config.bak/sesh 2>/dev/null
    mv ~/.config/ghostty ~/.config.bak/ghostty 2>/dev/null
    # Adicione outros diretórios que você queira fazer backup
    ```

2.  **Crie os symlinks:**
    ```bash
    ln -sfn ~/dotfiles/config/tmux ~/.config/tmux
    ln -sfn ~/dotfiles/config/kitty ~/.config/kitty
    ln -sfn ~/dotfiles/config/nvim ~/.config/nvim
    ln -sfn ~/dotfiles/config/zsh ~/.config/zsh
    ln -sfn ~/dotfiles/config/sesh ~/.config/sesh
    ln -sfn ~/dotfiles/config/ghostty ~/.config/ghostty
    # Certifique-se de que o ~/.zshrc principal esteja apontando para o correto
    # Se você tem um ~/.zshrc na raiz, ele deve carregar o ~/.config/zsh/.zshrc
    # Ex: source ~/.config/zsh/.zshrc
    ```

3.  **Instale as dependências:**
    *   **Nerd Fonts:** Certifique-se de ter uma Nerd Font instalada (ex: `CascadiaCodePL Nerd Font` ou `MesloLGS NF`).
    *   **Tmux Plugin Manager (TPM):** Instale o TPM para gerenciar os plugins do Tmux:
        ```bash
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        ```
    *   **Plugins do Tmux:** Inicie o Tmux (`tmux`) e pressione `prefix + I` (normalmente `C-a I`) para instalar os plugins.
    *   **Zinit:** O Zinit será baixado automaticamente na primeira vez que o Zsh for iniciado, mas você pode forçar a instalação manual se preferir:
        ```bash
        git clone https://github.com/zdharma-continuum/zinit.git ${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git
        ```
    *   **Outras Ferramentas:** `fzf`, `bat`, `eza`, `sesh`, `lazygit`, `btop`, `ranger` (ou `lf`), `wl-clipboard` (para Wayland).

4.  **Reinicie seus terminais** para que as novas configurações sejam aplicadas.

## Guia de Workflow

### Gerenciamento de Sessões com Sesh e Tmux

-   **Abrir/Conectar a um Projeto:**
    -   Use `sesh new <nome_do_projeto>` para criar uma nova sessão.
    -   Use `sesh connect <nome_do_projeto>` para reconectar.
    -   No Tmux, use `C-a s` para um seletor rápido de sessões Sesh.
    -   Para o seletor principal de sessões Sesh, use `C-a K`.
-   **Navegação Rápida:** `C-a L` para voltar à última sessão.

### Navegação no Neovim e Tmux

-   **Entre Painéis:** Use `C-a h/j/k/l` para navegar entre os painéis do Tmux. Se você estiver no Neovim, esses mesmos atalhos o levarão para fora do Neovim para o painel adjacente, e vice-versa (integração `tmux-navigator`-like).
-   **Navegação de Arquivos:** Use `C-a e` para abrir o Neovim no diretório atual, e dentro do Neovim, use `<leader>ee` para alternar o NvimTree.

### Cheatsheet Integrado

-   Para uma referência rápida de todos os atalhos do ambiente, pressione `C-a ?` no Tmux. Isso abrirá um pop-up com o cheatsheet completo.

### Efeito "Doom-Fire" (Tmux)

-   O plugin `tmux-fire` está incluído. Após instalar os plugins do Tmux (`C-a I`), você pode ativá-lo. Consulte a documentação do `tmux-fire` para os atalhos específicos (geralmente `prefix + F` ou similar).

## Solução de Problemas e Dicas

-   **Performance do Zsh:** Se notar lentidão, verifique o cache de completions (`~/.cache/zsh/.zcompcache`) e certifique-se de que as dependências (`fzf`, `bat`, `eza`) estão instaladas e no PATH.
-   **Cores Incorretas:** Certifique-se de que seu terminal está configurado para `truecolor` (24-bit) e que as Nerd Fonts estão corretamente instaladas e selecionadas no Kitty/Ghostty.
-   **Symlinks:** Se um componente não estiver funcionando, verifique se o symlink está correto (`ls -l ~/.config/<componente>`).

---

**KORA: Protocolo de Ambiente Ativado. Bem-vindo à Matriz Grimório Neo-Noir.**
