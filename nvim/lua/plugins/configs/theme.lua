local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.gruvbox_italics = 0

cmd([[colorscheme gruvbox8_hard]])

cmd([[highlight CocExplorerFileDirectoryExpanded guifg=#8094b4]])
cmd([[highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4]])
cmd([[highlight link Sneak Search]])

cmd([[highlight StartLogo1  guifg=#1C506B]])
cmd([[highlight StartLogo2  guifg=#1D5D68]])
cmd([[highlight StartLogo3  guifg=#1E6965]])
cmd([[highlight StartLogo4  guifg=#1F7562]])
cmd([[highlight StartLogo5  guifg=#21825F]])
cmd([[highlight StartLogo6  guifg=#228E5C]])
cmd([[highlight StartLogo7  guifg=#239B59]])
cmd([[highlight StartLogo8  guifg=#24A755]])
