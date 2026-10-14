# Henrik's dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/), which creates symlinks from `~` into this repo. macOS only.

## Repository structure

```text
dotfiles/
├── zsh/
│   ├── .zshrc                  # Main shell config (Oh My Zsh + sources below)
│   └── .zsh/
│       ├── aliases.zsh         # Shell aliases
│       ├── exports.zsh         # Environment variables
│       ├── functions.zsh       # Shell functions (climb, extract, …)
│       └── host-local.zsh.example  # Template — copy and fill in per machine
│
├── git/
│   └── .gitconfig              # Git identity and aliases
│
├── aws/
│   └── .aws/
│       └── config              # AWS SSO profiles (no credentials)
│
├── claude/
│   └── .claude/
│       ├── settings.json       # Claude Code (CLI) settings
│       └── statusline.sh       # Status line script (model + progress)
│
├── bootstrap.sh                # One-shot Mac setup script
├── .gitignore
└── README.md
```

## Bootstrapping a new Mac

```bash
git clone git@github.com:henriklg/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./bootstrap.sh
```

The script installs Homebrew, stow, git, awscli, eza, uv, and Oh My Zsh, then runs `stow` for all packages. Any existing plain dotfiles that would conflict are automatically backed up with a `.bak` suffix before linking.

## One-time migration on an existing machine

Just run `bootstrap.sh` — it backs up any conflicting dotfiles automatically and then links everything.

## Where to place secrets

**Never commit secrets.** Machine-specific settings go in `~/.zsh/host-local.zsh` — copy the example file and fill it in:

```bash
cp ~/dev/dotfiles/zsh/.zsh/host-local.zsh.example ~/.zsh/host-local.zsh
# then edit ~/.zsh/host-local.zsh
```

`host-local.zsh` is in `.gitignore` and will not be committed.

AWS credentials (`~/.aws/credentials`) are managed by SSO and are also ignored by git.
