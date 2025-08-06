#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════════════
# 🐍 PYTHON NEURAL CORE
# ═══════════════════════════════════════════════════════════════════════════

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/workspace"
export WORKSPACE_HOME="$HOME/workspace"
export VENV_HOME="$HOME/.venvs"
export UV_PYTHON_PREFERENCE="only-managed"
export UV_VENV_IN_PROJECT=1

# Initialize pyenv if available
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Create directories if they don't exist
mkdir -p "$WORKSPACE_HOME" "$VENV_HOME" 2>/dev/null

# ═══════════════════════════════════════════════════════════════════════════
# 🔄 AUTO PROJECT DETECTION & ACTIVATION
# ═══════════════════════════════════════════════════════════════════════════

auto_activate_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Already in a virtual environment
    return
  fi

  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      # No need to print message as the prompt will show it
      return
    elif [[ -f "$dir/venv/bin/activate" ]]; then
      source "$dir/venv/bin/activate"
      return
    fi
    dir="$(dirname "$dir")"
  done
}

# Register the hook for directory changes
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv

# ═══════════════════════════════════════════════════════════════════════════
# 🚀 PROJECT CREATION SYSTEM
# ═══════════════════════════════════════════════════════════════════════════

create_project() {
  local project_name="$1"
  local project_type="${2:-general}"
  local python_version="${3:-3.12}"

  if [[ -z "$project_name" ]]; then
    echo "❌ Usage: create_project <name> [type] [python_version]"
    echo "📋 Types: web, ai, data, api, cli, experiment, lib"
    return 1
  fi

  local prefix=""
  local timestamp=$(date +%y%m)

  case "$project_type" in
    "web" | "webapp") prefix="web" ;;
    "ai" | "ml" | "neural") prefix="ai" ;;
    "data" | "analytics") prefix="data" ;;
    "api" | "backend") prefix="api" ;;
    "cli" | "tool") prefix="cli" ;;
    "experiment" | "lab") prefix="exp" ;;
    "lib" | "library") prefix="lib" ;;
    *) prefix="proj" ;;
  esac

  local full_name="${prefix}-${project_name}-${timestamp}"
  local project_path="$WORKSPACE_HOME/$full_name"

  echo "🧠 Initializing neural project: $full_name"
  echo "🐍 Python version: $python_version"
  echo "🎯 Project type: $project_type"

  mkdir -p "$project_path"
  cd "$project_path"

  echo "🔄 Creating quantum environment..."

  # Try to use UV first, fall back to venv/virtualenv
  if command -v uv &>/dev/null; then
    uv venv -p "python$python_version" .venv
  elif command -v virtualenv &>/dev/null; then
    virtualenv -p "python$python_version" .venv
  else
    python -m venv .venv
  fi

  if [[ ! -f ".venv/bin/activate" ]]; then
    echo "❌ Failed to create virtual environment"
    return 1
  fi

  # Activate the virtual environment
  source .venv/bin/activate

  # Create project structure and pyproject.toml based on type
  case "$project_type" in
    "web" | "webapp")
      mkdir -p {src,static/{css,js,img},templates,tests,config}
      cat >pyproject.toml <<EOF
[project]
name = "$full_name"
version = "0.1.0"
dependencies = [
    "fastapi",
    "uvicorn", 
    "jinja2", 
    "python-multipart", 
    "python-dotenv"
]

[project.optional-dependencies]
dev = [
    "pytest", 
    "black", 
    "ruff", 
    "mypy"
]
EOF
      ;;
    "ai" | "ml" | "neural")
      mkdir -p {src,data/{raw,processed,models},notebooks,experiments,configs,scripts}
      cat >pyproject.toml <<EOF
[project]
name = "$full_name"
version = "0.1.0"
dependencies = [
    "torch", 
    "transformers", 
    "numpy", 
    "pandas", 
    "matplotlib", 
    "jupyter", 
    "ipykernel"
]

[project.optional-dependencies]
dev = [
    "pytest", 
    "black", 
    "ruff", 
    "mypy"
]
EOF
      ;;
    "cli" | "tool")
      mkdir -p {src,tests,docs}
      cat >pyproject.toml <<EOF
[project]
name = "$full_name"
version = "0.1.0"
dependencies = [
    "typer", 
    "rich", 
    "click", 
    "requests", 
    "python-dotenv"
]

