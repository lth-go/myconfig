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

require('bufferline').setup{
  options = {
    numbers = function(opts)
      return string.format('%s.', opts.ordinal)
    end,
    offsets = {{filetype = "coc-explorer", text = "coc-explorer"}},
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
