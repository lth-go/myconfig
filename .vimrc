" ========== Vundle==========

set nocompatible 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 代码补全
Plugin 'Valloric/YouCompleteMe'
" 主题配色
Plugin 'tomasr/molokai'
" 状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" 注释
Plugin 'scrooloose/nerdcommenter'
" 文件列表
Plugin 'scrooloose/nerdtree'
" 输入法优化 
Plugin 'lilydjwg/fcitx.vim'
" 括号匹配
Plugin 'jiangmiao/auto-pairs'
" 代码格式化
Plugin 'Chiel92/vim-autoformat'

call vundle#end()
filetype plugin indent on


" ==========基础设置==========

" 开启文件检测类型
filetype on
" 根据侦测到的不同类型加载对应插件
filetype plugin on
" 设置编码格式
set encoding=utf-8
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" vim 自身命令行模式智能补全
set wildmenu
" 退格键正常处理indent, eol, start等
set backspace=2
" 自动保存
set autowrite
" 光标的上方或下方至少会保留显示的行数
set scrolloff=5
" 菜单补全
set completeopt=longest,menu


" ==========界面显示==========

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行
set cursorline
" 高亮显示搜索结果
set hlsearch
" 禁止拆行
set nowrap
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符拓展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 把连续数量的空格视为一个制表符
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
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 语法错误提示
let g:ycm_error_symbol = '>>'
" 语法警告
let g:ycm_warning_symbol = '>*'


" ==========NERDTree==========

" 使用 NERDTree 插件查看工程文件
nmap <Leader>fl :NERDTreeToggle<CR>
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" 退出vim时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ==========Autoformat==========

" 需安装astyle yapf(pip)
" 格式化代码快捷键
noremap <F3> :Autoformat<CR>
" 格式化python代码风格为pep8
let g:formatter_yapf_style = 'pep8'


" ==========Airline==========

" 设置airline主题
let g:airline_theme="monochrome"
" 图标样式 
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''

" ==========配色方案==========

" 设置背景颜色
set background=dark
" molokai主题
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
