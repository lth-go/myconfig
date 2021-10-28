--
-- nvim-treesitter
--

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

--
-- nvim-bufferline.lua
--

local bufferline_utils = require("bufferline.utils")
function bufferline_utils.is_test()
  return true
end

local bufferline = require('bufferline')

bufferline.setup{
  options = {
    numbers = function(opts)
      local index
      for i, buf in ipairs(bufferline._state.visible_components) do
        if buf.id == opts.id then
          index = i
          break
        end
      end

      if not index then
        return string.format('%s.', opts.ordinal)
      end

      return string.format('%s.', index)
    end,
    offsets = {{ filetype = "coc-explorer", text = "" }},
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
  }
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

require('nvim-autopairs').setup()
