#!/bin/sh

if which emacs 2> /dev/null; then
    if test -e "/tmp/emacs1000/server" || test -e "~/.emacs.d/server"; then
	emacsclient -c "$@"
    else
	emacs --eval="(server-start)" "$@"
    fi
elif which vim 2> /dev/null; then
    vim "$@"
elif which nano 2> /dev/null; then
    nano "$@"
elif which vi 2> /dev/null; then
    vi "$@"
elif which pico 2> /dev/null; then
    pico "$@"
elif which atom 2> /dev/null; then
    atom "$@"
elif which code 2> /dev/null; then
    code "$@"
fi
