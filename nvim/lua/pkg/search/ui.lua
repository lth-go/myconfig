--- @class UI
--- @field search Search
local UI = {}
UI.__index = UI

--- @param search Search
--- @return UI
function UI.new(search)
  return setmetatable({ search = search }, UI)
end

--- @return table
function UI:popup_options()
  return {
    relative = "editor",
    position = {
      row = "100%",
      col = "0%",
    },
    size = "100%",
    border = {
      style = "none",
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:Normal,CurSearch:Normal",
    },
  }
end

--- @return table
function UI:input_options()
  local s = self.search
  return {
    prompt = " ",
    default_value = "",
    on_change = function(v)
      s:on_change(v)
    end,
    on_close = function()
      s:on_close()
    end,
    on_submit = function(v)
      s:on_submit(v)
    end,
  }
end

--- Mount the input window and wire up mappings + autocmds.
function UI:mount()
  local nui_input = require("nui.input")
  local nui_event = require("nui.utils.autocmd").event

  local input = nui_input(self:popup_options(), self:input_options())

  input:mount()

  self:_apply_mappings(input)

  input:on(nui_event.BufLeave, function()
    input:unmount()
  end)
end

--- @param input table  nui.input instance
function UI:_apply_mappings(input)
  local bind = function(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { buffer = input.bufnr })
  end

  bind({ "i" }, "<C-c>", input.input_props.on_close)
  bind({ "i" }, "<Esc>", input.input_props.on_close)
  bind({ "i" }, "<C-p>", "<Nop>")
  bind({ "i" }, "<C-n>", "<Nop>")
  bind({ "i" }, "<C-j>", "<Nop>")
  bind({ "i" }, "<C-k>", "<Nop>")
end

return UI
