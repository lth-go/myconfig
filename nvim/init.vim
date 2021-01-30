call plug#begin('~/.local/share/nvim/plugged')

" =====插件=====
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 主题配色
Plug 'morhetz/gruvbox'
" 文件列表
Plug 'scrooloose/nerdtree'
" 状态栏
Plug 'vim-airline/vim-airline'
" 注释
Plug 'scrooloose/nerdcommenter'
" 括号匹配
Plug 'jiangmiao/auto-pairs'
" 结对符修改
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" 字符处理
Plug 'tpope/vim-abolish'
" 快速选中
Plug 'terryma/vim-expand-region'
" Tag跳转
" Plug 'ludovicchabant/vim-gutentags'
" 高亮, 对齐
Plug 'sheerun/vim-polyglot', { 'tag': 'v4.16.0'}
" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" tag
Plug 'liuchengxu/vista.vim'
" 快速跳转
Plug 'justinmk/vim-sneak'
" 文本对齐
Plug 'junegunn/vim-easy-align'

call plug#end()

" =====基础配置=====

" 设置编码格式
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1

" 覆盖文件不备份
set nobackup
set nowritebackup
" 关闭交换文件
set noswapfile

set updatetime=300
set shortmess+=c

if &diff
    set noreadonly
endif

" 菜单补全
set wildmode=longest:full,full
let &wildcharm = &wildchar
cnoremap <expr> / pumvisible() ? "\<Down>" : "/"

" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git,*.o,tags

" 允许有未保存时切换缓冲区
set hidden
set noshowcmd

" 相对行号
set relativenumber number
" 行号切换
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif
augroup END

" 禁止拆行
set nowrap
" 高亮显示当前行
set cursorline

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
set sidescrolloff=10

" 搜索时大小写不敏感
set ignorecase
set smartcase

" 智能缩进
set cindent
" 制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 连续空格视为制表符
set softtabstop=4
" 将Tab自动转化成空格
set expandtab
" 智能缩进
set shiftround

" yaml缩进
autocmd FileType javascript,json,yaml,sh setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" proto缩进
autocmd FileType proto setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Git
autocmd FileType git setlocal foldenable

" Markdown
autocmd FileType markdown setlocal wrap

" 使用系统剪切板
" need xsel
set clipboard+=unnamedplus

" 输入法正常切换
autocmd InsertLeave * if system('fcitx5-remote') != 0 | call system('fcitx5-remote -c') | endif

" 打开自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" 自动添加头部
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
  " Shell
  if &filetype == 'sh'
    call setline(1, "\#!/bin/bash")
    call append(1, ["", "set -xeuo pipefail"])
  endif

  " Python
  if &filetype == 'python'
    call setline(1, "\#!/usr/bin/env python")
    call append(1, "\# encoding: utf-8")
  endif

  normal G
  normal o
  normal o
endfunc

" =====快捷键=====

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
" noremap q <Nop>
" noremap Q <Nop>
noremap K <Nop>

" 定义<Leader>
let mapleader = ";"
noremap <Space> ;

" 块粘贴修正
map <Leader>y ""y
map <Leader>p ""p

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
noremap L g_

" 命令行模式增强
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>

" 插入模式增强
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-D> <Del>

" 搜索关键词居中
nnoremap n nzz
nnoremap N Nzz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz
nnoremap <silent> <C-]> <C-]>zz

nnoremap <silent><Backspace> :nohlsearch<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee > /dev/null %

" 复制当前行号
nnoremap <silent> <C-g> :let @+ = join([expand('%'),  line(".")], ':')\|:echo @+<CR>

" 粘贴不覆盖
xnoremap <expr> p 'pgv"'.v:register.'y'

" * 搜索不移动 可视模式高亮选中 -----
function! s:Starsearch_CWord()
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

function! s:Starsearch_VWord()
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call <SID>Starsearch_CWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call <SID>Starsearch_VWord()<CR>

" ----- start_search end -----

" 自动关闭buffer -----
function! s:SortTimeStamps(lhs, rhs)
  if a:lhs[1] > a:rhs[1] | return 1 | endif
  if a:lhs[1] < a:rhs[1] | return -1 | endif
  return a:lhs[0] > a:rhs[0]
endfunction

" TODO: fugitive打开的buf不能自动执行
function! s:CloseBuffer(nb_to_keep)
  " 列出所有buffer, 过滤已修改的
  let saved_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && !getbufvar(v:val, "&modified")')

  " 过滤当前已打开的buffer
  let window_buffers = map(range(1, winnr('$')), 'winbufnr(v:val)')
  let saved_buffers = filter(saved_buffers, 'index(window_buffers, v:val) == -1')

  " buffer按时间排序
  let buffer_to_time = map(copy(saved_buffers), '[(v:val), getftime(bufname(v:val))]')

  " 关闭未命名buff
  let no_name_buffer = filter(copy(buffer_to_time), 'v:val[1] <= 0 && getbufvar(v:val[0], "&buftype") == ""')
  if len(no_name_buffer) > 0
    exe 'bd ' . join(map(no_name_buffer, 'v:val[0]'), ' ')
  endif

  " 过滤并排序
  call filter(buffer_to_time, 'v:val[1] > 0')
  call sort(buffer_to_time, function('s:SortTimeStamps'))

  " 关闭buffer
  let buffers_to_strip = map(copy(buffer_to_time[:-a:nb_to_keep]), 'v:val[0]')
  if len(buffers_to_strip) > 0 
    exe 'bd ' . join(buffers_to_strip, ' ') 
  endif
