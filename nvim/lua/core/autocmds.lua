local vim = vim
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.dockerfile",
  callback = function()
    vim.opt_local.filetype = "dockerfile"
  end,
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*/.kube/config",
  callback = function()
    vim.opt_local.filetype = "yaml"
  end,
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function()
    if vim.opt_local.number:get() then
      vim.opt_local.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    if vim.opt_local.number:get() then
      vim.opt_local.relativenumber = false
    end
  end,
})

autocmd({ "BufReadPost" }, {
  pattern = "*",
  callback = function()
    local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
    local test_line = test_line_data[1]
    local last_line = vim.api.nvim_buf_line_count(0)

    if test_line > 0 and test_line <= last_line then
      vim.api.nvim_win_set_cursor(0, test_line_data)
    end
  end,
})

autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require("core.utils").auto_mkdir()
  end,
})

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

autocmd("StdinReadPost", {
  pattern = "*",
  callback = function()
    vim.opt.modified = false
  end,
})
