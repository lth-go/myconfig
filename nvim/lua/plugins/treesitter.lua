---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true,
      disable = { "dockerfile" },
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
