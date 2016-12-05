# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# 主题
ZSH_THEME="robbyrussell"

# 补全区分大小写
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# 关闭自动更新
# DISABLE_AUTO_UPDATE="true"

# 自动更新时间
# export UPDATE_ZSH_DAYS=13

# 关闭终端标题
# DISABLE_AUTO_TITLE="true"

# 开启命令纠正
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# 插件
# git://github.com/zsh-users/{}
plugins=(git docker docker-compose docker-machine z sudo colored-man-pages extract zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

# 用户配置

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# 历史记录快捷键
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# zsh-completions 需要
autoload -U compinit && compinit
