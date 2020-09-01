# zsh目录
export ZSH=$HOME/.oh-my-zsh

# 补全大小写敏感
CASE_SENSITIVE="true"
# 粘贴修正
DISABLE_MAGIC_FUNCTIONS=true

# 主题
ZSH_THEME="my"

# 插件
plugins=(
  git
  docker docker-compose
  golang
  pip
  sudo
  extract
  ripgrep
  zsh-completions zsh-autosuggestions zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Golang
export GOPATH="$HOME/go"
export GOBINPATH="$HOME/go/bin"
# export GOPROXY=https://goproxy.io
# export GOPROXY=https://mirrors.aliyun.com/goproxy/
export GOPROXY=http://nexus.wpt.la/repository/wpt-go-group/
export GO111MODULE=on

# PATH
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/Library/Python/2.7/bin:$PATH"
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="${GOROOT}/bin:${GOBINPATH}:${PATH}"
export PATH

# brew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# zsh-completions 需要
autoload -U compinit && compinit

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'

# 搜索
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# fzf
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r '^t'
bindkey '^\' fzf-file-widget

# rg
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

# docker
alias dps="docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Status}}\""

# Tldr
alias tldr='tldr -t ocean'

# vim
alias vim='nvim'
alias vi='nvim'
export MANPAGER='nvim +Man!'

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# work env
[ -f ~/.work.zsh ] && source ~/.work.zsh
