#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc bash_aliases nanorc profile screenrc vimrc pythonrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit 1
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving existing dotfiles from ~ to $olddir"

for file in $files; 
do
    if [[ -L ~/.$file ]]; 
    then 
        echo "Skipping ~/.$file as it is a symlink."
    else 
        mv -bv ~/.$file ~/$olddir/$file 2>/dev/null

        echo "Creating symlink to $file in home directory."
        ln -vsfn $dir/$file ~/.$file
    fi
done

# Get __git_ps1 if it isn't in the shell already
if [ "$(type -t __git_ps1)" = "function" ]; then
    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
fi

