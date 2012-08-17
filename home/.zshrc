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
export EDITOR="vim"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"
#

# AUTO_TITLE mucks up tmux window naming
export DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(github git rails)

# disable the annoying oh-my-zsh update prompt. this will auto update now.
export DISABLE_UPDATE_PROMPT="true"

source $ZSH/oh-my-zsh.sh
source ~/.git-flow-completion.zsh

# kill stupid autocorrect
unsetopt correct_all

# Customize to your needs...
export ANDROID_HOME=`brew --prefix android`
export PATH="$PATH:$HOME/bin:$HOME/.bin:$ANDROID_HOME/tools"
alias ssh-gu-staging="TERM=xterm ssh -t staging 'screen -U -R richard'"
alias ssh-gu-smoke="TERM=xterm ssh -t smoke 'screen -U -R richard'"
alias ssh-gu-ct="TERM=xterm ssh -t ct 'screen -U -R richard'"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias be="bundle exec"
alias ga="git add"
alias gch="git checkout"
export REPORTTIME=5

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -s "$HOME/nvm/nvm.sh" ]] && . "$HOME/nvm/nvm.sh"

if [[ -x dircolors ]] then
  eval `dircolors ~/.dircolors`
fi

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Vi style:
zle -N edit-command-line
bindkey -v
bindkey -M vicmd v edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

if [[ -r ~/.aliasrc ]]; then
  source ~/.aliasrc
fi
