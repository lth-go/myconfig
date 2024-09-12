local vim = vim
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "[dD]ockerfile_*",
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

--
-- 自动行号
--
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

--
-- 打开文件定位到上次访问
--
autocmd({ "BufReadPost" }, {
  pattern = "*",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf

    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf]._last_loc then
      return
    end
    vim.b[buf]._last_loc = true

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--
-- 自动创建目录
--
autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end

    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd({ "FileType" }, {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd({ "BufUnload" }, {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

autocmd({ "StdinReadPost" }, {
  pattern = "*",
  callback = function()
    vim.opt.modified = false
    vim.opt.mouse = "a"
  end,
})
