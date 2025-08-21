# _node.zsh — Handles the creation of a basic Node.js project.

# _mkproj_node: Sets up a Node.js project with npm and an optional Dockerfile.
_mkproj_node() {
    _kora_log "Creating basic Node.js project..."
    mkdir -p src tests
    echo "// index.js" > src/index.js
    echo "// test.js" > tests/test.js
    npm init -y > /dev/null 2>&1
    _kora_spin "Installing Node.js dependencies..."
    npm install > /dev/null 2>&1
    local add_dockerfile=$(gum confirm "Do you want to add a basic Dockerfile?" --affirmative "Yes" --negative "No" --selected.foreground "$KORA_GREEN" --unselected.foreground "$KORA_RED")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adding Dockerfile..."
        cat > Dockerfile <<'EOF'
# Use an official Node.js runtime as a parent image
FROM node:16-alpine
# Set the working directory in the container
WORKDIR /app
# Copy package.json and package-lock.json
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the application code
COPY . .
# Expose the port the app runs on
EXPOSE 3000
# Define the command to run the app
CMD ["npm", "start"]
EOF
        _kora_log "Dockerfile added."
    fi
}
