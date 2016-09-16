
" ========== Vundle start==========

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" 代码补全
Plugin 'Valloric/YouCompleteMe'
" 主题配色
Plugin 'altercation/vim-colors-solarized'
" 状态栏
Plugin 'Lokaltog/vim-powerline'
" 注释
Plugin 'scrooloose/nerdcommenter'
" 文件列表
Plugin 'scrooloose/nerdtree'
" 多文档编辑
Plugin 'fholgado/minibufexpl.vim'
" 支持分支的 undo
Plugin 'sjl/gundo.vim'
" 输入法优化
Plugin 'lilydjwg/fcitx.vim'
" 括号匹配
Plugin 'jiangmiao/auto-pairs'
" 代码格式化
Plugin 'Chiel92/vim-autoformat'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" ==========基础设置==========

" 开启文件类型检测
filetype on
" 根据侦测到的不同类型加载对应插件
filetype plugin on

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" history存储容量
set history=2000

" 设置编码格式
set encoding=utf-8

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase

" vim 自身命令行模式智能补全
set wildmenu

" 中文帮助
set helplang=cn

" 隐藏文件
set wildignore=*.pyc

" 设置环境保存项
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"

" 退格键正常处理indent, eol, start等
set backspace=2

" 自动保存
set autowrite

" 文件修改之后自动载入
set autoread

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5

" 在状态栏显示正在输入的命令
set showcmd

" 退出时在终端保留内容
"set viminfo^=%

" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu


" ==========界面显示==========
"
" 启动时没有介绍消息
set shortmess=atI

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
"set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 禁止拆行
set nowrap

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on


" ==========内容显示==========

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符拓展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 让vim把连续数量的空格视为一个制表符
set softtabstop=4
" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·


" ==========快捷键==========

" 定义快捷键前缀，即<Leader>
let mapleader=";"

" 切换布局快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ==========YCM==========

" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全         
let g:ycm_seed_identifiers_with_syntax=1

" 语法错误提示
let g:ycm_error_symbol = '>>'
" 语法警告
let g:ycm_warning_symbol = '>*'


" ==========NERDTree==========

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


" ==========minibufexpl==========

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>

" 自动启动
let g:miniBufExplorerAutoStart = 1
let g:miniBufExplBuffersNeeded = 1
let g:miniBufExplStatusLineText = ""
" buffer 切换快捷键
noremap <C-Tab> :MBEbn<cr>
noremap <C-S-Tab> :MBEbp<cr>

" ==========gundo==========

nnoremap <Leader>ud :GundoToggle<CR>


" ==========Powerline==========

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'


" ==========配色方案==========
"
let g:solarized_termcolors=256
"" 设置背景颜色
set background=dark
"" 设置主题
colorscheme solarized

