local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
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
    file_ignore_patterns = { "vendor/.*" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    sorting_strategy = "ascending",
    path_display = { "truncate" },
  },
})

--
-- extension
--

telescope.load_extension("coc")
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
