# kora-docker-helpers.zsh — Centralized functions for Dockerfile generation in KORA projects.

# _kora_generate_dockerfile: Generates Dockerfile content based on project type.
# Arguments:
#   $1: project_type (e.g., "go", "node", "python", "rust")
#   $2: project_name (used for Rust Dockerfile to specify executable name)
_kora_generate_dockerfile() {
    local project_type="$1"
    local project_name="$2" # Used for Rust Dockerfile

    case "$project_type" in
        go)
            cat <<'EOF'
FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY go.mod ./ 
COPY go.sum ./ 
RUN go mod download
COPY . . 
RUN go build -o /go-app ./cmd/main.go
FROM alpine:latest
WORKDIR /root/ 
COPY --from=builder /go-app .
EXPOSE 8080
CMD ["./go-app"]
EOF
            ;;;
        node)
            cat <<'EOF'
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 3000
CMD ["npm", "start"]
EOF
            ;;;
        python)
            cat <<'EOF'
FROM python:3.12-slim-buster
WORKDIR /app
COPY . /app
# If you're using poetry, you might want to install poetry and then your dependencies
# RUN pip install poetry && poetry install --no-dev --no-root
EXPOSE 80
ENV NAME World
CMD ["python", "src/main.py"]
EOF
            ;;;
        rust)
            cat <<EOF
FROM rust:latest AS builder
WORKDIR /app
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {println!(\"Hello, world!\");}" > src/main.rs && cargo build --release
RUN rm -rf src target/release/.fingerprint target/release/.cargo-lock
COPY . . 
RUN cargo build --release
FROM debian:buster-slim
COPY --from=builder /app/target/release/$project_name /usr/local/bin/$project_name
CMD ["/usr/local/bin/$project_name"]
EOF
            ;;;
        *)
            echo "Error: Unsupported project type for Dockerfile generation: $project_type" >&2
            return 1
            ;;;
    esac
}