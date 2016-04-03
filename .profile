#!/bin/sh

export PATH=$HOME/.fommil/bin:$PATH

export EDITOR=emacs
export HISTCONTROL=ignoredups
export WINEARCH=win32
export WINEDEBUG=fixme-all,warn+cursor

export COWPATH=$HOME/.cows:/usr/share/cowsay/cows

# place local system fixes in here
if [ -f $HOME/.profile.local ] ; then
    . $HOME/.profile.local
fi

if [ ! -f ~/.inputrc ] && [ -f /etc/inputrc ] ; then
    export INPUTRC=/etc/inputrc
fi

if [ "$PS1" ] && [ "$BASH" ]; then
    if [ -f $HOME/.bashrc ] ; then
        . $HOME/.bashrc
    elif [ -f /etc/bashrc ] ; then
        . /etc/bashrc
    fi
fi

export PATH=$HOME/.jenv/bin:$PATH
eval "$(jenv init -)"
