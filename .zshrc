# zsh目录
export ZSH=$HOME/.oh-my-zsh

# 主题
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#DISABLE_UNTRACKED_FILES_DIRTY="true"

# 插件
# git://github.com/zsh-users/{}
plugins=(git docker docker-compose docker-machine z sudo colored-man-pages extract zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

# 用户配置

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# 历史记录快捷键
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# zsh-completions 需要
autoload -U compinit && compinit