[project.optional-dependencies]
dev = [
    "pytest", 
    "black", 
    "ruff", 
    "mypy"
]

[project.scripts]
cli-tool = "src.main:app"
EOF
      ;;
    *)
      mkdir -p {src,tests,docs}
      cat >pyproject.toml <<EOF
[project]
name = "$full_name"
version = "0.1.0"
dependencies = [
    "requests", 
    "python-dotenv"
]

[project.optional-dependencies]
dev = [
    "pytest", 
    "black", 
    "ruff", 
    "mypy"
]
EOF
      ;;
  esac

  # Create basic files
  cat >README.md <<EOF
# $full_name

Project created: $(date)
Type: $project_type
Python: $python_version

## Quick Start
\`\`\`bash
source .venv/bin/activate
uv pip install -e .
uv pip install -e ".[dev]"
\`\`\`
EOF

  cat >.gitignore <<'EOF'
__pycache__/
*.py[cod]
.venv/
.env
.DS_Store
*.log
.pytest_cache/
.mypy_cache/
EOF

  # Install dependencies
  echo "📦 Installing quantum dependencies..."
  if command -v uv &>/dev/null; then
    uv pip install -e . 2>/dev/null || uv pip install requests python-dotenv
    uv pip install -e ".[dev]" 2>/dev/null || uv pip install pytest black ruff mypy

    # Always install ipykernel for AI/data projects
    if [[ "$project_type" == "ai" || "$project_type" == "data" ]]; then
      uv pip install ipykernel
    fi
  else
    pip install -e . 2>/dev/null || pip install requests python-dotenv
    pip install -e ".[dev]" 2>/dev/null || pip install pytest black ruff mypy

    # Always install ipykernel for AI/data projects
    if [[ "$project_type" == "ai" || "$project_type" == "data" ]]; then
      pip install ipykernel
    fi
  fi

  if [[ "$project_type" == "ai" || "$project_type" == "data" ]]; then
    # Make sure ipykernel is installed before registering the kernel
    if python -c "import ipykernel" 2>/dev/null; then
      python -m ipykernel install --user --name="$full_name" --display-name="$full_name"
      echo "🧠 Jupyter kernel registered: $full_name"
    else
      echo "⚠️ ipykernel package not available - Jupyter kernel not registered"
    fi
  fi

  # Ensure the user knows the venv is active
  echo "✅ Neural project matrix complete!"
  echo "📍 Location: $project_path"
  echo "🚀 Virtual environment activated: $(basename $VIRTUAL_ENV)"
  echo "🧠 Ready for quantum development"
}

# ═══════════════════════════════════════════════════════════════════════════
# 🎯 PROJECT MANAGEMENT FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

list_projects() {
  echo "🧠 NEURAL PROJECT MATRIX"
  echo "═══════════════════════════════════════"

  if [[ -d "$WORKSPACE_HOME" ]]; then
    for project in "$WORKSPACE_HOME"/*/; do
      if [[ -d "$project" ]]; then
        local name=$(basename "$project")
        local type_icon=""
        case "$name" in
          web-*) type_icon="🌐" ;;
          ai-*) type_icon="🤖" ;;
          data-*) type_icon="📊" ;;
          api-*) type_icon="⚡" ;;
          cli-*) type_icon="🔧" ;;
          exp-*) type_icon="🧪" ;;
          lib-*) type_icon="📚" ;;
          *) type_icon="📁" ;;
        esac

        local status="🔴 No venv"
        [[ -d "$project/.venv" ]] && status="🟢 Ready"

        printf "%-3s %-30s %s\n" "$type_icon" "$name" "$status"
      fi
    done
  fi
}

goto_project() {
  if command -v fzf &>/dev/null && [[ -d "$WORKSPACE_HOME" ]]; then
    local project=$(ls -1 "$WORKSPACE_HOME" | fzf \
      --prompt="🧠 Select neural project: " \
      --height=40% --border)

    if [[ -n "$project" ]]; then
      cd "$WORKSPACE_HOME/$project"
      auto_activate_venv
    fi
  fi
}

# Python aliases
alias py='python'
alias ipy='ipython'
alias jlab='jupyter lab --no-browser'
alias new='create_project'
alias projects='list_projects'
alias goto='goto_project'
alias venv='python -m venv .venv && source .venv/bin/activate'
