local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
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
    sorting_strategy = "ascending",
  },
  pickers = {
    oldfiles = {
      include_current_session = true,
      cwd_only = true,
    },
  },
})

--
-- telescope-coc.nvim
--

require("telescope").load_extension("coc")
