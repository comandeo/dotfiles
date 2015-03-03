# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby rvm brew osx)
source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8

alias vi="mvim -v"
alias vim="mvim -v"
export EDITOR="mvim -v"
export JAVA_HOME=$(/usr/libexec/java_home)
export SCALA_HOME=/usr/local/Cellar/scala/2.11.2
export M2_HOME=/usr/local/Cellar/maven/3.2.5/libexec
export M2_REPO=~/.m2
export MAVEN_HOME=$M2_HOME
export GOPATH=$HOME/dev/go
export PATH="$PATH:/Users/dmitry.rybakov/.rvm/gems/ruby-2.1.2/bin:/Users/dmitry.rybakov/.rvm/gems/ruby-2.1.2@global/bin:/Users/dmitry.rybakov/.rvm/rubies/ruby-2.1.2/bin:/sbin:$GOPATH/bin"
#ssh-agent
alias git='(ssh-add -l > /dev/null) || ssh-add -t 1800 && git'
alias ssh='(ssh-add -l > /dev/null) || ssh-add -t 1800 && ssh'
# RVM stuff
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#
# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
