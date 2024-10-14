return {
  "stevearc/aerial.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<F2>"] = {
          function()
            require("aerial").toggle()
          end,
        }
      end,
    },
  },
}
