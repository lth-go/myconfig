"""""""""""""""""""""""""""""""""""""""""""""
"                   Vundle                  "
"""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" =====基础=====
" 语法检查
Plugin 'w0rp/ale'
" 代码补全
Plugin 'Valloric/YouCompleteMe'
" 模板补全
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" 文件搜索
Plugin 'ctrlpvim/ctrlp.vim'
" 文本搜索
Plugin 'dyng/ctrlsf.vim'
" 快速移动
Plugin 'easymotion/vim-easymotion'
" 主题配色
Plugin 'tomasr/molokai'
" 文件列表
Plugin 'scrooloose/nerdtree'
" 函数列表
Plugin 'majutsushi/tagbar'
" 状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" 注释
Plugin 'scrooloose/nerdcommenter'
" 括号匹配
Plugin 'jiangmiao/auto-pairs'
" 彩虹括号
Plugin 'kien/rainbow_parentheses.vim'
" 代码格式化
Plugin 'Chiel92/vim-autoformat'
" 对齐线
Plugin 'Yggdroot/indentLine'
" 标签修改
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" =====python=====
" python代码对齐
Plugin 'hynek/vim-python-pep8-indent'
" python导入优化
Plugin 'fisadev/vim-isort'
" python高亮
Plugin 'hdima/python-syntax'
" =====Html=====
" html标签匹配
Plugin 'alvan/vim-closetag'
Plugin 'valloric/MatchTagAlways'
" =====Markdown=====
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()


"""""""""""""""""""""""""""""""""""""""""""""
"                   基础                    "
"""""""""""""""""""""""""""""""""""""""""""""

" 文件类型检测
filetype plugin indent on

" vimrc修改后自动加载
autocmd! bufwritepost .vimrc source %

" 设置编码格式
set encoding=utf-8
set termencoding=utf-8

" 文件修改自动载入
set autoread
" 取消备份
set nobackup
" 关闭交换文件
set noswapfile

" 正则magic模式
"set magic

" history存储容量
set history=2000

" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git


"""""""""""""""""""""""""""""""""""""""""""""
"                   界面                    "
"""""""""""""""""""""""""""""""""""""""""""""

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 显示当前正在输入的命令
set showcmd

" 禁止折叠
set nofoldenable

" 菜单补全
set completeopt=menuone
" vim 自身命令行模式智能补全
set wildmenu
set wildmode=longest:full,full
" 命令行忽略大小写
set wildignorecase

" 相对行号
set relativenumber number
" 当前窗口用相对行号，其他窗口绝对行号
autocmd WinEnter * :setlocal number relativenumber
autocmd WinLeave * :setlocal number norelativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :setlocal norelativenumber number
autocmd InsertLeave * :setlocal relativenumber

" 禁止拆行
set nowrap
" 高亮显示当前行/列
set cursorline
"set cursorcolumn

" 指定分割的区域
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""
"                   内容                    "
"""""""""""""""""""""""""""""""""""""""""""""

" 开启语法高亮功能
syntax enable
" 允许替换默认配色
syntax on
" python语法高亮
let python_highlight_all = 1

" 高亮显示搜索结果
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase

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

" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·

" 光标下方保留的行数
set scrolloff=5


"""""""""""""""""""""""""""""""""""""""""""""
"                   其他                    "
"""""""""""""""""""""""""""""""""""""""""""""

" 输入法正常切换
" 快捷键延迟
set ttimeoutlen=10
autocmd InsertLeave * if system('fcitx-remote') != 0 | call system('fcitx-remote -c') | endif

" 自动添加python文件头部
function! HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" 打开自动定位到最后编辑的位置
if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""
"                  快捷键                   "
"""""""""""""""""""""""""""""""""""""""""""""

" 废弃F1
noremap <F1> <Esc>"

" 定义快捷键前缀，即<Leader>
let mapleader=";"

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
" wildmode增强
let &wildcharm = &wildchar
cnoremap <expr> <C-J> wildmenumode() ? "\<Down>" : "\<C-J>"

" 搜索关键词居中
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!用sudo保存
cabbrev w!! w !sudo tee >/dev/null %