endfunction

command! -nargs=1 CloseOldBuffers call s:CloseBuffer(<args>)

" 关闭当前buffer外的其他buffer
nnoremap <Leader>bd :CloseOldBuffers 1<CR>

augroup CloseOldBuffers
  au!
  au BufNew * call s:CloseBuffer(g:nb_buffers_to_keep)
augroup END

" 最大buffer数
let g:nb_buffers_to_keep = 6

" ----- auto_close_buffers end -----

" =====Coc=====

let g:coc_global_extensions = [
  \ 'coc-lists',
  \ 'coc-json',
  \ 'coc-xml',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-sh',
  \ 'coc-sql',
  \ 'coc-go',
  \ 'coc-python',
  \ 'coc-phpls',
  \ 'coc-tsserver',
  \ 'coc-flow',
  \ 'coc-clangd',
  \ 'coc-vimlsp',
  \ 'coc-translator',
\ ]

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>g <Plug>(coc-definition)zz
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <leader>af  <Plug>(coc-format-selected)
nmap <Leader>af  <Plug>(coc-format)

" text object
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <Leader>ff :CocList files<CR>
nnoremap <silent> <Leader>fc :exe 'CocList grep ' . expand('<cword>')<CR>
vnoremap <leader>fc :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <silent> <Leader>fg :exe 'CocList -I grep --ignore-case'<CR>
nnoremap <silent><nowait> <Leader>fs  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <Leader>fu  :<C-u>CocList outline<cr>

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep ' . word
endfunction

" coc-translator
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

" 状态栏右下角添加当前函数名
function! AirlineInit()
  let g:airline_section_x = airline#section#create_right(['%{GetCurrentFunction()} ']) . g:airline_section_x
endfunction
autocmd User AirlineAfterInit call AirlineInit()

function! GetCurrentFunction() abort
  return get(b:, 'coc_current_function', '')
endfunction

" 多光标
" nmap <silent> <C-c> <Plug>(coc-cursors-position)
" nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" nmap <leader>x  <Plug>(coc-cursors-operator)

" =====NERDTree=====

" 显示隐藏文件
let NERDTreeShowHidden = 1
" 不显示冗余帮助信息
let NERDTreeMinimalUI = 1
" 退出vim时自动关闭
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略显示
let NERDTreeIgnore = [
  \ 'tags',
  \ '\.git$',
  \ '\.idea',
  \ '\.pyc',
  \ '\.pyo',
  \ '__pycache__',
  \ '\~$',
  \ '\.swp',
  \ '\.o',
  \ '\.so',
\ ]
" 打开文件树
nmap <C-\> :NERDTreeToggle<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme = 'gruvbox'
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
" 不显示vim-fugitive分支名
let g:airline#extensions#branch#enabled = 0
" 不显示vista
let g:airline#extensions#vista#enabled = 0
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
    \ '0': '0 ',
    \ '1': '1 ',
    \ '2': '2 ',
    \ '3': '3 ',
    \ '4': '4 ',
    \ '5': '5 ',
    \ '6': '6 ',
    \ '7': '7 ',
    \ '8': '8 ',
    \ '9': '9 '
\ }


" =====Nerdcommenter=====

" 关闭默认快捷键
let g:NERDCreateDefaultMappings = 0
" 注释符左对齐
let g:NERDDefaultAlign = 'left'
" 注释有空格
let g:NERDSpaceDelims = 1
" 自动注释快捷键
map <C-_> <plug>NERDCommenterToggle

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

" =====vim-gutentags=====

" ctags https://github.com/universal-ctags/ctags

" tags统一目录
let s:vim_tags = expand('~/.cache/ctags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 额外参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c-kinds=+px', '--languages=C,C++,Go,Python,Php']

" =====vim-polyglot=====

" 需放最开头
" let g:polyglot_disabled = []

" php
" 去除多余高亮
let php_sql_query = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
let php_html_in_strings = 0
let php_html_in_heredoc = 0
let php_html_in_nowdoc = 0
let php_html_load = 0
let php_ignore_phpdoc = 1
" let g:php_syntax_extensions_enabled = []

" go
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1

" javascript
let g:javascript_plugin_flow = 1

" =====vim-fugitive=====

command! -nargs=? -complete=customlist,s:diffcomplete GitDiffFileList call s:GitDiff_NameOnly(<f-args>)

function! s:GitDiff_NameOnly(...)
  let branch = 'origin/master'

  if a:0 && !empty(a:1)
    let branch = a:1
  endif

  exe 'Git difftool --name-only ' . branch
  exe 'copen'

  execute 'nnoremap <silent> <buffer> o <C-w><C-o><CR>\|:Gvdiffsplit! ' . branch . '<CR>'
endfunction

" 命令行补全
function! s:diffcomplete(a, l, p) abort
  return fugitive#repo().superglob(a:a)
endfunction

" =====vista=====

let g:vista#renderer#enable_icon = 0
let g:vista_echo_cursor = 0
let g:vista_default_executive = 'coc' 

" =====vim-sneak=====

map <Space> <Plug>Sneak_;

" =====vim-easy-align=====

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" =====vim-abolish=====

" MixedCase   crm
" camelCase   crc
" snake_case  crs
" UPPER_CASE  cru
" dash-case   cr-
" dot.case    cr.
" space case  cr<space>
" Title Case  crt

" =====主题=====

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

highlight link Operator GruvboxRed

set termguicolors
