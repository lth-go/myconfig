local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.gruvbox_italics = 0

cmd([[colorscheme gruvbox8_hard]])

cmd([[highlight CocExplorerFileDirectoryExpanded  guifg=#8094b4]])
cmd([[highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4]])
cmd([[highlight! link QuickFixLine CursorLine]])

cmd([[highlight StartLogo1 guifg=#1C506B]])
cmd([[highlight StartLogo2 guifg=#1D5D68]])
cmd([[highlight StartLogo3 guifg=#1E6965]])
cmd([[highlight StartLogo4 guifg=#1F7562]])
cmd([[highlight StartLogo5 guifg=#21825F]])
cmd([[highlight StartLogo6 guifg=#228E5C]])
cmd([[highlight StartLogo7 guifg=#239B59]])
cmd([[highlight StartLogo8 guifg=#24A755]])

cmd([[highlight clear DiffAdd]])
cmd([[highlight clear DiffChange]])
cmd([[highlight clear DiffDelete]])
cmd([[highlight clear DiffText]])
cmd([[highlight DiffAdd    ctermfg=234     ctermbg=114 guibg=#26332c guifg=NONE]])
cmd([[highlight DiffChange cterm=underline ctermfg=180 guibg=#273842 guifg=NONE]])
cmd([[highlight DiffDelete ctermfg=234     ctermbg=168 guibg=#572E33 guifg=#572E33]])
cmd([[highlight DiffText   ctermfg=234     ctermbg=180 guibg=#314753 guifg=NONE]])

cmd([[highlight SpectreSearch  cterm=reverse ctermfg=107 ctermbg=234 gui=reverse guifg=#8ec07c guibg=#1d2021]])
cmd([[highlight SpectreReplace cterm=reverse ctermfg=203 ctermbg=234 gui=reverse guifg=#fb4934 guibg=#1d2021]])
