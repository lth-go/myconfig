local cmd = vim.cmd

cmd([[ autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=dockerfile ]])

cmd([[ autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif ]])
cmd([[ autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif ]])

cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif ]])

cmd([[ autocmd BufWritePre * lua require('core.utils').auto_mkdir() ]])
