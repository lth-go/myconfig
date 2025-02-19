return {
  "stevearc/conform.nvim",
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings

      for _, mode in ipairs({ "n", "x" }) do
        maps[mode]["<C-A-L>"] = {
          function()
            vim.cmd.Format()
          end,
        }
      end
    end,
  },
  opts = {
    format_on_save = false,
    formatters_by_ft = {
      go = {
        "gofumpt",
        "goimports-reviser",
      },
      lua = { "stylua" },
      sql = { "sql_formatter" },
      xml = { "xmlformatter" },
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
