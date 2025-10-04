export GEM_HOME=$HOME/.gem

export PATH=$HOME/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/flutter/bin:$GEM_HOME/bin:$HOME/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME=""

plugins=(git zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.7z)        7z x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias grs="git reset --soft HEAD~1"

alias home="cd ~"
alias duh="du -h"

alias cfg="vi ~/.zshrc"
alias sshcfg="vi ~/.ssh/config"

alias serve="php artisan serve"
alias sshagent="eval '$(ssh-agent -s)'"
alias c="code ."
alias ap="ansible-playbook"
alias x="exit"
alias prd="pnpm run dev"
alias prb="pnpm run build"
alias nrd="npm run dev"
alias nrb="npm run build"
alias cdssh="cd ~/.ssh"
alias cl="clear"
alias pn="pnpm"
alias whatsmyip="curl ifconfig.me"
alias python="python3"

alias dev="cd ~/dev"
alias h='helm'
alias tf='terraform'
alias e="open ."
alias ccusage="bunx ccusage"

alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Disable .NET Telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

kns() {
    local ns="$1"
    if [[ -z "$ns" ]]; then
        kubectl config set-context --current --namespace=default
    else
        kubectl config set-context --current --namespace="$ns"
    fi
}

# Kubernetes context management
kctx() {
    local action="$1"
    local context="$2"

    case "$action" in
        "get")
            kubectl config get-contexts
            ;;
        "set")
            kubectl config use-context "$context"
            ;;
        *)
            echo "Unrecognized action" >&2
            echo "Usage: kctx {get|set} [context]"
            ;;
    esac
}

# Kubernetes shortcuts
alias k='kubectl'
alias ka='kubectl apply -f'
alias kd='kubectl delete -f'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kgns='kubectl get ns'
alias kgd='kubectl get deploy'
alias kgpv='kubectl get pv'
alias kgpvc='kubectl get pvc'

kexec() {
    local pod="$1"
    if [[ -z "$pod" ]]; then
        echo "Provide a pod name" >&2
        return 1
    fi
    kubectl exec -it "$pod" sh
}

kgsv() {
    local secret_name="$1"
    if [[ -z "$secret_name" ]]; then
        echo "Provide a secret name." >&2
        return 1
    fi

    kubectl get secret "$secret_name" -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
}

init_claude_mcp() {
	claude mcp add postman npx @postman/postman-mcp-server@latest
	claude mcp add kubernetes -- "npx -y kubernetes-mcp-server@latest"
	claude mcp add playwright npx @playwright/mcp@latest
}

# fnm
FNM_PATH="~/.local/share/fnm"
export PATH="~/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="~/.local/state/fnm_multishells/11015_1757780255189/bin":$PATH
export FNM_MULTISHELL_PATH="~/.local/state/fnm_multishells/11015_1757780255189"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="~/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"

autoload -U compinit && compinit

eval "$(starship init zsh)"

export GPG_TTY=$(tty)

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
