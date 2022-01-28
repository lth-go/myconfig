local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.gruvbox_italics = 0

cmd([[colorscheme gruvbox8_hard]])

cmd([[highlight CocExplorerFileDirectoryExpanded guifg=#8094b4]])
cmd([[highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4]])
cmd([[highlight link Sneak Search]])
