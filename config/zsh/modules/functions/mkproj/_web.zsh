# _web.zsh — Handles the creation of a basic web project.

# _mkproj_web: Sets up a basic web project with HTML, CSS, and JavaScript files.
_mkproj_web() {
    _kora_log "Creating basic web project..."
    mkdir -p public css js
    echo "<!DOCTYPE html>\n<html>\n<head>\n    <title>$1</title>\n    <link rel=\"stylesheet\" href=\"css/style.css\">
    <script src=\"js/main.js\"></script>\n</head>\n<body>\n    <h1>Hello, $1!</h1>\n</body>\n</html>" > public/index.html
    echo "/* style.css */" > public/css/style.css
    echo "// main.js" > public/js/main.js
}