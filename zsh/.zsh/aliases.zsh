# Navigation
alias pd="pwd"
alias hy="history"
alias home='cd'
alias doc='cd ~/Documents'
alias down='cd ~/Downloads'
alias pix='cd ~/Pictures'
alias dev='cd ~/dev'
# up N levels in the directory tree (e.g., uu = cd ../.., uuu = cd ../../..)
for i in {1..5}; do
  alias $(printf 'u%.0s' $(seq 1 $i))="cd $(printf '../%.0s' $(seq 1 $i))"
done

# eza
alias ls='eza'
alias ll='eza --all --header --long --git --icons'
alias la='eza -lbhHigUmuSa'
alias lt='eza --tree'
alias tree='eza --tree'

# Misc
alias x='exit'
alias py="python3"
alias reload="source ~/.zshrc"

# git
alias gst="git status -sb"
alias gdi="git diff"
# alias gpu="git push"
# alias gfe="git fetch"
# alias gpl="git pull"
# alias gch="git checkout"
# alias gco="git commit -m"
# alias gad="git add"
# alias grm="git rm"
# alias gmv="git mv"
# alias glo="git log"
# alias gtr="git log --graph --oneline --decorate"
