##################
# WELCOME SCREEN #
##################


export USER="Henrik Gjestang"
#echo -ne "Hello. Today is, "; date


###############
# BASH PROMPT #
###############

# Minimalistisc shell with only last directory, not full path
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]> '

# Shell prompt based on solarized dark theme and git integration
source ~/.bash_prompt;


###########
# ALIAS #
###########

# Dir & ls
alias ..="cd .."
alias ...="cd ../.."
alias pd="pwd"
alias hy="history"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias home='cd'
alias doc='cd ~/Documents'
alias down='cd ~/Downloads'
alias mus='cd ~/Music'
alias pix='cd ~/Pictures'
alias root='sudo -i'
alias copy='xclip -selection clipboard'

# Sudo
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias liq='sudo liquidctl'
# Run last command with sudo
alias fuck='sudo $(fc -ln -1)'

# Misc
alias x='exit'
alias del='rm --target-directory=$HOME/.Trash/'

# Applications
alias py="python3"
alias juno="jupyter notebook"
alias jula="jupyter lab"
# git
alias gst="git status -sb"
alias gdi="git diff"
alias gpu="git push"
alias gfe="git fetch"
alias gpl="git pull"
alias gch="git checkout"
alias gco="git commit -m"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias glo="git log"
alias gtr="git log --graph --oneline --decorate"


##########
# SCIPTS #
##########

# Source my scripts
for f in ~/.my_scripts/*.sh; do source $f; done


########
# MISC #
########
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
# Remove error bell sound
bind 'set bell-style none'


