### dotfiles

Run `install.sh` and get going.

#### Homebrew packages

Tracked in [`Brewfile`](Brewfile) (formulae, casks, taps, and `brew bundle` extras like `go`, `npm`, and `cargo`).

On a new machine (from the dotfiles repo root):

```bash
brew bundle install --file=Brewfile
```

`install.sh` can run the same step when prompted. To refresh the Brewfile after installing or removing packages locally:

```bash
brew bundle dump --force --file=Brewfile
```

Check whether your machine matches the Brewfile without installing:

```bash
brew bundle check --file=Brewfile
```

#### Prerequisites
- ZSH
- `vundle` plugin manager for Vim. ([Reference](https://github.com/VundleVim/Vundle.vim/tree/b255382d6242d7ea3877bf059d2934125e0c4d95#quick-start))
- `oh-my-zsh` for managing ZSH. ([Reference](https://ohmyz.sh/#install))
- `powerlevel10k` theme for ZSH ([Reference](https://github.com/romkatv/powerlevel10k/))
- `fzf` for fuzzy file search ([Reference](https://github.com/junegunn/fzf)). Install `fzf` by running `/usr/local/opt/fzf/install` to generate bash completion scripts.
- `hstr` for better command history search ([Reference](https://github.com/dvorka/hstr/tree/6507ac7f9518b896809d7eee3edcaaad94769d18))
    - `hstr --show-configuration >> ~/.zshrc`
- `kubectl` for kubectl autocompletion.
- `timewarrior` ([Reference](https://timewarrior.net/))
- Most CLI tools above are listed in `Brewfile`; install them with `brew bundle install` instead of one-off `brew install` commands.
- `neovim` is installed from the official release tarball (see `vim/TROUBLESHOOTING.md`), not Homebrew.

#### References
Hugely inspired by [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
