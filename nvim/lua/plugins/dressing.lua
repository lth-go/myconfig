return {
  "stevearc/dressing.nvim",
  opts = function()
    return {
      input = {
        mappings = {
          i = {
            ["<Esc>"] = "Close",
          },
        },
      },
    }
  end,
}
