"""""""""""""""""""""""""""""""""""""""""""""
"                    Plug                   "
"""""""""""""""""""""""""""""""""""""""""""""

" 关闭vi兼容
set nocompatible
call plug#begin('~/.vim/plugged')

" =====基础=====
" 语法检查
Plug 'w0rp/ale'
" 代码补全
Plug 'Valloric/YouCompleteMe'
" 文件搜索
Plug 'ctrlpvim/ctrlp.vim'
" 文本搜索
Plug 'dyng/ctrlsf.vim'
" 快速移动
Plug 'easymotion/vim-easymotion'
" 主题配色
Plug 'lth-go/molokai'
" 文件列表
Plug 'scrooloose/nerdtree'
" 函数列表
Plug 'majutsushi/tagbar'
" 状态栏
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" 注释
Plug 'scrooloose/nerdcommenter'
" 括号匹配
Plug 'lth-go/auto-pairs'
" 彩虹括号
Plug 'luochen1990/rainbow'
" 代码格式化
Plug 'Chiel92/vim-autoformat'
" 结对符修改
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
" =====Python=====
" Python代码对齐
Plug 'hynek/vim-python-pep8-indent'
" Python高亮
Plug 'lth-go/python-syntax'
" =====javascript=====
Plug 'othree/yajs.vim' | Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'marijnh/tern_for_vim'
" =====Html=====
" Html标签匹配
Plug 'alvan/vim-closetag'
" Html标签显示
Plug 'valloric/MatchTagAlways'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""
"                     基础                  "
"""""""""""""""""""""""""""""""""""""""""""""

" =====文件=====

" 设置编码格式
set encoding=utf-8
set termencoding=utf-8

" 文件修改自动载入
set autoread
" 覆盖文件不备份
set nobackup
" 关闭交换文件
set noswapfile

" =====命令行=====

" 菜单补全
set completeopt=menuone
" 历史命令容量
set history=2000
" 命令行智能补全
set wildmenu
set wildmode=longest:full,full
" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git
" wildmode增强
let &wildcharm = &wildchar
cnoremap <expr> <C-J> wildmenumode() ? "\<Down>" : "\<C-J>"

" =====状态栏=====

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 显示当前正在输入的命令
set showcmd

" 允许在有未保存的修改时切换缓冲区
set hidden

" =====行号=====

" 相对行号
set relativenumber number
" 当前窗口用相对行号，其他窗口绝对行号
autocmd WinEnter * if &number | execute("setlocal number relativenumber") | endif
autocmd WinLeave * if &number | execute("setlocal number norelativenumber") | endif
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :setlocal norelativenumber number
autocmd InsertLeave * :setlocal relativenumber number

" =====内容=====

" 禁止拆行
set nowrap
" 高亮显示当前行
set cursorline

" 提高画面流畅度
set lazyredraw
set ttyfast

" 禁止折叠
set nofoldenable

" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·

" 指定分割的区域
set splitbelow
set splitright

" 垂直滚动
set scrolloff=10
" 水平滚动
set sidescroll=1
set sidescrolloff=10

" =====搜索=====

" 高亮显示搜索结果
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase

" =====缩进=====

" 退格键正常处理
set backspace=2
" 智能缩进
set cindent
" 自动缩进
set autoindent
" 制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 连续空格视为制表符
set softtabstop=4
" 按退格键一次删掉4个空格
set smarttab
" 将Tab自动转化成空格
set expandtab
" 智能缩进
set shiftround

" =====其他=====

" 输入法正常切换
" 快捷键延迟
set ttimeoutlen=10
autocmd InsertLeave * if system('fcitx-remote') != 0 | call system('fcitx-remote -c') | endif

" 自动添加头部
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh' | call setline(1, "\#!/bin/bash") | endif

    "如果文件类型为python
    if &filetype == 'python' | call setline(1, "\#!/usr/bin/env python") | call append(1, "\# encoding: utf-8") | endif

    normal G
    normal o
    normal o
endfunc

" 打开自动定位到最后编辑的位置
if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""
"                  快捷键                   "
"""""""""""""""""""""""""""""""""""""""""""""

" 废弃F1
noremap <F1> <Nop>
inoremap <F1> <Nop>

" 定义<Leader>
let mapleader=";"

" 快速保存及退出
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

" 切换布局快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 用于绕行
noremap j gj
noremap k gk

