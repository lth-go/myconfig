local M = {}

M.buf_delete_other = function()
  local current_buf_map = {}

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    current_buf_map[vim.api.nvim_win_get_buf(win)] = true
  end

  local ok = function(bufnr)
    if current_buf_map[bufnr] then
      return false
    end

    if not vim.api.nvim_buf_is_valid(bufnr) then
      return false
    end

    if vim.bo[bufnr].buftype ~= "" then
      return false
    end

    if vim.bo[bufnr].bufhidden ~= "" then
      return false
    end

    if not vim.bo[bufnr].buflisted then
      return false
    end

    if vim.bo[bufnr].modified then
      return false
    end

    return true
  end

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if ok(bufnr) then
      require("astrocore.buffer").close(bufnr, false)
    end
  end
end

return M
