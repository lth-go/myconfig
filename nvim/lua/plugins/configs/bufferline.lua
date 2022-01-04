local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

local old_nvim_buffline = _G.nvim_bufferline

function _G.nvim_bufferline()
  local tabline = old_nvim_buffline()
  local number = 1
  local count

  while true do
    tabline, count = tabline:gsub("Ω", number, 1)
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
    offsets = { { filetype = "coc-explorer", text = "" } },
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
  highlights = {
    indicator_selected = {
      guifg = "#519aba",
      guibg = "#1d2021",
    },
  },
})
