#!/usr/bin/env bash

# pull in the latest version and copy the files to your home folder.
cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;

	source ~/.bash_profile;
	
	# add source bash_profile in bashrc
	addprofile="if [ -f ~/.bash_profile ]; then . ~/.bash_profile; fi"
	
	# checks all lines
	if ! grep -Fxq "$addprofile" ~/.bashrc; then
		echo $addprofile >> ~/.bashrc
	fi
	
	# faster, but only checks last line
	#lastline=$( tail -n 1 ~/.bashrc )
	#if [ "$lastline" != "$addprofile" ]; then
	#	echo $addprofile >> ~/.bashrc
	#fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
