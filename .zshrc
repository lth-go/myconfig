# zsh目录
export ZSH=$HOME/.oh-my-zsh

# 主题
ZSH_THEME="robbyrussell"

# 插件
# git://github.com/zsh-users/{}
plugins=(git docker docker-compose docker-machine z sudo colored-man-pages extract zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

# 用户配置

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# 设置环境语言
# export LANG=zh_CN.utf8

# 历史记录快捷键
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# zsh-completions 需要
autoload -U compinit && compinit
