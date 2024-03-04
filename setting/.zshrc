autoload -U +X compinit && compinit
alias ll="ls -la"

 if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi
alias kubectl="kubecolor"
export CLICOLOR=1
alias ls="ls -G"
alias ll="ls -laG"
alias lll="ls -laG"
alias cls="clear"
alias car="cat"

viknow () {
 vi +$1 ~/.ssh/known_hosts 
}



PROMPT="%F{8}%n%f%B%F{63}@%f%b%F{48}%m%F{36}%~%f %B%F{63}~%f%b %%"
export KUBECONFIG=/Users/evgenystyrov/.kube/kubeconfig.yml
alias k=kubectl
compdef __start_kubectl k
autoload -Uz compinit
compinit
# get zsh complete kubectl
source <(kubectl completion zsh)
alias kubectl=kubecolor
# make completion work with kubecolor
compdef kubecolor=kubectl
#source /usr/local/share/zsh/site-functions/_ansible

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
