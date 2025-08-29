# KORA Project Archetype: Web
# Creates a basic web project structure (HTML, CSS, JS).

_mkproj_web() {
    local name=$1
    _kora_log "Criando projeto web básico..."
    mkdir -p public css js
    echo "<!DOCTYPE html>
<html>
<head>
    <title>$name</title>
    <link rel=\"stylesheet\" href=\"css/style.css">
    <script src=\"js/main.js"></script>
</head>
<body>
    <h1>Hello, $name!</h1>
</body>
</html>" > public/index.html
    echo "/* style.css */" > public/css/style.css
    echo "// main.js" > public/js/main.js
}
