# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# export ZSH_THEME="robbyrussell"
#export ZSH_THEME="candy"
export ZSH_THEME="jreese"

export VISUAL="vim"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(github git rails ruby)

source $ZSH/oh-my-zsh.sh
source ~/.git-flow-completion.zsh

# kill stupid autocorrect
unsetopt correct_all

# Customize to your needs...
export PATH="$PATH:$HOME/bin"
alias ssh-gu-staging="TERM=xterm ssh -t staging.gaggleup.com 'screen -U -R richard'"
alias ssh-gu-smoke="TERM=xterm ssh -t smoke.gaggleup.com 'screen -U -R richard'"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias be="bundle exec"

eval `dircolors ~/.dircolors`

