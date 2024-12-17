return {
  "stevearc/conform.nvim",
  specs = {
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
      sql = { "sql_formatter" },
    },
    formatters = {
      ["goimports-reviser"] = {
        prepend_args = function(_, _)
          local settings = require("pkg.settings").load()
          if settings == nil or settings.go == nil or settings.go.goimports_reviser == nil then
            return nil
          end

          return {
            "-imports-order",
            "std,project,company,general",
            "-project-name",
            "None",
            "-company-prefixes",
            table.concat(settings.go.goimports_reviser.company_prefixes, ","),
          }
        end,
      },
    },
  },
}
