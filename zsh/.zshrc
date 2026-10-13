# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled
zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
plugins=(git aws)

source $ZSH/oh-my-zsh.sh

# Load zsh config modules
[[ -f ~/.zsh/exports.zsh   ]] && source ~/.zsh/exports.zsh
[[ -f ~/.zsh/aliases.zsh   ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/host-local.zsh ]] && source ~/.zsh/host-local.zsh
