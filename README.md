# Sairu's Dotfiles - KORA Neural Development Matrix

Welcome to the KORA Neural Development Matrix, a highly optimized and modular personal development environment. This repository contains my dotfiles, meticulously crafted to enhance productivity, streamline workflows, and provide a consistent experience across various development tasks.

## Overview

KORA is designed with a focus on:

-   **Modularity:** Configurations are broken down into small, manageable modules.
-   **Performance:** Optimized for fast startup times and responsive interactions.
-   **Consistency:** Provides a unified experience for different programming languages and tools.
-   **Automation:** Automates common development tasks, such as project scaffolding.

## Key Components

-   **Zsh Configuration (`config/zsh/`):**
    A highly customized Zsh setup powered by `zinit` for blazing-fast plugin management. It includes:
    -   Modular organization of aliases, functions, keybindings, and environment variables.
    -   Advanced completion and syntax highlighting.
    -   Integration with `fzf` for fuzzy finding.
    -   A custom prompt powered by Oh My Posh.

-   **Neovim Configuration (`.config/nvim/`):**
    My personal Neovim setup, optimized for software development with LSP, completion, and various productivity plugins.

-   **`mkproj` - Universal Project Creator (`config/zsh/modules/functions/mkproj/`):**
    An interactive TUI-based script to scaffold new projects for various programming languages and frameworks. It automates initial setup, including:
    -   Web (HTML, CSS, JS)
    -   Python (Poetry)
    -   Node.js (npm)
    -   Go (go mod)
    -   Rust (cargo)
    -   Spring Boot (Spring Initializr)
    -   Arduino (Arduino CLI)
    -   C (basic)
    -   Game Development in C (SDL2)
    -   And more, with extensible templates.
    
    `mkproj` also generates project-local Neovim configurations (`.nvim/ftplugin/`) to provide language-specific build and run commands directly within your editor.

-   **Other Configurations:**
    Includes configurations for `tmux`, `kitty`, `btop`, `rofi`, and other essential CLI tools.

## Installation

To set up KORA, clone this repository and run the `bootstrap.sh` script (if available) or manually link the configuration files.

```bash
git clone https://github.com/sairu/dotfiles.git ~/dotfiles
cd ~/dotfiles
# Run bootstrap.sh if it exists, otherwise manually link
./bootstrap.sh # (Example, script might not exist or need adjustments)
```

## Usage

After installation, open a new terminal session. You can start by using `mkproj` to create a new project:

```bash
mkproj
```

Follow the on-screen prompts to select your project type and name. The script will set up the basic structure, initialize a Git repository, and open it in a `tmux` session with Neovim.

## Contributing

Feel free to explore, adapt, or contribute to these dotfiles. If you find issues or have suggestions, please open an issue or pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
