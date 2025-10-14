emulate -L zsh

# JAVA_HOME (pacote Arch) — mise pode sobrescrever via shims
[[ -d /usr/lib/jvm/java-21-openjdk ]] && export JAVA_HOME=/usr/lib/jvm/java-21-openjdk

# Maven/Gradle completions (bash → zsh via bashcompinit já ativo)
[[ -r /usr/share/bash-completion/completions/mvn    ]] && source /usr/share/bash-completion/completions/mvn
[[ -r /usr/share/bash-completion/completions/gradle ]] && source /usr/share/bash-completion/completions/gradle

# Aliases
alias mvn='mvn -T1C -q'
alias grad='gradle --console=plain'