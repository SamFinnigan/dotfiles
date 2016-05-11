# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Git PS1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1


# 'Random' coloured PS1 hostname, courtesy of Seb
str256() { echo $((0x$(echo $1|md5sum|cut -c-4)%256)); }
str2color() { echo -e "\033[38;5;$(str256 "$1")m$1\033[00m"; }

HOSTNAME_COLOUR_FILENAME="$HOME/.$(hostname)-colour"
test -f "$HOSTNAME_COLOUR_FILENAME" ||
    echo $((0x$(hostname|md5sum|cut -c-4)%256)) > "$HOSTNAME_COLOUR_FILENAME"

USERNAME_COLOUR_FILENAME="$HOME/.$(whoami)-colour"
test -f "$USERNAME_COLOUR_FILENAME" ||
    echo $((0x$(whoami|md5sum|cut -c-4)%256)) > "$USERNAME_COLOUR_FILENAME"

HOSTNAME_COLOUR=$(cat "$HOSTNAME_COLOUR_FILENAME")
USERNAME_COLOUR=$(cat "$USERNAME_COLOUR_FILENAME")


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1=$'\[\e[30;1m\]$(__git_ps1 "[%s] ")\[\e[0m\]\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[$(tput bold)\]\[\033[38;5;${USERNAME_COLOUR}m\]\u\[\033[00m\]@\[$(tput bold)\]\[\033[38;5;${HOSTNAME_COLOUR}m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Old
	#PS1='\[\e[0;35;109m\]\h\[\e[m\]:\w\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0m\]'
    export PS1
;;
screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    PS1='\[\e[0;35;109m\]\h\[\e[m\]:\w\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0m\]'
;;
*)
;;
esac


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
. /etc/bash_completion
fi

## Enable motd
#[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd

export EDITOR=vi
export VISUAL=vi
export SVN_EDITOR=vi
export PYTHONSTARTUP=~/.pythonrc

# Language
export LC_ALL=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_MESSAGES=en_GB.UTF-8

