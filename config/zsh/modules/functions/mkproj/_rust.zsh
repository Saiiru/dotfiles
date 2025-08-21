# _rust.zsh — Handles the creation of a basic Rust project.

# _mkproj_rust: Sets up a Rust project with Cargo and an optional Dockerfile.
_mkproj_rust() {
    _kora_log "Creating basic Rust project..."
    cargo new "$1" --bin
    _kora_spin "Compiling Rust project..."
    cargo build > /dev/null 2>&1
    local add_dockerfile=$(gum confirm "Do you want to add a basic Dockerfile?" --affirmative "Yes" --negative "No" --selected.foreground "$KORA_GREEN" --unselected.foreground "$KORA_RED")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adding Dockerfile..."
        cat > Dockerfile <<'EOF'
# Use a Rust base image
FROM rust:latest AS builder
# Set the working directory
WORKDIR /app
# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./
# Build dependencies (this layer will be cached)
RUN mkdir src && echo "fn main() {println!(\"Hello, world!\");}" > src/main.rs && cargo build --release
RUN rm -rf src target/release/.fingerprint target/release/.cargo-lock
# Copy the rest of the application code
COPY . .
# Build the application
RUN cargo build --release
# Use a minimal image to run the application
FROM debian:buster-slim
# Copy the built executable from the builder stage
COPY --from=builder /app/target/release/$1 /usr/local/bin/$1
# Run the executable
CMD ["/usr/local/bin/$1"]
EOF
        _kora_log "Dockerfile added."
    fi
}
