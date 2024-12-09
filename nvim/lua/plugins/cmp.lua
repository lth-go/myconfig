return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-nvim-lsp-signature-help" },
  opts = function(_, opts)
    require("pkg/cmp-json")

    local cmp = require("cmp")

    vim.list_extend(opts.sources, {
      { name = "nvim_lsp_signature_help", priority = 1500 },
      { name = "cmp-json", priority = 2000 },
    })

    local maps = {
      ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
      ["<C-D>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
    }

    opts.mapping = require("astrocore").extend_tbl(opts.mapping, maps)

    opts.mapping["<C-K>"] = nil
    opts.mapping["<C-J>"] = nil
  end,
}
