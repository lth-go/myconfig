# MyConfig

## Init

```sh
# Set ssh key

# Make Dir
mkdir ~/.ssh/
mkdir ~/work/
mkdir ~/data/
mkdir ~/.pip/

# config
cd ~ && git clone --depth 1 git@github.com:lth-go/myconfig.git

# brew
cd /usr/local/ && git clone git://mirrors.ustc.edu.cn/brew.git
cd /usr/local/Homebrew/ && mkdir -p Library/Taps/homebrew/ && Library/Taps/homebrew/
git clone git://mirrors.ustc.edu.cn/homebrew-core.git
git clone git://mirrors.ustc.edu.cn/homebrew-cask.git
cd ~/myconfig/mac/brew/ && sh ./install.sh

brew install nvim htop wget iproute2mac jq
brew install docker-compose
brew install golang nodejs
brew install protobuf
brew install ripgrep fd-find

brew cask install docker iterm2

# soft link
cd ~
ln -sf ~/myconfig/zsh/zshrc .zshrc
cd ~/.config && ln -sf ~/myconfig/nvim nvim
ln -sf ~/myconfig/git/.gitconfig .gitconfig
ln -sf ~/myconfig/git/.gitignore_global .gitignore_global
ln -sf ~/myconfig/ripgrep/.rgrc .rgrc
cd ~/.pip && ln -sf ~/myconfig/python/pip.conf pip.conf

# /data
sudo vim /etc/synthetic.conf
work	/Users/litianhua/work
data	/Users/litianhua/data

# zsh

cd ~/myconfig/zsh/ && sh ./install.sh

cd ~/.oh-my-zsh/custom/themes/ && ln -sf ~/myconfig/zsh/my.zsh-theme my.zsh-theme

cd ~/.oh-my-zsh/custom/plugins
git clone --depth 1 git@github.com:zsh-users/zsh-autosuggestions.git
git clone --depth 1 git@github.com:zsh-users/zsh-completions.git
git clone --depth 1 git@github.com:zsh-users/zsh-syntax-highlighting.git

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim
cd ~/myconfig
cp vim/plug.vim ~/.local/share/nvim/site/autoload
# $ vim :PlugInstall

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
GO111MODULE=on go get golang.org/x/tools/gopls@lates
GO111MODULE=on go get golang.org/x/lint/golint

# Nodejs
npm config set registry https://registry.npm.taobao.org

sudo npm install -g diff-so-fancy tldr
sudo npm install -g flow-bin

# PHP
brew install php@7.3
brew link --overwrite php@7.3

brew install composer
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
composer global require "squizlabs/php_codesniffer=*"

# cd /usr/local/include/ && ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/Security.framework/Versions/A/Headers/ Security
# cd /usr/local/include/ && ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreFoundation.framework/Versions/A/Headers/ CoreFoundation

sudo pecl install swoole

vim /etc/php.ini # extension=swoole.so

# psysh
composer g require psy/psysh:@stable

# clang
brew install llvm bear
```

## Update

```sh
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
```

## 字体

```
rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/Library/Fonts
```
