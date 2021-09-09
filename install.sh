#!/usr/bin/env bash

DOTFILES_ROOT=$(pwd -P)

if ! test -f git/.gitconfig.local.symlink; then
    echo 'What is your git user name?'
    read -e git_author

    echo 'What is your git email?'
    read -e git_email

    sed -e "s/AUTHOR/$git_author/g" -e "s/EMAIL/$git_email/g" git/.gitconfig.symlink > git/.gitconfig.local.symlink
fi

sed -e "s=DOTFILES_ROOT=${DOTFILES_ROOT}=g" zsh/.zshrc.symlink > zsh/.zshrc.local.symlink

# git autocompletion
# Sourced from https://github.com/git/git/blob/v2.33.0/contrib/completion/git-completion.zsh. Credit to authors.
curl https://raw.githubusercontent.com/git/git/v2.33.0/contrib/completion/git-completion.bash -o $DOTFILES_ROOT/zsh/_git-completion-bash
curl https://raw.githubusercontent.com/git/git/v2.33.0/contrib/completion/git-completion.zsh -o $DOTFILES_ROOT/zsh/_git-completion-zsh

ln $DOTFILES_ROOT/git/.gitconfig.local.symlink ~/.gitconfig

ln $DOTFILES_ROOT/psql/.psqlrc.symlink ~/.psqlrc

ln $DOTFILES_ROOT/vim/.vimrc.symlink ~/.vimrc
ln $DOTFILES_ROOT/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln $DOTFILES_ROOT/vim/init.vim ~/.config/nvim/init.vim

ln $DOTFILES_ROOT/zsh/.zshrc.local.symlink ~/.zshrc
