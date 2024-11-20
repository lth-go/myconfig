return {
  "stevearc/conform.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.mappings = require("astrocore").extend_tbl(opts.mappings, {
        n = {
          ["<C-A-L>"] = {
            function()
              vim.cmd.Format()
            end,
          },
        },
        x = {
          ["<C-A-L>"] = {
            function()
              vim.cmd.Format()
            end,
          },
        },
      })
    end,
  },
  opts = {
    format_on_save = false,
    formatters_by_ft = {
      lua = { "stylua" },
      go = {
        "gofumpt",
        "goimports",
        "goimports-reviser",
      },
      xml = { "xmlformatter" },
    },
    formatters = {
      ["goimports-reviser"] = {
        prepend_args = { "-imports-order", "std,project,company,general", "-project-name", "None", "-company-prefixes", "sc_,common" },
      },
    },
  },
}
