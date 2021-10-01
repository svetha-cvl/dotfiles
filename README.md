### dotfiles

Run `install.sh` and get going.

#### Prerequisites
- ZSH
- `vundle` plugin manager for Vim. ([Reference](https://github.com/VundleVim/Vundle.vim/tree/b255382d6242d7ea3877bf059d2934125e0c4d95#quick-start))
- `oh-my-zsh` for managing ZSH. ([Reference](https://ohmyz.sh/#install))
- `powerlevel10k` theme for ZSH ([Reference](https://github.com/romkatv/powerlevel10k/))
- `fzf` for fuzzy file search ([Reference](https://github.com/junegunn/fzf)). Install `fzf` by running `/usr/local/opt/fzf/install` to generate bash completion scripts.
- `hstr` for better command history search ([Reference](https://github.com/dvorka/hstr/tree/6507ac7f9518b896809d7eee3edcaaad94769d18))
    - `hstr --show-configuration >> ~/.zshrc`
- `nodejs` for the language server configurations for the `coc.vim` plugin.
    - NOTE: The default master branch for `coc.vim` does not come with precompiled binaries, unlike the `release` branch. The vim plugin manager I use (`vundle`) unfortunately does not support pinning branches or tags at the moment. A workaround is to manually compile the necessary dependencies using `yarn build && yarn install` from `~/.vim/bundle/coc.nvim`, or manually check out a different branch.
- `kubectl` for kubectl autocompletion.
- `timewarrior` ([Reference](https://timewarrior.net/))

##### To use coc.vim
- `gopls` for the Go language server

#### References
Hugely inspired by [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
