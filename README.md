# Henrik’s dotfiles

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Documents/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone git@github.com:henriklg/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
source bootstrap.sh -f
```
To update later on, just run that command again.

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/henriklg/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```



### TODO
- ~~Look through complete .bashrc file for bash_profile, instead of only last line~~
- ~~Make bootstrap.sh compatible with zsh and separate zsh_profile~~
- Add dotfiles for powershell/wsl2 in posh branch
- Separate out duplicate code/aliases from zsh/bash profiles scripts
- Include functionality for full setup of [zsh, oh-my-zsh, powerline10k, path-variables (especially poetry and pyenv), addons and theme]
