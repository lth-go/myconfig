" 关闭vi兼容
set nocompatible
call plug#begin('~/.vim/plugged')

" =====基础=====
" 中文帮助
Plug 'yianwillis/vimcdoc'
" 语法检查
Plug 'w0rp/ale'
" 代码补全
Plug 'Valloric/YouCompleteMe', {'for': ['python', 'c', 'javascript', 'go']}
" 搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
" 结对符修改
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
" 平滑滚动
Plug 'terryma/vim-smooth-scroll'
" 快速选中
Plug 'terryma/vim-expand-region'
" 高亮当前单词
Plug 'dominikduda/vim_current_word', {'for': ['python', 'c', 'javascript', 'go']}
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

" 文件类型检测
filetype plugin indent on

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

" yaml缩进
autocmd FileType javascript,json,yaml,sh set tabstop=2 shiftwidth=2 softtabstop=2

" =====其他=====

" 使用系统剪切板
" dnf install vim-X11
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
noremap K <Nop>

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
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

"插入模式增强
inoremap <C-A> <Home>
inoremap <C-E> <End>

" 搜索关键词居中
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz

nnoremap <silent><Leader><Leader> :nohlsearch<CR>

" * 搜索不移动 可视模式高亮选中
function! Starsearch_CWord()
    let wordStr = expand("<cword>")
    if strlen(wordStr) == 0 | return | endif
    if wordStr[0] =~ '\<'
        let @/ = '\<' . wordStr . '\>'
    else
        let @/ = wordStr
    endif
    let savedS = @s
    normal! "syiw
    let @s = savedS
    set hlsearch
endfunction

function! Starsearch_VWord()
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call Starsearch_CWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call Starsearch_VWord()<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee > /dev/null %

" 关闭当前buf外的其他buf
nnoremap <Leader>b :%bd \| e # \| bd #<CR>

" =====Ale=====

" pip install flake8
" npm install -g eslint
" dnf install clang

" 语法检查
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint'], 'c': ['clang']}
let g:ale_python_flake8_options = '--ignore=E116,E402,E501'
let g:ale_c_clang_options = '-std=c99 -Wall'
" 关闭airline显示
let g:airline#extensions#ale#enabled = 0
" 自动检查模式
let g:ale_lint_on_text_changed = 'normal'
" 离开插入模式时检查
let g:ale_lint_on_insert_leave = 1
" 提示符修改
let g:ale_sign_error = '——'
let g:ale_sign_warning = '——'
" 打开错误面板
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$') | lwindow | endif
endfunction
nnoremap <Leader>e :call ToggleErrors()<cr>

" =====YCM=====

" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 注释中补全
let g:ycm_complete_in_comments = 1
" 指定jedi的Python解释器路径
let g:ycm_server_python_interpreter = '/work/python_venv/mapboom_venv/bin/python'
" c语言不提示
let g:ycm_confirm_extra_conf = 0
" 关闭c语法检查
let g:ycm_show_diagnostics_ui = 0
" c头文件识别
let g:c_syntax_for_h = 1
" 智能补全
let g:ycm_semantic_triggers =  {
    \ 'c': ['->', '.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
    \ 'python,javascript,go': ['.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
    \ 'html': ['<', '"', '</', ' '],
    \ 'vim': ['re![_a-za-z]+[_\w]*\.'],
    \ 'css': ['re!^\s{2,4}', 're!:\s+' ],
    \ }
" 函数跳转
nnoremap <Leader>g :YcmCompleter GoTo<CR>zz

" =====fzf=====

" 配色
let g:fzf_colors = { 
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
\ }
" 全局搜索
nnoremap <Leader>f :Ag<Space>
" 文件搜索
nnoremap <Space> :Files<CR>

" =====EasyMotion=====

" 关闭默认快捷键
let g:EasyMotion_do_mapping = 0
" 忽略大小写
let g:EasyMotion_smartcase = 1
" 跳转键
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
" f键快速跳转
map f <Plug>(easymotion-s)
map F <Plug>(easymotion-overwin-f)

" =====NERDTree=====

" 显示隐藏文件
let NERDTreeShowHidden = 1
" 不显示冗余帮助信息
let NERDTreeMinimalUI = 1
" 退出vim时自动关闭
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略显示
let NERDTreeIgnore = ['\.pyc','\.pyo','\~$','\.swp','\.git$','\.idea']
" 打开文件树
nmap <C-\> :NERDTreeToggle<CR>

" =====Tagbar=====

" dnf install ctags
" npm install -g git+https://github.com/ramitos/jsctags.git
" go get -u github.com/jstemmer/gotags

" 打开Tagbar时光标跟随
let g:tagbar_autofocus = 1
" 不显示冗余信息
let g:tagbar_compact = 1
" javascript tag支持
let g:tagbar_type_javascript = {'ctagsbin': 'jsctags'}
" Golang tag支持
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds': [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro': '.',
    \ 'kind2scope': {
        \ 't': 'ctype',
        \ 'n': 'ntype'
    \ },
    \ 'scope2kind': {
        \ 'ctype': 't',
        \ 'ntype': 'n'
    \ },
    \ 'ctagsbin': 'gotags',
    \ 'ctagsargs': '-sort -silent'
\ }
" 打开Tagbar
nmap <Leader>t :TagbarToggle<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme = "gruvbox"
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
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0: ', '1': '1: ', '2': '2: ', '3': '3: ', '4': '4: ',
    \ '5': '5: ', '6': '6: ', '7': '7: ', '8': '8: ', '9': '9: '
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
" dnf install llvm

" Python
let g:formatdef_custom_autopep8 = "'autopep8 - --ignore=E116,E501'"
let g:formatters_python = ['custom_autopep8']
" C
let g:formatdef_custom_c = '"clang-format --style=\"{BasedOnStyle: Google, IndentWidth: 4}\""'
let g:formatters_c = ['custom_c']
" Autoformat快捷键
noremap <Leader>af :Autoformat<CR>

" =====RainbowParentheses=====

" 开启彩虹括号
let g:rainbow_active = 1

" =====vim-smooth-scroll=====

nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" =====vim-expand-region=====

" 选中区域配置, 1表示递归
let g:expand_region_text_objects = {
    \ 'iw'  :0,
    \ 'i"'  :0, 'a"'  :0,
    \ 'i''' :0, 'a''' :0,
    \ 'i`'  :0, 'a`'  :0,
    \ 'i]'  :1, 'a]'  :1,
    \ 'ib'  :1, 'ab'  :1,
    \ 'iB'  :1, 'aB'  :1,
    \ 'it'  :1, 'at'  :1,
\ }
" 快捷键
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" =====vim_current_word=====
"
let g:vim_current_word#highlight_current_word = 0
hi CurrentWordTwins ctermbg=238 cterm=None

" =====主题=====

" 高亮
syntax enable

" 背景颜色
set background=dark
" 主题
colorscheme gruvbox

" =====高亮修改=====

" 搜索高亮
hi Search ctermbg=53 ctermfg=None cterm=None

" python高亮
autocmd Filetype python syntax keyword pythonBuiltin cls self

" vim-javascript高亮
highlight link jsOperator javaScriptOperator

" go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" markdown
highlight link markdownError None

" 背景透明
highlight Normal ctermbg=None
