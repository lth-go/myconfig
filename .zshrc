# zsh目录
export ZSH=$HOME/.oh-my-zsh

# 补全大小写敏感
CASE_SENSITIVE="true"

# 主题
ZSH_THEME="my"

# 插件
# git://github.com/zsh-users/
plugins=(
safe-paste
git
docker docker-compose
golang
sudo
pip
z
extract
zsh-completions zsh-autosuggestions zsh-syntax-highlighting
)

# 用户配置

source $ZSH/oh-my-zsh.sh

# 设置环境语言
export LANG=zh_CN.utf8

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# zsh-completions 需要
autoload -U compinit && compinit

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'

# Vim
alias vi='vimx'
alias vim='vimx'

# 搜索
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# docker
alias dps="docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Status}}\""

# Tldr
alias tldr='tldr -t ocean'

# 彩色man
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export GROFF_NO_SGR=1                     # for gnome-terminal
