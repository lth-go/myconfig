" 关闭vi兼容
set nocompatible
call plug#begin('~/.vim/plugged')

" =====基础=====
" 语法检查
Plug 'w0rp/ale'
" 代码补全
Plug 'Valloric/YouCompleteMe', {'frozen': 1}
" 文件搜索
Plug 'ctrlpvim/ctrlp.vim'
" 文本搜索
Plug 'dyng/ctrlsf.vim'
" 快速移动
Plug 'easymotion/vim-easymotion'
" 主题配色
Plug 'morhetz/gruvbox'
" 文件列表
Plug 'scrooloose/nerdtree'
" 函数列表
Plug 'majutsushi/tagbar'
" 状态栏
Plug 'vim-airline/vim-airline'
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
" Jinja2高亮
Plug 'Glench/Vim-Jinja2-Syntax'
" =====javascript=====
" javascript高亮
Plug 'pangloss/vim-javascript'
" javascript第三方库高亮
Plug 'othree/javascript-libraries-syntax.vim'
" =====Html=====
" Html标签匹配
Plug 'alvan/vim-closetag'
" Html标签显示
Plug 'valloric/MatchTagAlways'

call plug#end()

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
set completeopt-=preview
" 历史命令容量
set history=2000
" 命令行智能补全
set wildmenu
set wildmode=longest:full,full
" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git
" wildmode增强
let &wildcharm = &wildchar
cnoremap <expr> / wildmenumode() ? "\<Down>" : "/"

" =====状态栏=====

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 显示当前正在输入的命令
set showcmd

" 允许有未保存时切换缓冲区
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

" 使用系统剪切板
" sudo dnf install vim-X11 
" alias vim='vimx'
set clipboard=unnamedplus

" 快捷键延迟
set ttimeoutlen=10
" 输入法正常切换
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
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" =====快捷键=====

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
noremap q <Nop>
noremap Q <Nop>

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

" 命令行模式增强
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

"插入模式增强
inoremap <C-A> <Home>
inoremap <C-E> <End>

" 搜索关键词居中
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" * 搜索不移动 可视模式高亮选中
function! Starsearch_CWord()
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

function! Starsearch_VWord()
    let savedUnnamed = @"
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    let @" = savedUnnamed
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call Starsearch_CWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call Starsearch_VWord()<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee >/dev/null %

" =====Ale=====

" pip install flake8
" npm install -g eslint

" python语法检查
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_args = '--ignore=E116,E402,E501,F401'
" 关闭airline显示
let g:airline#extensions#ale#enabled = 0
" 关闭自动检查
let g:ale_lint_on_text_changed = 'never'
" 提示符修改
let g:ale_sign_error = '——'
let g:ale_sign_warning = '——'
" 取消错误高亮
let g:ale_set_highlights = 0
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
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.', 're!(?=[a-zA-Z_])'],
            \   'cpp' : ['->', '.', '::', 're!(?=[a-zA-Z_])'],
            \   'javascript,python' : ['.', 're!(?=[a-zA-Z_])'],
            \   'html': ['<', '"', '</', ' '],
            \ }
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 指定jedi的Python解释器路径
let g:ycm_server_python_interpreter = '/work/python_venv/nav_biz_venv/bin/python'
" c语言补全不提示
let g:ycm_confirm_extra_conf=0
" 关闭c语法检查
let g:ycm_show_diagnostics_ui = 0
" 函数跳转
nnoremap <leader>g :YcmCompleter GoTo<CR>

" =====CtrlSF=====

" dnf install ack

" 打开文件不关闭
let g:ctrlsf_auto_close = 0
" 忽略文件夹
let g:ctrlsf_ignore_dir = ['.idea', '.git']
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
map f <Plug>(easymotion-s)
map F <Plug>(easymotion-overwin-f)

" =====NERDTree=====

" 显示隐藏文件
let NERDTreeShowHidden=1
" 不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 自动删除文件对应buffer
let NERDTreeAutoDeleteBuffer=1
" 退出vim时自动关闭
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略显示
let NERDTreeIgnore=['\.pyc','\.pyo','\~$','\.swp','\.git$','\.idea']
" 打开文件树
nmap <C-\> :NERDTreeToggle<CR>

" =====Tagbar=====

" npm install -g git+https://github.com/ramitos/jsctags.git

" 打开Tagbar时光标跟随
let g:tagbar_autofocus = 1
" javascript tag支持
let g:tagbar_type_javascript = {'ctagsbin': 'jsctags'}
" 不显示冗余信息
let g:tagbar_compact=1
" 打开Tagbar
nmap <C-t> :TagbarToggle<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme="gruvbox"
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''
" 标签页快捷键
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0: ',
    \ '1': '1: ',
    \ '2': '2: ',
    \ '3': '3: ',
    \ '4': '4: ',
    \ '5': '5: ',
    \ '6': '6: ',
    \ '7': '7: ',
    \ '8': '8: ',
    \ '9': '9: '
    \}

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
" dnf install astyle

" Python
let g:formatdef_custom_autopep8 = "'autopep8 - --ignore=E116,E501'"
let g:formatters_python = ['custom_autopep8']
" C
let g:formatdef_custom_c='"astyle --mode=c --style=google"'
let g:formatters_c = ['custom_c']
" Autoformat快捷键
noremap <Leader>a :Autoformat<CR>

" =====RainbowParentheses=====

" 开启彩虹括号
let g:rainbow_active = 1

" =====Gruvbox=====

" 分割线颜色
let g:gruvbox_vert_split = 'bg0'

" =====主题=====

" 背景颜色
set background=dark
" 主题
colorscheme gruvbox

" python高亮修改
autocmd Filetype python syntax keyword pythonBuiltin cls self
" vim-javascript高亮修改
highlight link jsOperator javaScriptOperator
" ale提示符颜色
highlight ALEErrorSign term=reverse cterm=bold ctermfg=167 ctermbg=237
highlight ALEWarningSign term=standout cterm=bold ctermfg=223 ctermbg=237
