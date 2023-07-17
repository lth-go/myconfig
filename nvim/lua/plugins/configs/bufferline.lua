local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

local superscript_numbers = {
  ["0"] = "⁰",
  ["1"] = "¹",
  ["2"] = "²",
  ["3"] = "³",
  ["4"] = "⁴",
  ["5"] = "⁵",
  ["6"] = "⁶",
  ["7"] = "⁷",
  ["8"] = "⁸",
  ["9"] = "⁹",
}

--- convert single or multi-digit strings to {sub|super}script
--- or return the plain number if there is no corresponding number table
---@param num number
---@param map table<string, string>?
---@return string
local function construct_number(num, map)
  if not map then
    return num .. "."
  end
  local str = tostring(num)
  local match = str:gsub(".", function(c)
    return map[c] or ""
  end)
  return match
end

local function to_style(map)
  return function(num)
    return construct_number(num, map)
  end
end

local raise = to_style(superscript_numbers)

local old_nvim_buffline = _G.nvim_bufferline

function _G.nvim_bufferline()
  local tabline = old_nvim_buffline()
  local number = 1
  local count

  while true do
    tabline, count = tabline:gsub("Ω", string.format("%s", raise(number)), 1)
    number = number + 1
    if count == 0 then
      break
    end
  end

  return tabline
end

bufferline.setup({
  options = {
    numbers = function(opts)
      return "Ω"
    end,
    -- indicator = {
    --   style = "underline",
    -- },
    offsets = {
      { filetype = "coc-explorer", text = "" },
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slope",
  },
  highlights = {
    indicator_selected = {
      fg = "#519aba",
      bg = "#1d2021",
      -- sp = "#FF80A0",
      -- bold = true,
      -- underdouble = true,
      -- underline = true,
    },
  },
})
