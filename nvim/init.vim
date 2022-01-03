call plug#begin('~/.local/share/nvim/plugged')

" =====插件=====

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go'
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
Plug 'voldikss/vim-floaterm'
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

lua require("core.options")

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

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" outline
nnoremap <F2> :CocOutline<CR>

nnoremap <silent> <Space>gf :call CocActionAsync('codeAction', 'cursor', ['refactor.rewrite'])<CR>

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

imap <silent><script><expr> <C-J> copilot#Accept("")
let g:copilot_no_tab_map = v:true

" =====wilder.nvim=====

call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
  \ wilder#branch(
  \   {ctx, x -> empty(x) ? '' : v:false},
  \   {ctx, x -> index(['e', 'v', 'vs'], x) >= 0 ? '' : v:false},
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
  \     'sorter': wilder#python_difflib_sorter(),
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
  \ 'apply_incsearch_fix': 1,
\ })

call wilder#set_option('renderer', wilder#renderer_mux({
  \ ':': s:popupmenu_renderer,
  \ '/': s:wildmenu_renderer,
  \ 'substitute': s:wildmenu_renderer,
\ }))

cnoremap <expr> / wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"

" =====vim-go=====

let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_template_autocreate = 0

lua require("core.autocmds")
lua require("core.mappings").misc()
lua require("plugins.init")

" =====主题=====

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

highlight link Operator GruvboxRed
highlight link TelescopeSelection SignColumn
highlight link TelescopePreviewLine SignColumn
highlight CocExplorerFileDirectoryExpanded guifg=#8094b4
highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4
