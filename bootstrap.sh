#!/usr/bin/env bash
# Bootstrap a new Mac with these dotfiles.
set -euo pipefail

DOTFILES="$HOME/dev/dotfiles"
STOW_PKGS=(zsh git aws claude)

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

echo "==> Ensuring user Applications directory exists..."
mkdir -p "$HOME/Applications"

echo "==> Installing packages..."
brew install stow git awscli eza uv
brew install --cask font-hack-nerd-font

# Install Oh My Zsh (unattended — won't overwrite an existing install)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Cloning / pulling dotfiles..."
if [ ! -d "$DOTFILES" ]; then
  git clone git@github.com:henriklg/dotfiles.git "$DOTFILES"
else
  git -C "$DOTFILES" pull origin main
fi

echo "==> Linking dotfiles with stow..."
cd "$DOTFILES"

# .DS_Store files in stow packages cause conflicts; remove them all up front.
find . -name ".DS_Store" -delete

# Remove any plain files that would conflict with stow symlinks.
# (Skip if already a symlink — stow manages it.)
for pkg in "${STOW_PKGS[@]}"; do
  for src in "$pkg"/* "$pkg"/.*; do
    [[ -e "$src" ]] || continue
    name="${src#$pkg/}"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    target="$HOME/$name"
    if [ -f "$target" ] && [ ! -L "$target" ]; then
      echo "    Backing up $target -> ${target}.bak"
      mv "$target" "${target}.bak"
    fi
  done
done

# "-t ~" is required: without it stow defaults to the parent of the stow
# directory (~/dev), not the home directory.
stow -t ~ "${STOW_PKGS[@]}"

echo ""
echo "Done! Open a new terminal or run:"
echo "  source ~/.zshrc"
echo ""
echo "Remember to:"
echo "  1. Copy zsh/.zsh/host-local.zsh.example -> ~/.zsh/host-local.zsh"
echo "     and fill in any machine-specific settings."
echo "  2. Run 'aws sso login --profile <your-profile>' to authenticate."