" 替换行首行尾快捷键
noremap H ^
noremap L $

" 切换buffer
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

" 命令行模式增强
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" 搜索关键词居中
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" * 搜索不移动 可视模式高亮选中
function! Starsearch_searchCWord()
    let wordStr = expand("<cword>")
    if strlen(wordStr) == 0 | return | endif

    if wordStr[0] =~ '\<'
        let @/ = '\<' . wordStr . '\>'
    else
        let @/ = wordStr
    endif

    let savedUnnamed = @"
    let savedS = @s
    normal! "syiw
    if wordStr != @s
        normal! w
    endif
    let @s = savedS
    let @" = savedUnnamed
    set hlsearch
endfunction

function! Starsearch_searchVWord()
    let savedUnnamed = @"
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    let @" = savedUnnamed
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call Starsearch_searchCWord()<CR>
vnoremap <silent> * :set nohlsearch\|:<C-u>call Starsearch_searchVWord()<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee >/dev/null %


"""""""""""""""""""""""""""""""""""""""""""""
"                     插件                  "
"""""""""""""""""""""""""""""""""""""""""""""

" =====Ale=====

" pip install flake8
" npm install -g eslint

" python语法检查
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_args = '--ignore=E116,E501,F401'
" 关闭airline显示
let g:airline#extensions#ale#enabled = 0
" 关闭自动检查
let g:ale_lint_on_text_changed = 0
" 保存时检查
let g:ale_lint_on_save = 1
" 打开错误面板
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$') | lwindow | endif
endfunction
nnoremap <Leader>e :call ToggleErrors()<cr>

" =====YCM=====

" 下拉栏快捷键
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-K>']
let g:ycm_key_list_select_completion = ['<TAB>', '<C-J>']
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 指定jedi的Python解释器路径
let g:ycm_server_python_interpreter = '/work/python_venv/mapboom_venv/bin/python'
" 函数跳转
nnoremap <leader>g :YcmCompleter GoTo<CR>

" =====CtrlSF=====

" dnf install ack

" 搜索框居底部
let g:ctrlsf_position = 'bottom'
" 打开文件时不关闭
let g:ctrlsf_auto_close = 0
" 关闭保存确认
let g:ctrlsf_confirm_save = 0
" 上下文行数
let g:ctrlsf_context = '-C 1'
" 快捷键设置
let g:ctrlsf_mapping = {
            \ "next"  : "n",
            \ "prev"  : "N",
            \ }
" 设置搜索快捷键
nmap <leader>f <Plug>CtrlSFPrompt

" =====EasyMotion=====

" 关闭默认快捷键
let g:EasyMotion_do_mapping = 0
" 忽略大小写
let g:EasyMotion_smartcase = 1
" s键快速跳转
nmap f <Plug>(easymotion-s)
nmap F <Plug>(easymotion-overwin-f)

" =====NERDTree=====

" 显示隐藏文件
let NERDTreeShowHidden=1
" 不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 自动删除文件对应buffer
let NERDTreeAutoDeleteBuffer=1
" 退出vim时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\.pyo','\~$','\.swp','\.git$','\.idea']
" 打开文件树
nmap <C-\> :NERDTreeToggle<CR>

" =====Tagbar=====

" 打开Tagbar时光标跟随
let g:tagbar_autofocus = 1
" 打开Tagbar
nmap <C-t> :TagbarToggle<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme="powerlineish"
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''
" 分隔符
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '|'

" =====Nerdcommenter=====

" 关闭默认快捷键
let g:NERDCreateDefaultMappings = 0
" 注释符左对齐
let g:NERDDefaultAlign = 'left'
" 自动注释快捷键
map <C-_> <plug>NERDCommenterToggle

" =====Autoformat=====

" pip install autopep8
" npm install -g js-beautify

" 添加格式化参数
let g:formatdef_custom_autopep8 = "'autopep8 - --ignore=E116,E501'"
let g:formatters_python = ['custom_autopep8']
" Autoformat快捷键
noremap <Leader>a :Autoformat<CR>

" =====RainbowParentheses=====

" 开启彩虹括号
let g:rainbow_active = 1


"""""""""""""""""""""""""""""""""""""""""""""
"                     主题                  "
"""""""""""""""""""""""""""""""""""""""""""""

" molokai主题
colorscheme molokai
