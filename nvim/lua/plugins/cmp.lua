return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local compare = require("cmp.config.compare")

    opts.mapping = require("astrocore").extend_tbl(opts.mapping, {
      ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
      ["<C-D>"] = cmp.mapping(function(fallback)
        cmp.close()

        if not cmp.complete() then
          fallback()
        end
      end, { "i" }),
    })

    opts.mapping["<C-K>"] = nil
    opts.mapping["<C-J>"] = nil

    opts.sorting = {
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.sort_text,
        compare.recently_used,
        compare.locality,
        compare.kind,
        compare.length,
        compare.order,
      },
    }
  end,
}
