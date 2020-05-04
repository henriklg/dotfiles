# Henrik’s dotfiles

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/mathiasbynens/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```
To update later on, just run that command again.

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/henriklg/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

### Perhaps unecessary step
copy .bash profile to home directory and add 

```bash
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi
```
in .bashrc


### TODO
- Add .ssh?
- Append .bash_profile source in .bashrc automatically
