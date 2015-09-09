# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby rvm)
source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8

export EDITOR="vim"
#ssh-agent
alias git='(ssh-add -l > /dev/null) || ssh-add -t 1800 && git'
alias ssh='(ssh-add -l > /dev/null) || ssh-add -t 1800 && ssh'
alias rubostage='git diff --name-only --cached | grep '\.rb' | xargs rubocop -a'
# RVM stuff
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#
# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
