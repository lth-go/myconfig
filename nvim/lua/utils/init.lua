local vim = vim

local M = {}

M.get_visual_selection = function()
  local save_a = vim.fn.getreginfo("a")
  vim.cmd([[norm! "ay]])
  local selection = vim.fn.getreg("a", 1)
  vim.fn.setreg("a", save_a)
  return selection
end

return M
