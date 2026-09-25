# Henrik's dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow *package* — running `stow <package>` creates symlinks from `~` into the package directory.

## Repository structure

```
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
│       └── commands/           # Custom slash commands
│
├── bootstrap.sh                # One-shot Mac setup script
├── .gitignore
└── README.md
```

## How GNU Stow works

Stow creates symlinks from your home directory into this repo.

```
dotfiles/zsh/.zshrc   →  stow -t ~ zsh  →  ~/.zshrc -> ~/dev/dotfiles/zsh/.zshrc
```

The `-t ~` flag is required. Without it, stow defaults to the *parent* of the
stow directory (`~/dev` when the repo lives at `~/dev/dotfiles`), which is wrong.

Activate all packages at once from inside `~/dev/dotfiles`:

```bash
stow -t ~ zsh git aws claude
```

To remove links (without deleting files from the repo):

```bash
stow -t ~ -D zsh git aws claude
```

## Bootstrapping a new Mac

```bash
git clone git@github.com:henriklg/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./bootstrap.sh
```

The script installs Homebrew, stow, git, awscli, and Oh My Zsh, then runs `stow` for all packages.

## One-time migration on an existing machine

If you already have live dotfiles in `~`, you need to remove them before stow can create symlinks:

```bash
rm ~/.zshrc ~/.gitconfig
rm ~/.aws/config
rm ~/.claude/settings.json

cd ~/dev/dotfiles
stow -t ~ zsh git aws claude
```

## Where to place secrets

**Never commit secrets.** Machine-specific settings go in `~/.zsh/host-local.zsh` — copy the example file and fill it in:

```bash
cp ~/dev/dotfiles/zsh/.zsh/host-local.zsh.example ~/.zsh/host-local.zsh
# then edit ~/.zsh/host-local.zsh
```

`host-local.zsh` is in `.gitignore` and will not be committed.

AWS credentials (`~/.aws/credentials`) are managed by SSO and are also ignored by git.
