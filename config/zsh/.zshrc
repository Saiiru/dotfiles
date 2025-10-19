# Main Zsh configuration file

# Load Zsh options
for config_file in "$ZDOTDIR"/conf.d/10-options.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Zsh completion settings
for config_file in "$ZDOTDIR"/conf.d/20-completion.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Zsh plugins post-completion
for config_file in "$ZDOTDIR"/conf.d/21-plugins-postcomp.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Zsh keybinds
for config_file in "$ZDOTDIR"/conf.d/25-keybinds.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Oh My Posh configuration
for config_file in "$ZDOTDIR"/conf.d/30-oh-my-posh.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load mise and uv configuration
for config_file in "$ZDOTDIR"/conf.d/35-mise+uv.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Node.js configuration
for config_file in "$ZDOTDIR"/conf.d/36-node.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Java configuration
for config_file in "$ZDOTDIR"/conf.d/37-java.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Docker and Kubernetes configuration
for config_file in "$ZDOTDIR"/conf.d/38-docker-k8s.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Zsh aliases
for config_file in "$ZDOTDIR"/conf.d/40-aliases.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# Load Zsh functions
for func_file in "$ZDOTDIR"/functions/*.zsh; do
  [ -f "$func_file" ] && source "$func_file"
done

# Load Zsh plugins
for plugin_file in "$ZDOTDIR"/plugin.zsh; do
  [ -f "$plugin_file" ] && source "$plugin_file"
done
