#!/usr/bin/env bash

DOTFILES_ROOT=$(pwd -P)

if ! test -f git/.gitconfig.local.symlink; then
    echo 'What is your git user name?'
    read -e git_author

    echo 'What is your git email?'
    read -e git_email

    sed -e "s/AUTHOR/$git_author/g" -e "s/EMAIL/$git_email/g" git/.gitconfig.symlink > git/.gitconfig.local.symlink
fi

ln $DOTFILES_ROOT/git/.gitconfig.local.symlink ~/.gitconfig

ln $DOTFILES_ROOT/psql/.psqlrc.symlink ~/.psqlrc

ln $DOTFILES_ROOT/vim/.vimrc.symlink ~/.vimrc


ln $DOTFILES_ROOT/zsh/.zshrc.symlink ~/.zshrc
