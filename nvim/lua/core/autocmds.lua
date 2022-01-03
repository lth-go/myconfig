vim.cmd([[ autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=dockerfile ]])

vim.cmd([[ autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif ]])
vim.cmd([[ autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif ]])

vim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif ]])

vim.cmd([[ autocmd BufWritePre * lua require('core.utils').auto_mkdir() ]])
