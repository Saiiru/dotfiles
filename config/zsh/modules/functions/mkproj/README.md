# Utilitário `mkproj` - Criação de Projetos

## Visão Geral

`mkproj` é uma função de shell que automatiza a criação de novos diretórios de projeto a partir de modelos pré-definidos, conhecidos como "arquétipos". Ele agiliza o processo de iniciar um novo projeto, criando uma estrutura de diretórios e arquivos comuns para um tipo de projeto específico.

## Uso

A sintaxe do comando é:

```sh
mkproj <nome_do_projeto> [arquétipo]
```

-   `<nome_do_projeto>`: O nome do diretório do projeto a ser criado.
-   `[arquétipo]`: (Opcional) O nome do modelo a ser usado. Se omitido, o arquétipo `default` será usado.

### Exemplos

```sh
# Criar um novo site usando o arquétipo 'web'
mkproj meu-novo-site web

# Criar uma nova ferramenta de linha de comando em Python
mkproj minha-cli-python python

# Criar um projeto genérico usando o arquétipo 'default'
mkproj meu-projeto-aleatorio
```

## Como Funciona

1.  O comando `mkproj` (definido em `modules/functions/mkproj.zsh`) é invocado com um nome de projeto e um arquétipo opcional.
2.  Ele cria um diretório com o nome do projeto e entra nele.
3.  Em seguida, ele procura por um arquivo chamado `_<arquétipo>.zsh` dentro deste diretório (`modules/functions/mkproj/`).
4.  Se um arquivo correspondente for encontrado, ele o executa (`source`).
5.  Se nenhum arquétipo for fornecido ou se um arquétipo correspondente não for encontrado, ele executa `_default.zsh` como fallback.
6.  Cada script de arquétipo é responsável por gerar a estrutura de arquivos específica para aquele tipo de projeto (por exemplo, criar um `package.json` para `node`, um `Cargo.toml` para `rust`, etc.).

## Arquétipos Disponíveis

Os seguintes arquétipos estão atualmente disponíveis:

-   `arduino`
-   `c`
-   `default`
-   `gamedev_c`
-   `go`
-   `java`
-   `node`
-   `python`
-   `rust`
-   `spring`
-   `web`

## Como Personalizar

É fácil estender o `mkproj` com seus próprios arquétipos.

### Para Modificar um Arquétipo

Simplesmente edite o arquivo `_<arquétipo>.zsh` correspondente neste diretório para alterar a estrutura que ele gera.

### Para Adicionar um Novo Arquétipo

1.  Crie um novo arquivo chamado `_<meu_arquétipo>.zsh` neste diretório.
2.  Dentro do arquivo, adicione os comandos de shell necessários para construir a estrutura do seu projeto. Você pode usar `echo`, `mkdir`, `touch`, etc.

    **Exemplo de um novo arquétipo `_simple-c`:**

    ```sh
    # _simple-c.zsh

    echo "#include <stdio.h>" > main.c
    echo "int main() { printf(\"Hello, World!\\n\"); return 0; }" >> main.c

    echo "CC=gcc" > Makefile
    echo "CFLAGS=-Wall -g" >> Makefile
    echo "all: main" >> Makefile
    echo "main: main.c" >> Makefile
    echo "		$(CC) $(CFLAGS) -o main main.c" >> Makefile
    echo "clean:" >> Makefile
    echo "	rm -f main" >> Makefile

    echo "Projeto C simples criado."
    ```

3.  Agora você pode usá-lo com `mkproj meu-projeto-c simple-c`.