local fn = vim.fn

local M = {}

local function get_selected_text()
  local lines = fn.getregion(fn.getpos("."), fn.getpos("v"), { type = fn.mode(1) })

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("\\", "\\\\")
  end

  return table.concat(lines, "\\n")
end

local function set_search(pattern)
  fn.setreg("/", pattern)
  fn.histadd("/", pattern)
  vim.v.hlsearch = 1
end

function M.run()
  local mode = fn.mode(1)

  local pattern

  if mode:match("[vV]") then
    local text = get_selected_text()

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)

    if text == "" then
      return
    end

    pattern = "\\V" .. text
  else
    local text = fn.escape(fn.expand("<cword>"), [[\]])
    if text == "" then
      return
    end

    if vim.fn.match(text, "^\\k\\+$") >= 0 then
      pattern = "\\<" .. text .. "\\>"
    else
      pattern = "\\V" .. text
    end
  end

  set_search(pattern)
end

return M
