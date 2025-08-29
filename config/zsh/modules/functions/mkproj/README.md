# `mkproj` - KORA Universal Project Creator

`mkproj` is an interactive, TUI-based Zsh script designed to streamline the process of scaffolding new development projects. It automates the creation of basic project structures, initializes version control, and sets up editor-specific configurations, allowing you to jump straight into coding.

## Usage

To use `mkproj`, simply run the command in your terminal:

```bash
mkproj
```

Follow the on-screen prompts to:

1.  **Select Project Archetype:** Choose from a list of supported project types (e.g., Web, Python, Go, Rust, Arduino, C, Java, GameDev C, Spring Boot, DevOps, Fullstack, Default).
2.  **Enter Project Name:** Provide a name for your new project.

The script will then:

-   Create the project directory.
-   Generate the basic file and folder structure for the chosen archetype.
-   Initialize a Git repository.
-   Perform language-specific setup (e.g., `go mod init`, `npm init`, `cargo new`, `poetry install`, `gradle init`).
-   Optionally add a basic `Dockerfile` for containerization.
-   **Integrate with Neovim:** Create a project-local `.nvim/ftplugin/` directory with filetype-specific Vim scripts (`.vim` files) that define useful keybindings for building and running your project directly from Neovim.
-   Initiate a `tmux` session (using `sesh`) and open the project in Neovim.

## Supported Project Types and Generated Files

Below is a detailed overview of the project types `mkproj` supports and the typical files it generates. Each project type includes basic setup for building/running and Neovim integration.

### 1. Web (HTML, CSS, JS)

-   **Description:** A standard frontend web project with basic HTML, CSS, and JavaScript files.
-   **Generated Files:**
    -   `public/index.html`
    -   `public/css/style.css`
    -   `public/js/main.js`

### 2. Python (Poetry)

-   **Description:** A Python project managed with Poetry, including a virtual environment setup and `mise` integration for automatic activation.
-   **Generated Files:**
    -   `src/__init__.py`
    -   `src/main.py`
    -   `tests/test_main.py`
    -   `pyproject.toml` (Poetry configuration)
    -   `mise.toml` (Mise configuration for auto-activating venv)
    -   `Dockerfile` (optional, basic Python Dockerfile)
-   **Neovim Integration:** `.nvim/ftplugin/python.vim` with keybindings for running Python files.

### 3. Node.js (npm)

-   **Description:** A basic Node.js project initialized with `npm`.
-   **Generated Files:**
    -   `src/index.js`
    -   `tests/test.js`
    -   `package.json` (npm configuration)
    -   `Dockerfile` (optional, basic Node.js Dockerfile)
-   **Neovim Integration:** `.nvim/ftplugin/javascript.vim` with keybindings for running Node.js scripts.

### 4. Go (go mod)

-   **Description:** A Go project initialized with Go Modules.
-   **Generated Files:**
    -   `cmd/main.go`
    -   `go.mod`, `go.sum`
    -   `Dockerfile` (optional, basic Go Dockerfile)
-   **Neovim Integration:** `.nvim/ftplugin/go.vim` with keybindings for building and running Go applications.

### 5. Rust (cargo)

-   **Description:** A Rust project initialized with Cargo.
-   **Generated Files:**
    -   `src/main.rs`
    -   `Cargo.toml`, `Cargo.lock`
    -   `Dockerfile` (optional, basic Rust Dockerfile)
-   **Neovim Integration:** `.nvim/ftplugin/rust.vim` with keybindings for building and running Rust applications.

### 6. Spring Boot (Spring Initializr)

-   **Description:** A Spring Boot project generated using the Spring Initializr CLI, with selected dependencies.
-   **Generated Files:** Standard Spring Boot project structure (e.g., `src/main/java/...`, `pom.xml` or `build.gradle`).
-   **Neovim Integration:** `.nvim/ftplugin/java.vim` with keybindings for building and running Spring Boot applications (via Gradle/Maven).

### 7. Arduino (Arduino CLI)

-   **Description:** An Arduino project set up for use with `arduino-cli`.
-   **Generated Files:**
    -   `src/<project_name>.ino` (main sketch file)
-   **Neovim Integration:** `.nvim/ftplugin/arduino.vim` with keybindings for compiling and uploading Arduino sketches.

### 8. C (basic)

-   **Description:** A basic C project with a `main.c` and a `Makefile` for compilation.
-   **Generated Files:**
    -   `src/main.c`
    -   `Makefile`
-   **Neovim Integration:** `.nvim/ftplugin/c.vim` with keybindings for compiling and running C programs.

### 9. Java (Gradle)

-   **Description:** A basic Java application project initialized with Gradle.
-   **Generated Files:**
    -   `src/main/java/com/example/App.java`
    -   `build.gradle`, `settings.gradle`, `gradlew`, etc.
-   **Neovim Integration:** `.nvim/ftplugin/java.vim` with keybindings for building and running Java applications (via Gradle).

### 10. GameDev in C (SDL2)

-   **Description:** A C game development project with a basic SDL2 setup and a `Makefile`.
-   **Generated Files:**
    -   `src/main.c`
    -   `Makefile` (configured for SDL2)
-   **Neovim Integration:** `.nvim/ftplugin/c.vim` with keybindings for compiling and running C game projects.

### 11. DevOps

-   **Description:** Placeholder for future DevOps project structures.

### 12. Fullstack

-   **Description:** Placeholder for future Fullstack project structures.

### 13. Default

-   **Description:** A minimal project structure with basic directories.
-   **Generated Files:**
    -   `src/`, `tests/`, `docs/` directories
    -   `README.md`

## Customization

You can customize `mkproj` by modifying the helper scripts in `modules/functions/mkproj/` or by adding new ones. Ensure new helper scripts are sourced by `modules/functions/mkproj.zsh`.
