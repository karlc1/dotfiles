# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/karlc/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# to know which specific one was loaded, run: echo $RANDOM_THEME
ZSH_THEME=""
# ZSH_THEME="amuse"
# ZSH_theme="random"

# Setting this variable when ZSH_THEME=random will cause zsh to load
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# USER=''

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# disable auto correct
unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true" 


# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

alias weather="curl -x http://wwwproxy.se.axis.com:3128 wttr.in/malmo"
alias moon="curl -x http://wwwproxy.se.axis.com:3128 wttr.in/moon"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias devicerepo="cd ~/code/gitlab.se.axis.com/axis-connect/device-service/devices"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias dc="docker-compose"
alias lss="ls | lolcat"
alias useproxy="/usr/local/pulse/PulseClient_x86_64.sh -h connect2.axis.com -r connect2 -U https://connect2.axis.com -u karlc"
alias :q="exit"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no


# ENV
export http_proxy=http://wwwproxy.se.axis.com:3128
export https_proxy=http://wwwproxy.se.axis.com:3128
export HTTP_PROXY=http://wwwproxy.se.axis.com:3128
export HTTPS_PROXY=http://wwwproxy.se.axis.com:3128
export NO_PROXY="localhost,127.0.0.1"
export GOBIN=~/code/go/bin
export GOPATH=~/code/go
# Latest go
export PATH=/usr/local/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/code/go/bin:$PATH


# For comm agent service
export NODE_CONFIG_DIR=./../config/

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#COMMANDS=("moon" "linuxlogo -logo -a | lolcat"

#moon
fpath=( "$HOME/.zfunctions" $fpath )

# zstyle :prompt:pure:path color yellow
zstyle ':prompt:pure:prompt:*' color cyan

autoload -U promptinit; promptinit

prompt pure

export NVM_DIR="/home/karlc/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
