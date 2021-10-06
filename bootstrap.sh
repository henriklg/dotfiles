#!/usr/bin/env bash

# pull in the latest version and copy the files to your home folder.
cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

MYSHELL=$(readlink /proc/$$/exe | sed -e 's/\/.*\///g')
echo "Currently on ${MYSHELL} shell."

function doIt() {
	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	source ~/.${MYSHELL}_profile;
	
	# add source bash_profile in bashrc
	addprofile="if [ -f ~/.${MYSHELL}_profile ]; then . ~/.${MYSHELL}_profile; fi"
	
	# checks all lines
	if ! grep -Fxq "$addprofile" ~/.${MYSHELL}rc; then
		echo "\n$addprofile" >> ~/.${MYSHELL}rc
	fi
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
	doIt;
else
	echo -n "This may overwrite existing files in your home directory. Are you sure? (y/n)? " # works in zsh and bash
	read REPLY 
	#read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1; # only works in bash
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
