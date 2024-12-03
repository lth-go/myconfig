return {
  "preservim/nerdcommenter",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings = require("astrocore").extend_tbl(opts.mappings, {
          [""] = {
            ["<C-_>"] = [[<Plug>NERDCommenterToggle]],
          },
        })

        return opts
      end,
    },
  },
  init = function()
    vim.g.NERDCreateDefaultMappings = 0
    vim.g.NERDDefaultAlign = "left"
    vim.g.NERDSpaceDelims = 1
  end,
}
