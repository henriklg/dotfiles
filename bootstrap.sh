#!/usr/bin/env bash
# Bootstrap a new Mac with these dotfiles.
set -euo pipefail

DOTFILES="$HOME/dev/dotfiles"

echo "==> Checking prerequisites..."

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "==> Installing packages..."
brew install stow git awscli

# Install Oh My Zsh (unattended — won't overwrite an existing install)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Cloning / pulling dotfiles..."
if [ ! -d "$DOTFILES" ]; then
  git clone git@github.com:henriklg/dotfiles.git "$DOTFILES"
else
  git -C "$DOTFILES" pull origin master
fi

echo "==> Linking dotfiles with stow..."
cd "$DOTFILES"

# Remove any plain files that would conflict with stow symlinks.
# (Skip if already a symlink — stow manages it.)
for f in ~/.zshrc ~/.gitconfig; do
  if [ -f "$f" ] && [ ! -L "$f" ]; then
    echo "    Backing up $f -> ${f}.bak"
    mv "$f" "${f}.bak"
  fi
done

# -t ~ is required: without it stow defaults to the parent of the stow
# directory (~/dev), not the home directory.
stow -t ~ zsh git aws claude

echo ""
echo "Done! Open a new terminal or run:"
echo "  source ~/.zshrc"
echo ""
echo "Remember to:"
echo "  1. Copy zsh/.zsh/host-local.zsh.example -> ~/.zsh/host-local.zsh"
echo "     and fill in any machine-specific settings."
echo "  2. Run 'aws sso login --profile <your-profile>' to authenticate."