"""""""""""""""""""""""""""""""""""""""""""""
"                    Ale                    "
"""""""""""""""""""""""""""""""""""""""""""""

" pip install flake8
let g:ale_linters = {'python': ['flake8']}
let g:ale_python_flake8_args = '--ignore=E116,E501,F401 '
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
    if old_last_winnr == winnr('$')
        lwindow
    endif
endfunction
nnoremap <Leader>e :call ToggleErrors()<cr>


"""""""""""""""""""""""""""""""""""""""""""""
"                    YCM                    "
"""""""""""""""""""""""""""""""""""""""""""""

" 下拉栏快捷键
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-K>']
let g:ycm_key_list_select_completion = ['<TAB>', '<C-J>']
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 指定jedi的Python解释器路径
let g:ycm_server_python_interpreter = '/work/python_venv/mapboom_venv/bin/python'
" 函数跳转
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"                 UltiSnips                 "
"""""""""""""""""""""""""""""""""""""""""""""

" 插入模板
let g:UltiSnipsExpandTrigger = "<leader><tab>"


"""""""""""""""""""""""""""""""""""""""""""""
"                   CtrlP                   "
"""""""""""""""""""""""""""""""""""""""""""""

" 搜索快捷键修改
let g:ctrlp_map = '<leader>f'
" 禁用默认工作目录
let g:ctrlp_working_path_mode=0
" 忽略文件
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|idea)$',
            \ 'file': '\v\.(so|zip|tar|tar.gz|pyc|pyo|swp)$',
            \ }


"""""""""""""""""""""""""""""""""""""""""""""
"                   CtrlSF                  "
"""""""""""""""""""""""""""""""""""""""""""""

" dnf install ack
" 设置搜索快捷键
nmap <leader>s <Plug>CtrlSFPrompt
" 搜索框居底部
let g:ctrlsf_position = 'bottom'
" 设置高度
let g:ctrlsf_winsize = '30%'
" 打开文件时不关闭
let g:ctrlsf_auto_close = 0
" 关闭保存确认
let g:ctrlsf_confirm_save = 0
" 快捷键设置
let g:ctrlsf_mapping = {
    \ "next"  : "<C-N>",
    \ "prev"  : "<C-P>",
    \ }


"""""""""""""""""""""""""""""""""""""""""""""
"                 EasyMotion                "
"""""""""""""""""""""""""""""""""""""""""""""

" 关闭默认快捷键
let g:EasyMotion_do_mapping = 0
" 忽略大小写
let g:EasyMotion_smartcase = 1
" s键快速跳转
nmap s <Plug>(easymotion-s)
nmap S <Plug>(easymotion-overwin-f)


"""""""""""""""""""""""""""""""""""""""""""""
"                  NERDTree                 "
"""""""""""""""""""""""""""""""""""""""""""""

" 使用NERDTree插件查看工程文件
nmap <Leader>d :NERDTreeToggle<CR>
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应buffer
let NERDTreeAutoDeleteBuffer=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 退出vim时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\.pyo','\~$','\.swp','\.git$','\.idea']


"""""""""""""""""""""""""""""""""""""""""""""
"                   Tagbar                  "
"""""""""""""""""""""""""""""""""""""""""""""

" 打开Tagbar时光标跟随
let g:tagbar_autofocus = 1
" 显示行号
let g:tagbar_show_linenumbers = -1
" 打开Tagbar
nmap <leader>t :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"                  Airline                  "
"""""""""""""""""""""""""""""""""""""""""""""

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


"""""""""""""""""""""""""""""""""""""""""""""
"                 Autoformat                "
"""""""""""""""""""""""""""""""""""""""""""""

" pip install autopep8
" Autoformat快捷键
noremap <Leader>a :Autoformat<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"            RainbowParentheses             "
"""""""""""""""""""""""""""""""""""""""""""""

let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces


"""""""""""""""""""""""""""""""""""""""""""""
"                   Isort                   "
"""""""""""""""""""""""""""""""""""""""""""""

" Isort快捷键
nnoremap <Leader>i :Isort<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"                     主题                  "
"""""""""""""""""""""""""""""""""""""""""""""

" 背景颜色
set background=dark
" molokai主题
let g:rehash256 = 1
colorscheme molokai
