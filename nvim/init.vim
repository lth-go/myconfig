call plug#begin('~/.local/share/nvim/plugged')

" =====插件=====

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'github/copilot.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'famiu/feline.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'chaoren/vim-wordmotion'
Plug 'terryma/vim-expand-region'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vista.vim'
Plug 'voldikss/vim-floaterm'
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" =====基础配置=====

set termguicolors
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1

set updatetime=300
set shortmess+=csI
set jumpoptions+=stack
set inccommand=nosplit
set completeopt-=preview

set nobackup
set nowritebackup
set noswapfile
set hidden

set wildmode=longest:full,full
let &wildcharm = &wildchar
cnoremap <expr> / pumvisible() ? "\<Down>" : "/"

set wildignore+=.vim,.idea,.git
set wildignore+=*.swp,tags
set wildignore+=*.o,*.a,*.so
set wildignore+=*.pyc,*.pyo
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz

set relativenumber number

set nofoldenable
set nowrap
set cursorline
set list
set listchars=tab:>-,trail:·,nbsp:·
set signcolumn=number

set pumblend=10
set winblend=10

set scrolloff=10
set sidescrolloff=10

set splitbelow
set splitright

set ignorecase
set smartcase

set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

set clipboard+=unnamedplus

if &diff
  set noreadonly
endif

" =====autocmd=====

autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType json setlocal wrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType proto setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType git setlocal foldenable
autocmd FileType markdown setlocal wrap
autocmd FileType rego setlocal noexpandtab
autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=dockerfile

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif
augroup END

" 输入法正常切换
" if has('unix')
"   if has('mac')
"     autocmd InsertLeave * call system('~/myconfig/mac/vim/im-select com.apple.keylayout.ABC')
"   else
"     autocmd InsertLeave * if system('fcitx5-remote') != 0 | call system('fcitx5-remote -c') | endif
"   endif
" endif

" 打开自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" =====快捷键=====

let mapleader = ";"
noremap \ ;

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
noremap Q <Nop>

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

nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'

" 替换行首行尾快捷键
noremap H ^
noremap L g_

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
nnoremap <silent> <C-g> :let @+ = join([expand('%'), line(".")], ':')\|:echo @+<CR>

" 粘贴不覆盖
xnoremap <expr> p 'pgv"'.v:register.'y'

" 块粘贴修正
map <Leader>y ""y
map <Leader>d ""d
map <Leader>p ""p
map <Leader>P ""P

nnoremap <Leader><Space> :vs<CR>

" nnoremap <Space>gf :GoFillStruct<CR>
nnoremap <silent> <Space>gf :call CocActionAsync('codeAction', 'cursor', ['refactor.rewrite'])<CR>
nnoremap <Space>gt :GoTestFunc<CR>

" ----- star_search -----

function! s:StarSearch()
  let cword = expand("<cword>")

  if strlen(cword) == 0
    return
  endif

  if cword[0] =~ '\<'
    let @/ = '\<' . cword . '\>'
  else
    let @/ = cword
  endif

  set hlsearch
endfunction

function! s:VStarSearch()
  let savedS = @s
  normal! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = savedS
  set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call <SID>StarSearch()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call <SID>VStarSearch()<CR>

" ----- star_search end -----

" ----- buf_only -----

lua << EOF

local g = vim.g
local api = vim.api
local cmd = vim.cmd
local bo = vim.bo

function _G.buf_only()
  local current_buf_map = {}

  for _, win in ipairs(api.nvim_list_wins()) do
    current_buf_map[api.nvim_win_get_buf(win)] = true
  end

  for _, buf in ipairs(api.nvim_list_bufs()) do
    if api.nvim_buf_get_option(buf, 'modified') then
      goto continue
    end

    if not bo[buf].buflisted then
      goto continue
    end

    if not api.nvim_buf_is_valid(buf) then
      goto continue
    end

    if current_buf_map[buf] then
      goto continue
    end

    if api.nvim_buf_get_option(buf, 'buftype') == "" then
      cmd(string.format('%s %d', 'bdelete', buf))
    end

    ::continue::
  end
