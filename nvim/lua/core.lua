--
-- nvim-treesitter
--

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}

--
-- nvim-bufferline.lua
--

local bufferline = require('bufferline')

local old_nvim_buffline = _G.nvim_bufferline

function _G.nvim_bufferline()
  local tabline = old_nvim_buffline()
  local number = 1
  local count

  while (true) do
    tabline, count = tabline:gsub("Ω", number, 1)
    number = number + 1
    if count == 0 then
      break
    end
  end

  return tabline
end

bufferline.setup{
  options = {
    numbers = function(opts)
      return "Ω"
    end,
    offsets = {{ filetype = "coc-explorer", text = "" }},
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
  highlights = {
    indicator_selected = {
      guifg= "#519aba",
      guibg="#1d2021",
    },
  },
}

--
-- feline.nvim
--

require('plugins/configs/statusline')

--
-- telescope
--

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
      },
    },
    file_ignore_patterns = { "vendor/.*" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    oldfiles = {
      include_current_session = true,
      cwd_only = true,
    },
  },
}

--
-- telescope-coc.nvim
--

require('telescope').load_extension('coc')

--
-- nvim-autopairs
--

require('nvim-autopairs').setup({
  map_cr = false,
})
