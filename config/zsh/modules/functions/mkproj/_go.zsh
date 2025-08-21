# _go.zsh — Handles the creation of a basic Go project.

# _mkproj_go: Sets up a Go project with Go Modules and an optional Dockerfile.
_mkproj_go() {
    local name=$1
    _kora_log "Creating basic Go project..."
    mkdir -p cmd pkg internal
    echo "package main

import \"fmt\"

func main() {
    fmt.Println(\"Hello, Go!\")
}
" > cmd/main.go
    go mod init "$1" > /dev/null 2>&1

    _kora_spin "Organizing Go modules..."
    go mod tidy > /dev/null 2>&1 # Organize modules

    local add_dockerfile=$(gum confirm "Do you want to add a basic Dockerfile?" --affirmative "Yes" --negative "No" --selected.foreground "$KORA_GREEN" --unselected.foreground "$KORA_RED")
    if [[ "$add_dockerfile" == "true" ]]; then
        _kora_log "Adding Dockerfile..."
        cat > Dockerfile <<'EOF'
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
        _kora_log "Dockerfile added."
    fi
}