end

EOF

nnoremap <silent> <Leader>bd :call v:lua.buf_only()<CR>

" ----- buf_only end -----

" ----- mkdir start -----

lua << EOF

local fn = vim.fn

function _G.mkdir()
  local dir = fn.expand('%:p:h')

  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, 'p')
  end
end

EOF

autocmd BufWritePre * call v:lua.mkdir()

" ----- mkdir end -----

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
  \ 'coc-clangd',
  \ 'coc-vimlsp',
  \ 'coc-translator',
  \ 'coc-snippets',
  \ 'coc-tabnine',
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

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <leader>g <Plug>(coc-definition)zz
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gr <Plug>(coc-references)

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
xmap <leader>af <Plug>(coc-format-selected)
nmap <Leader>af <Plug>(coc-format)
xmap <C-A-l> <Plug>(coc-format-selected)
nmap <C-A-l> <Plug>(coc-format)

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
nnoremap <silent> <C-A-o> :silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" coc-translator
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

" coc-explorer
nmap <C-\> <Cmd>CocCommand explorer<CR>

" =====Nerdcommenter=====

let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
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

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" =====vista=====

let g:vista_echo_cursor = 0
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = '50'
let g:vista_disable_statusline = 1
nnoremap <F2> :Vista!!<CR>

" =====vim-sneak=====

map \ <Plug>Sneak_;

" =====vim-easy-align=====

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" =====vim-floaterm=====

let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
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

" =====telescope=====

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fm <cmd>Telescope coc mru<cr>
nnoremap <leader>fc <cmd>Telescope grep_string initial_mode=normal<cr>
vnoremap <silent> <leader>fc :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

nmap <silent>gr <cmd>Telescope coc references initial_mode=normal<cr>
nmap <silent>gi <cmd>Telescope coc implementations initial_mode=normal<cr>

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
  execute 'Telescope grep_string search=' . word
endfunction

" =====bufferline=====

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" =====copilot.vim=====

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" =====wilder.nvim=====

call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
  \ wilder#branch(
  \   wilder#check({ctx, x -> empty(x)}),
  \   wilder#substitute_pipeline({
  \     'pipeline': wilder#python_search_pipeline({
  \       'skip_cmdtype_check': 1,
  \       'pattern': wilder#python_fuzzy_pattern({
  \         'start_at_boundary': 0,
  \       }),
  \     }),
  \   }),
  \   wilder#cmdline_pipeline({
  \     'fuzzy': 1,
  \     'set_pcre2_pattern': 1,
  \   }),
  \   wilder#python_search_pipeline({
  \     'pattern': wilder#python_fuzzy_pattern({
  \       'start_at_boundary': 0,
  \     }),
  \   }),
  \ ),
\ ])

let s:highlighters = [
  \ wilder#pcre2_highlighter(),
\ ]

let s:popupmenu_renderer = wilder#popupmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \ },
  \ 'highlighter': s:highlighters,
  \ 'left': [
  \   ' ',
  \   wilder#popupmenu_devicons(),
  \ ],
  \ 'right': [
  \   ' ',
  \   wilder#popupmenu_scrollbar(),
  \ ],
\ })

let s:wildmenu_renderer = wilder#wildmenu_renderer({
  \ 'highlights': {
  \    'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
  \  },
  \ 'highlighter': s:highlighters,
\ })

call wilder#set_option('renderer', wilder#renderer_mux({
  \ ':': s:popupmenu_renderer,
  \ '/': s:wildmenu_renderer,
  \ 'substitute': s:wildmenu_renderer,
\ }))

cnoremap <expr> / wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"

lua << EOF
require("core")
EOF

" =====主题=====

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

highlight link Operator GruvboxRed
highlight link TelescopeSelection SignColumn
highlight link TelescopePreviewLine SignColumn
highlight CocExplorerFileDirectoryExpanded guifg=#8094b4
highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4
" highlight link VistaTag Normal
