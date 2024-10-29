return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    local maps = {
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-D>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
    }

    opts.mapping = require("astrocore").extend_tbl(opts.mapping, maps)

    opts.mapping["<C-K>"] = nil
    opts.mapping["<C-J>"] = nil
  end,
}
