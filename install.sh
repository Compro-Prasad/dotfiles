#!/bin/sh

run_dir=$(pwd)

if test -e $HOME/.Xdefaults; then
    cd $HOME
    new_name=$(mktemp .Xdefaults.XXXX)
    mv $HOME/.Xdefaults $new_name
    echo $HOME/.Xdefaults was moved to $HOME/$new_name
    cd $run_dir
fi
ln -s $(pwd)/.Xdefaults $HOME
