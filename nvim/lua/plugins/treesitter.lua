---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true,
      disable = { "dockerfile" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-s>",
        node_incremental = "<C-s>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      move = {
        goto_next_start = {
          ["]]"] = "@local.name",
        },
        goto_previous_start = {
          ["[["] = "@local.name",
        },
      },
    },
  },
}
