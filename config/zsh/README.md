# KORA Zsh Configuration

This directory contains the core Zsh configuration for the KORA Neural Development Matrix. It's designed to be modular, performant, and easy to manage.

## Structure

The Zsh configuration is organized into several modules, each responsible for a specific aspect of the shell's behavior. The main `.zshrc` file sources these modules in a specific order to ensure proper functionality.

-   `./.zshrc`: The main Zsh configuration file. It sets up `ZDOTDIR` and sources all modules from the `modules/` directory.
-   `./modules/`:
    -   `env.zsh`: Defines essential environment variables, XDG base directories, and PATH modifications.
    -   `core.zsh`: Sets fundamental Zsh options, history settings, and core hooks.
    -   `plugins.zsh`: Manages Zsh plugins using `zinit`, including bootstrapping `zinit` itself and loading various plugins for autosuggestions, completions, fzf integration, and OMZ compatibility.
    -   `aliases.zsh`: Defines common and convenient shell aliases for frequently used commands.
    -   `keybinds.zsh`: Configures custom keybindings for navigation, history search, and interactive tools like `fzf`.
    -   `completion_and_style.zsh`: Consolidates all completion (`compinit`, `zstyle`), FZF (`zstyle`), and syntax highlighting (`ZSH_HIGHLIGHT_STYLES`) configurations. It also includes autosuggestions and zoxide initialization.
    -   `prompt.zsh`: Configures the shell prompt, primarily using Oh My Posh with a fallback simple prompt.
    -   `functions/`: Contains custom Zsh functions, including the `mkproj` universal project creator and its helper scripts.

## Key Features

-   **Modular Design:** Each aspect of the shell is managed in a separate, dedicated file, making it easy to understand, modify, and extend.
-   **Zinit Integration:** Utilizes `zinit` for fast and efficient plugin management, ensuring a responsive shell experience.
-   **XDG Base Directory Compliance:** Adheres to the XDG Base Directory Specification for cleaner file organization.
-   **Interactive Project Creation (`mkproj`):** A powerful tool to scaffold new projects with pre-configured structures and editor integrations.
-   **Neovim Integration:** Seamlessly integrates with Neovim, providing project-local configurations and enhanced development workflows.

## Usage

To use this Zsh configuration, ensure your `ZDOTDIR` environment variable points to this directory (e.g., `export ZDOTDIR="$HOME/.config/zsh"` in your `.zshenv` or similar).

After setting up, open a new terminal session. The configuration will be loaded automatically.

### Testing the Zsh Configuration

After making any changes or for initial verification, follow these steps:

1.  **Reload Zsh:** Run `exec zsh` in your terminal. This will reload the entire configuration. Observe for any error messages.

2.  **Verify Basic Commands:**
    -   `ls`, `cd`, `cat`, `grep`, `find`, `top`, `ps`: Ensure these commands work as expected with their aliased/configured behavior.

3.  **Check Aliases:**
    -   Test common aliases like `la`, `ll`, `g`, `lg`, `vi`, `d`, `dc`, `h`, `c`, `q`, `reload`, `zshrc`.

4.  **Inspect History:**
    -   Run `history` to see if it's working.
    -   Test history search using the Up/Down arrow keys and `Ctrl+R` (fzf history search).

5.  **Test Keybindings:**
    -   `Ctrl+T`: Should open `fzf` for file selection.
    -   `Ctrl+R`: Should open `fzf` for history search.
    -   `Ctrl+O`: Should open the `kora-project` selector.
    -   Test basic navigation keybindings (`Home`, `End`, `Ctrl+Left`, `Ctrl+Right`).

6.  **Examine Prompt:**
    -   Ensure your shell prompt loads correctly and displays the expected information (e.g., user, host, current directory, git status).

## Contributing

Contributions are welcome! If you have suggestions for improvements or find issues, please feel free to open an issue or submit a pull request.
