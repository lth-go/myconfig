local g = vim.g
local opt = vim.opt

g.gruvbox_italics = 0

vim.cmd([[colorscheme gruvbox8_hard]])

vim.cmd([[highlight link TelescopeSelection SignColumn]])
vim.cmd([[highlight link TelescopePreviewLine SignColumn]])
vim.cmd([[highlight CocExplorerFileDirectoryExpanded guifg=#8094b4]])
vim.cmd([[highlight CocExplorerFileDirectoryCollapsed guifg=#8094b4]])
