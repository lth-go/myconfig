local M = {}

function M.buf_filter(bufnr)
  if not require("astrocore.buffer").is_restorable(bufnr) then
    return false
  end

  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  local dir = vim.fn.getcwd(-1, -1)

  dir = dir:sub(-1) ~= "/" and dir .. "/" or dir

  if not vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir) then
    return false
  end

  return true
end

---@param opts resession.Extension.OnSaveOpts
function M.on_save(opts)
  -- initiate astronvim data
  local data = { bufnrs = {}, tabs = {} }
  local bufs = {}

  -- save tab scoped buffers and buffer numbers from buffer name
  for new_tabpage, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    if tabpage == opts.tabpage then
      data.tabpage = new_tabpage
    end

    data.tabs[new_tabpage] = {}

    for _, bufnr in ipairs(vim.t[tabpage].bufs) do
      if M.buf_filter(bufnr) then
        table.insert(data.tabs[new_tabpage], bufnr)
      end
    end

    for _, bufnr in ipairs(data.tabs[new_tabpage]) do
      data.bufnrs[vim.api.nvim_buf_get_name(bufnr)] = bufnr

      table.insert(bufs, bufnr)
    end
  end

  if #bufs > 0 then
    local buf_utils = require("astrocore.buffer")
    data.current_buf = buf_utils.current_buf

    if not vim.tbl_contains(bufs, data.current_buf) then
      data.current_buf = bufs[#bufs]
    end
  end

  return data
end

function M.on_post_load(data)
  -- create map from old buffer numbers to new buffer numbers
  local new_bufnrs = {}
  local new_tabpages = vim.api.nvim_list_tabpages()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local old_bufnr = data.bufnrs[vim.api.nvim_buf_get_name(bufnr)]
    if old_bufnr then
      new_bufnrs[old_bufnr] = bufnr
    end
  end

  local last_buf

  -- build new tab scoped buffer lists
  if not data.tabpage then
    for tabpage, tabs in pairs(data.tabs) do
      local bufs = {}

      for _, bufnr in ipairs(tabs) do
        local new_bufnr = new_bufnrs[bufnr]
        if new_bufnr and M.buf_filter(bufnr) then
          table.insert(bufs, new_bufnr)

          last_buf = new_bufnr
        end
      end

      vim.t[new_tabpages[tabpage]].bufs = bufs
    end
  else
    local bufs = {}

    for _, bufnr in ipairs(data.tabs[data.tabpage]) do
      local new_bufnr = new_bufnrs[bufnr]
      if new_bufnr and M.buf_filter(bufnr) then
        table.insert(bufs, new_bufnr)

        last_buf = new_bufnr
      end
    end

    vim.t.bufs = bufs
  end

  local current_buf = new_bufnrs[data.current_buf]

  if current_buf then
    if not M.buf_filter(current_buf) then
      current_buf = last_buf
    end
  end

  if current_buf then
    local buf_utils = require("astrocore.buffer")
    buf_utils.current_buf = current_buf

    if vim.opt.bufhidden:get() == "wipe" and vim.fn.bufnr() ~= current_buf then
      vim.cmd.b(current_buf)
    end
  end
end

return M
