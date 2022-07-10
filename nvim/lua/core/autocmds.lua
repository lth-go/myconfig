local vim = vim
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

cmd([[ autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=dockerfile ]])

cmd([[ autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif ]])
cmd([[ autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif ]])

cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif ]])

cmd([[ autocmd BufWritePre * lua require('core.utils').auto_mkdir() ]])

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Disable statusline in dashboard
autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt.laststatus = 0
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})
