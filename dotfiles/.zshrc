# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

#extract archives
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

# Setup a local environment for Laravel development
# for git cloned repos.
# Use --database switch to migrate and seed the database.
laravel-setup ()
{
  if [ -e './artisan' ]; then
    composer install
    npm install
    cp .env.example .env
    php artisan key:generate
    if [ "$1" = "--database" ]; then
      php artisan migrate
      php artisan db:seed
    fi
  else
    echo "Artisan script was not found in this directory"
  fi
}

# Aliases
alias gstat="git status"
alias gadd="git add"
alias gcomm="git commit"
alias gpull="git pull"
alias gundo="git reset --soft HEAD~1"
alias www="cd /var/www"
alias home="cd ~"
alias duh="du -h"
alias chromekys="pkill chrome"
alias fixaudio="pulseaudio -k"
alias sqlogin="sudo mysql -uroot"
alias cfg="nano ~/.zshrc"
alias serve="php artisan serve"
alias emulator="flutter emulators --launch Pixel_3a_API_30_x86"
alias updates="sudo apt update && sudo apt list --upgradable"
alias sshagent="eval '$(ssh-agent -s)'"
alias c="code ."

# Apache2 aliases
alias a2start="sudo service apache2 start"
alias a2restart="sudo service apache2 restart"
alias a2status="sudo service apache2 restart"
alias a2stop="sudo service apache2 stop"

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Disable .NET Telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
