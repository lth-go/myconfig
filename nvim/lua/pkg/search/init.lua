local Search = require("pkg.search.search")
local UI = require("pkg.search.ui")

local function buf_is_valid(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
    return false
  end

  if vim.api.nvim_get_option_value("bufhidden", { buf = bufnr }) ~= "" then
    return false
  end

  return true
end

local M = {}

M.search = function()
  if not buf_is_valid(vim.api.nvim_get_current_buf()) then
    vim.api.nvim_feedkeys("/", "n", false)
    return
  end

  local ui = UI.new(Search.new())
  ui:mount()
end

return M
