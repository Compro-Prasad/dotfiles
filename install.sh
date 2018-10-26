#!/bin/sh

run_dir=$(pwd)
dotfiles=(
    Xdefaults
)

for dotfile in "${dotfiles[@]}"; do
    dotfile=".$dotfile"
    echo Installing $dotfile ...
    src="$run_dir/$dotfile"
    dst="$HOME/$dotfile"
    if test -e $dst; then
        cd $HOME
        new_name=$(mktemp $dotfile.XXXX)
        mv $dst $new_name
        echo $dst was moved to $HOME/$new_name
        cd $run_dir
    fi
    ln -s $src $dst
    printf -- ' %.0s' {1..10}
    printf -- '-%.0s' {1..20}
    echo
done
