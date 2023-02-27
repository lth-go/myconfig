local vim = vim
local api = vim.api
local keymap_set = vim.keymap.set
local opt_local = vim.opt_local

opt_local.expandtab = false

local function_jump = function(direction)
  return function()
    local result = vim.fn["go#textobj#FunctionLocation"](direction, 0)

    if not result then
      return
    end

    if result == 0 then
      return
    end

    if result.err then
      return
    end

    local info = result.fn
    if not info then
      return
    end

    api.nvim_win_set_cursor(0, { info.func.line, info.sig.name_pos.col - 1 })
  end
end

keymap_set("n", "]]", function_jump("next"), { noremap = true, silent = true })
keymap_set("n", "[[", function_jump("prev"), { noremap = true, silent = true })
