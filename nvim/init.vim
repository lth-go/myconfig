call plug#begin('~/.local/share/nvim/plugged')

" =====插件=====

Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'morhetz/gruvbox'                          " 主题配色
Plug 'sheerun/vim-polyglot'                     " 高亮, 对齐
Plug 'vim-airline/vim-airline'                  " 状态栏
Plug 'scrooloose/nerdcommenter'                 " 注释
Plug 'jiangmiao/auto-pairs'                     " 括号匹配
Plug 'tpope/vim-surround'                       " 结对符修改
Plug 'tpope/vim-repeat'                         " 重复
Plug 'tpope/vim-abolish'                        " 字符处理
Plug 'chaoren/vim-wordmotion'                   " 字符选中
Plug 'terryma/vim-expand-region'                " 快速选中
Plug 'ryanoasis/vim-devicons'                   " 图标美化,需安装字体
Plug 'tpope/vim-fugitive'                       " Git
Plug 'liuchengxu/vista.vim'                     " Tag
Plug 'justinmk/vim-sneak'                       " 快速移动
Plug 'junegunn/vim-easy-align'                  " 文本对齐
Plug 'voldikss/vim-floaterm'                    " 终端
Plug 'AndrewRadev/splitjoin.vim'                " 拆行

call plug#end()

" =====基础配置=====

" 设置编码格式
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1

set updatetime=300
set shortmess+=c
set jumpoptions+=stack

" 关闭文件缓存
set nobackup
set nowritebackup
set noswapfile

" 允许有未保存时切换缓冲区
set hidden

" 菜单补全
set wildmode=longest:full,full
let &wildcharm = &wildchar
cnoremap <expr> / pumvisible() ? "\<Down>" : "/"

" 忽略文件
set wildignore+=.vim,.idea,.git
set wildignore+=*.swp,tags
set wildignore+=*.o,*.a,*.so
set wildignore+=*.pyc,*.pyo
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz

" 相对行号
set relativenumber number

" 禁止折叠
set nofoldenable
" 禁止拆行
set nowrap
" 高亮显示当前行
set cursorline
" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·
set signcolumn=number

" popup-menu透明度
set pumblend=10
set winblend=10

" 垂直滚动
set scrolloff=10
" 水平滚动
set sidescrolloff=10

" 指定分割的区域
set splitbelow
set splitright

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

" 使用系统剪切板
set clipboard+=unnamedplus

if &diff
    set noreadonly
endif

" =====autocmd=====

" 缩进
autocmd FileType javascript,yaml,sh,vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go map [[ 99[{
autocmd FileType go map ]] 99]}
" Json
autocmd FileType json setlocal wrap tabstop=2 shiftwidth=2 softtabstop=2
" Proto
autocmd FileType proto setlocal tabstop=4 shiftwidth=4 softtabstop=4
" Git
autocmd FileType git setlocal foldenable
" Markdown
autocmd FileType markdown setlocal wrap
" Rego
autocmd FileType rego setlocal noexpandtab

" filetype
autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=dockerfile

" 行号切换
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif
augroup END

" 输入法正常切换
if has('unix')
  if has('mac')
    autocmd InsertLeave * call system('~/myconfig/mac/vim/im-select com.apple.keylayout.ABC')
  " elseif has_key(environ(), 'SSH_CLIENT')
  "   if executable('lemonade')
  "       autocmd InsertLeave * call system('lemonade im-select')
  "   endif
  else
    autocmd InsertLeave * if system('fcitx5-remote') != 0 | call system('fcitx5-remote -c') | endif
  endif
endif

" 打开自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" =====快捷键=====

" 定义<Leader>
let mapleader = ";"
noremap <Space> ;

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
noremap Q <Nop>
" noremap q <Nop>
" noremap K <Nop>

" 快速保存及退出
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
" w!!用sudo保存
cabbrev w!! w !sudo tee % > /dev/null

" 切换布局快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 用于绕行
" jump list
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'

" 替换行首行尾快捷键
noremap H ^
noremap L g_
noremap <Leader>h H
noremap <Leader>l L

" 命令行模式增强
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-D> <Del>

" 插入模式增强
inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-A> <Home>
inoremap <C-E> <End>
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

" 复制当前行号
nnoremap <silent> <C-g> :let @+ = join([expand('%'),  line(".")], ':')\|:echo @+<CR>

map Y y$

" 粘贴不覆盖
xnoremap <expr> p 'pgv"'.v:register.'y'

" 块粘贴修正
map <Leader>y ""y
map <Leader>d ""d
map <Leader>p ""p
map <Leader>P ""P

nnoremap <Leader><Space> :vs<CR>

" ----- start_search 搜索不移动 可视模式高亮选中 -----
function! s:StarSearchCWord()
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

function! s:StarSearchVWord()
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call <SID>StarSearchCWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call <SID>StarSearchVWord()<CR>

" ----- start_search end -----

" ----- auto_close_buffers -----

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
  \ 'coc-explorer',
  \ 'coc-json',
  \ 'coc-xml',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-sh',
  \ 'coc-sql',
  \ 'coc-go',
  \ 'coc-pyright',
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <Leader>ff :CocList files<CR>
nmap <Leader>fm :CocList mru<CR>
nnoremap <silent> <Leader>fc :exe 'CocList -I --input=' . expand('<cword>') . ' grep'<CR>
vnoremap <leader>fc :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <silent> <Leader>fg :exe 'CocList -I grep --ignore-case'<CR>

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

" 多光标
" nmap <silent> <C-c> <Plug>(coc-cursors-position)
" nmap <silent> <C-d> <Plug>(coc-cursors-word)
" xmap <silent> <C-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" nmap <leader>x  <Plug>(coc-cursors-operator)

nnoremap <C-\> :CocCommand explorer<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
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
" 不显示vim-fugitive分支名
let g:airline#extensions#branch#enabled = 0
" 不显示vista
let g:airline#extensions#vista#enabled = 0
" 关闭状态显示空白符号计数
" let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'long', 'conflicts']

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
  \ 'i)'  :1, 'a)'  :1,
  \ 'i]'  :1, 'a]'  :1,
  \ 'i}'  :1, 'a}'  :1,
  \ 'it'  :1, 'at'  :1,
\ }
" 快捷键
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" =====vim-polyglot=====

" go
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1

" java
let java_ignore_javadoc = 0

" =====vim-fugitive=====

command! -nargs=? -complete=customlist,s:diffcomplete GitDiffFileList call s:GitDiffNameOnly(<f-args>)

function! s:GitDiffNameOnly(...)
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

let g:vista_echo_cursor = 0
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = '50'
nnoremap <F2> :Vista!!<CR>

" =====vim-sneak=====

map <Space> <Plug>Sneak_;

" =====vim-easy-align=====

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" =====vim-floaterm=====

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_keymap_toggle = '<F12>'

" =====chaoren/vim-wordmotion=====

let g:wordmotion_mappings = {
\ 'w': '<M-w>',
\ 'b': '<M-b>',
\ 'e': '<M-e>',
\ 'ge': 'g<M-e>',
\ 'aw': 'a<M-w>',
\ 'iw': 'i<M-w>',
\ '<C-R><C-W>': '<C-R><M-w>'
\ }

" =====主题=====

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

highlight link Operator GruvboxRed
" highlight link Whitespace Error
highlight link CocExplorerFileDirectory None
highlight link CocExplorerFileDiagnosticWarning None
highlight link CocExplorerFileDiagnosticError None

set termguicolors
