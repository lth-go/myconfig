# MyConfig

## Init

```sh
# sudo 免密
sudo vim /etc/sudoers
# lth     ALL=(ALL)       NOPASSWD: ALL

# disable selinux
sudo vim /etc/selinux/config

# disable firewaa
sudo systemctl disable firewalld

# 修正目录名

export LANG=en_US
xdg-user-dirs-gtk-update

# Make Dir
mkdir ~/.ssh/
mkdir ~/work/
mkdir ~/data/
mkdir ~/.pip/

# Set ssh key

# dnf
sudo dnf install -y git
sudo dnf install -y zsh neovim python3-neovim htop
sudo dnf install -y docker docker-compose
sudo dnf install -y python2 golang nodejs
sudo dnf install -y ripgrep fd-find
sudo dnf install -y clash

sudo dnf install -y fcitx5 fcitx5-chinese-addons fcitx5-configtool
# https://github.com/fcitx/fcitx/issues/337
# 默认输入法使用fcitx5
# 禁用shift切换
# 分页切换使用[], 拼音输入法选项里额外配置
# 符号使用半角

sudo dnf copr enable agriffis/neovim-nightly
sudo dnf update -y neovim

# config
cd ~ && git clone --depth 1 https://email%40password@github.com/lth-go/myconfig.git

# soft link
cd ~
ln -sf ~/myconfig/zsh/zshrc .zshrc
cd ~/.config && ln -sf ~/myconfig/nvim nvim
ln -sf ~/myconfig/git/.gitconfig .gitconfig
ln -sf ~/myconfig/git/.gitignore_global .gitignore_global
ln -sf ~/myconfig/ripgrep/.rgrc .rgrc
cd ~/.pip && ln -sf ~/myconfig/python/pip.conf pip.conf

cd /
sudo ln -sf ~/work/ work
sudo ln -sf ~/data/ data

# zsh
cd ~/myconfig/zsh/ && sh ./install.sh

cd ~/.oh-my-zsh/custom/themes/ && ln -sf ~/myconfig/zsh/my.zsh-theme my.zsh-theme

cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-completions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim
cd ~/myconfig
mkdir -p ~/.local/share/nvim/site/autoload
cp vim/plug.vim ~/.local/share/nvim/site/autoload
# $ vim :PlugInstall

# Python
pip install --user virtualenv
mkdir ~/work/python_venv/
cd /work/python_venv/
~/.local/bin/virtualenv --python=python2 py2_venv
~/.local/bin/virtualenv --python=python3 py3_venv

source /work/python_venv/py2_venv/bin/activate
pip install jedi autopep8 flake8

source /work/python_venv/py3_venv/bin/activate
pip install jedi autopep8 flake8

deactivate
pip install --user ipython
pip install --user requests
pip install --user dstat
pip install --user jedi autopep8 flake8

# Golang
go get golang.org/x/tools/gopls@latest

# Nodejs
npm config set registry https://registry.npm.taobao.org

sudo npm install -g diff-so-fancy tldr
sudo npm -g install flow-bin

# Docker
sudo systemctl enable docker

# clash
sudo mkdir /etc/clash/
sudo wget -O /etc/clash/config.yaml {xxx}
sudo vim /usr/lib/systemd/system/clash.service
# [Unit]
# Description=Clash Daemon
# 
# [Service]
# ExecStart=/usr/bin/clash -d /etc/clash/
# Restart=on-failure
# 
# [Install]
# WantedBy=multi-user.target

sudo systemctl enable clash.service
sudo systemctl start clash.service

# http://clash.razord.top/#/proxies
```

## Update

```sh
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
```

## 字体

```
mkdir -p ~/.local/share/fonts
rm -rf ~/.local/share/fonts/DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono.ttf
cp ./fonts/DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono.ttf ~/.local/share/fonts

fc-cache -vf ~/.local/share/fonts
```
