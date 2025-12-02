autoload -Uz compinit
compinit
# Enable Git auto-completion for the dotfiles alias
zstyle ':completion:*:*:dotfiles:*' command-path '/usr/local/bin/git'
autoload -Uz _git
compdef _git dotfiles
#source <(kubectl completion zsh)
#complete -o default -F __start_kubectl k
#eval $(minikube -p minikube docker-env)

