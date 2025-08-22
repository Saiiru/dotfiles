# kora-project-language-indicator.zsh — Detects and displays the active project's language.

# _kora_get_project_language: Detects the project language based on common project files.
# Returns a formatted string (e.g., "🐍 py3.10", "🦀 rs1.60") or an empty string.
_kora_get_project_language() {
  local lang_icon="" lang_version=""

  # --- Python ---
  if [[ -f "pyproject.toml" || -f "requirements.txt" || -f "setup.py" || -d ".venv" ]]; then
    lang_icon="🐍"
    if command -v python &>/dev/null; then
      lang_version=$(python -c "import sys; print(f'py{sys.version_info.major}.{sys.version_info.minor}')" 2>/dev/null)
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- Node.js ---
  if [[ -f "package.json" ]]; then
    lang_icon="⬢"
    if command -v node &>/dev/null; then
      lang_version=$(node -v 2>/dev/null | sed 's/v//')
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- Go ---
  if [[ -f "go.mod" ]]; then
    lang_icon="🐹"
    if command -v go &>/dev/null; then
      lang_version=$(go version 2>/dev/null | awk '{print $3}' | sed 's/go//')
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- Rust ---
  if [[ -f "Cargo.toml" ]]; then
    lang_icon="🦀"
    if command -v rustc &>/dev/null; then
      lang_version=$(rustc --version 2>/dev/null | awk '{print $2}')
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- Java/Spring ---
  if [[ -f "pom.xml" || -f "build.gradle" || -d "src/main/java" ]]; then
    lang_icon="☕"
    if command -v java &>/dev/null; then
      lang_version=$(java -version 2>&1 | head -n 1 | awk -F'"' '{print $2}' | awk -F'.' '{print $1}')
      if [[ -z "$lang_version" ]]; then # For Java 8 and older
        lang_version=$(java -version 2>&1 | head -n 1 | awk '{print $3}' | sed 's/"//g' | awk -F'.' '{print $2}')
      fi
      lang_version="java${lang_version}"
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- Arduino ---
  if find . -maxdepth 2 -name "*.ino" -print -quit | grep -q .; then
    lang_icon="⚡" # High voltage sign for Arduino
    lang_version="Arduino"
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  # --- C/C++ ---
  if [[ -f "Makefile" || -f "CMakeLists.txt" || -f "*.c" || -f "*.cpp" ]]; then
    lang_icon="🅒" # Circled C for C/C++
    if command -v gcc &>/dev/null; then
      lang_version="C/C++"
    fi
    echo "${lang_icon} ${lang_version}"
    return 0
  fi

  echo "" # No specific language detected
}