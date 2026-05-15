#!/usr/bin/env bash
DOTFILES_ROOT=$(pwd -P)

if [ ! -f git/.gitconfig.local.symlink ]; then
    read -p 'What is your git user name?' git_author
    read -p 'What is your personal git email?' git_personal_email
    read -p 'What is your work git email?' git_work_email

    sed -e "s/AUTHOR/$git_author/g" -e "s/PERSONAL_EMAIL/$git_personal_email/g" git/.gitconfig.symlink > git/.gitconfig.local.symlink
    sed -e "s/AUTHOR/$git_author/g" -e "s/WORK_EMAIL/$git_work_email/g" git/.gitconfig-work.symlink > git/.gitconfig-work.local.symlink
fi

sed -e "s=DOTFILES_ROOT=${DOTFILES_ROOT}=g" zsh/.zshrc.symlink > zsh/.zshrc.local.symlink

# git autocompletion
# Sourced from https://github.com/git/git/blob/v2.33.0/contrib/completion/git-completion.zsh. Credit to authors.
if [ ! -f "$DOTFILES_ROOT/zsh/_git-completion-bash" ]; then
    curl https://raw.githubusercontent.com/git/git/v2.33.0/contrib/completion/git-completion.bash -o "$DOTFILES_ROOT/zsh/_git-completion-bash"
    curl https://raw.githubusercontent.com/git/git/v2.33.0/contrib/completion/git-completion.zsh -o "$DOTFILES_ROOT/zsh/_git-completion-zsh"
fi

# https://github.com/zsh-users/zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# https://github.com/zsh-users/zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

ln "$DOTFILES_ROOT/git/.gitconfig.local.symlink" ~/.gitconfig
ln "$DOTFILES_ROOT/git/.gitconfig-work.local.symlink" ~/.gitconfig-work

ln "$DOTFILES_ROOT/psql/.psqlrc.symlink" ~/.psqlrc

echo "creating nvim configuration"
mkdir ~/.config/nvim

ln "$DOTFILES_ROOT/vim/.vimrc.symlink" ~/.vimrc
ln "$DOTFILES_ROOT/vim/coc-settings.json" ~/.config/nvim/coc-settings.json
ln "$DOTFILES_ROOT/vim/init.vim" ~/.config/nvim/init.vim
ln "$DOTFILES_ROOT/vim/plug.vim" ~/.config/nvim/plug.vim
mkdir ~/.config/efm-langserver
ln "$DOTFILES_ROOT/vim/efm-ls-config.yaml" ~/.config/efm-langserver/config.yaml

ln "$DOTFILES_ROOT/zsh/.p10k.zsh" ~/.p10k.zsh
ln "$DOTFILES_ROOT/zsh/.zshrc.local.symlink" ~/.zshrc
