# my_config

## Init

```sh
# Make Dir
mkdir ~/.ssh/
mkdir ~/work/
mkdir ~/data/
mkdir ~/.pip/

# config
cd ~ && git clone --depth 1 https://email%40password@github.com/lth-go/myconfig.git

# Set ssh key

# dnf
sudo dnf install -y zsh nvim htop
sudo dnf install -y docker docker-compose
sudo dnf install -y python2 golang nodejs
sudo dnf install -y ripgrep fd-find

sudo dnf install -y fcitx fcitx-configtool
# https://github.com/fcitx/fcitx/issues/337

# soft link
cd ~
ln -sf ~/myconfig/zsh/.zshrc .zshrc
cd ~/.config && ln -sf ~/myconfig/nvim nvim
ln -sf ~/myconfig/git/.gitconfig .gitconfig
ln -sf ~/myconfig/ripgrep/.rgrc .rgrc
cd ~/.pip && ln -sf ~/myconfig/python/pip.conf pip.conf

cd /
sudo ln -sf ~/work/ work
sudo ln -sf ~/data/ data

# zsh
cd ~/myconfig/zsh/ && sh ./install.sh

cd ~/.oh-my-zsh/custom/themes/ && ln -sf ~/myconfig/zsh/my.zsh-theme my.zsh-theme

cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-autosuggestions.git
git clone git://github.com/zsh-users/zsh-completions.git
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim
cd ~/myconfig
cp vim/plug.vim ~/.local/share/nvim/site/autoload
## $ vim :PlugInstall

# ctags https://github.com/universal-ctags/ctags


# Python
pip install --user virtualenv
cd /work/python_venv/
virtualenv --python=python2 py2_venv
virtualenv --python=python3 py3_venv

source /work/python_venv/py2_venv/bin/activate
pip install jedi autopep8 flake8

source /work/python_venv/py3_venv/bin/activate
pip install jedi autopep8 flake8

pip install --user ipython
pip install --user requests
pip install --user dstat
pip install --user jedi autopep8 flake8

# Golang

# Nodejs
npm config set registry https://registry.npm.taobao.org

sudo npm install -g diff-so-fancy tldr
sudo npm -g install flow-bin

# Docker
sudo systemctl enable docker

## Bug
sudo dnf install -y grubby
grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

```

## Update

```sh
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
```
