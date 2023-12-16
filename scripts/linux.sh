# Install brew
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to $PATH
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/ubuntu/.zprofile

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Make zsh the default shell
sudo chsh -s /usr/bin/zsh

# Zsh config
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.zshrc -o ~/.zshrc

# powerlevel10k config
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.p10k.zsh -o ~/.p10k.zsh

# git config
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.gitconfig -o ~/.gitconfig

# Shell programs needed for aliases
## Install fzf (fuzzy finder)
## Install bat and exa (for fzf file preview)
## Install fasd and fd (to provide inputs for fzf)
## Install xpdf (e.g. pdftotext - for fzf PDF file preview)
## Install vim and neovim
# Zsh theme: powerlevel10k
# Zsh plugins: zsh-autosuggestions and zsh-syntax-highlighting
brew install ack bash bat bat-extras bit-git black bottom cairo diff-so-fancy duti dvc exa fd ffmpeg fpp fzf gh git git-delta gnu-tar gnupg imagemagick jq librsvg luarocks neovim node page pandoc pass python@3.11 ranger rename ripgrep ripgrep-all romkatv/powerlevel10k/powerlevel10k ruby rust rustup-init sc-im shellcheck tccutil the_platinum_searcher the_silver_searcher tig tldr tmux universal-ctags vim wget xpdf zsh zsh-autocomplete zsh-autopair zsh-autosuggestions zsh-fast-syntax-highlighting zsh-completions zsh-vi-mode zsh-you-should-use 

## Install fzf key bindings and fuzzy completion
/opt/homebrew/opt/fzf/install --completion --key-bindings --no-fish --no-update-rc

brew install --cask mambaforge

# Use Bash as a backup
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.bash_profile -o ~/.bash_profile

curl https://raw.githubusercontent.com/NishantBharali/setup/main/.inputrc -o ~/.inputrc

## Download dotfiles (configuration files)
### Vim
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.vimrc -o ~/.vimrc

### Neovim
curl https://raw.githubusercontent.com/NishantBharali/setup/main/init.vim -o ~/.config/nvim/init.vim --create-dirs

### SpaceVim
git clone https://github.com/SpaceVim/SpaceVim.git ~/.SpaceVim

curl https://raw.githubusercontent.com/NishantBharali/setup/main/init.toml -o ~/.SpaceVim.d/init.toml --create-dirs

curl https://raw.githubusercontent.com/NishantBharali/setup/main/myspacevim.vim -o ~/.SpaceVim.d/autoload/myspacevim.vim --create-dirs

## Set up oh my tmux
curl https://raw.githubusercontent.com/NishantBharali/setup/main/.tmux.conf -o ~/.tmux.conf

curl https://raw.githubusercontent.com/NishantBharali/setup/main/.tmux.conf.local -o ~/.tmux.conf.local

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Python

## Install nodejs (for coc.vim) and python packages (for nvim-R and ncm-R):
### https://github.com/jalvesaq/Nvim-R/blob/main/doc/Nvim-R.txt#L1953
conda install -yc conda-forge cookiecutter nodejs neovim pybtex

#### I don't use jupyterlab-git extension, I only demo it in classes
##### jupyter labextension install @jupyterlab/git
##### jupyter serverextension enable --py jupyterlab_git

conda create -yc conda-forge -n py python=3.8 joblib jupyterlab seaborn numpy pandas scikit-learn scipy

##### jupyter labextension install jupyterlab_vim

## Set up jupyterlab-github extension
#### jupyter labextension install @jupyterlab/github
#### pip install jupyterlab_github
##### Provide access token to GitHub extension
##### https://github.com/jupyterlab/jupyterlab-github#2-getting-your-credentials-from-github

### Install and symlink macvim (brew installed macvim conflicts with brew installed vim)
##### ln -s $HOMEBREW_PREFIX/Cellar/macvim/**/MacVim.app/ /Applications/MacVim.app
conda init zsh
