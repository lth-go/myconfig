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
        ["<C-l>"] = false,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
      },
    },
    file_ignore_patterns = { "vendor/.*", "tools/.*" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
    },
    sorting_strategy = "ascending",
    path_display = { "truncate" },
  },
})

--
-- telescope-coc.nvim
--

require("telescope").load_extension("coc")
