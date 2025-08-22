# _python.zsh — Handles the creation of a Python project with Poetry and Mise integration.

# _mkproj_python: Sets up a Python project with Poetry, including virtual environment and optional Dockerfile.
_mkproj_python() {
    _kora_log "Creating basic Python project..."
    mkdir -p src tests
    touch src/__init__.py
    echo "# main.py" > src/main.py
    echo "# test_main.py" > tests/test_main.py
    echo "[tool.poetry]\nname = \"$1\"\nversion = \"0.1.0\"\ndescription = \"\"\nauthors = [\"Your Name <you@example.com>\"]\nreadme = \"README.md\"\n\n[tool.poetry.dependencies]\npython = \"^3.12\"\n\n[build-system]\nrequires = [\"poetry-core\"]\nbuild-backend = \"poetry.core.masonry.api\"\n" > pyproject.toml

    _kora_spin "Initializing virtual environment with Poetry..."
    # Ensure Poetry creates the virtual environment inside the project folder
    poetry config virtualenvs.in-project true --local > /dev/null 2>&1
    poetry install --no-root > /dev/null 2>&1 # Create virtual environment and install dependencies

    _kora_log "Python project created with Poetry."
    _kora_log "The virtual environment is located in the '.venv' folder."
    _kora_log "It will activate automatically when you 'cd' into this project."
    _kora_log "To manually enter the Poetry shell: 'poetry shell'"
    _kora_log "To run commands within the venv: 'poetry run <command>'"
    _kora_log "To add dependencies: 'poetry add <package>'"
    _kora_log "To remove dependencies: 'poetry remove <package>'"

    # Create mise.toml for automatic virtual environment activation.
    # This mise.toml ensures the .venv is recognized and activated by mise.
    echo "[tools]\npython = \"3.12\" # Specify the Python version you want to use for the venv\n\n[env]\n_.python.venv = { path = \".venv\", create = true }\n" > mise.toml
    _kora_log "mise.toml added for automatic virtual environment activation."

    local add_dockerfile=$(gum confirm "Do you want to add a basic Dockerfile?" --affirmative "Yes" --negative "No" --selected.foreground "$KORA_GREEN" --unselected.foreground "$KORA_RED")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adding Dockerfile..."
        cat > Dockerfile <<'EOF'
# Use an official Python runtime as a parent image
FROM python:3.12-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# If you're using poetry, you might want to install poetry and then your dependencies
# RUN pip install poetry && poetry install --no-dev --no-root

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "src/main.py"]
EOF
        _kora_log "Dockerfile added."
    fi
}