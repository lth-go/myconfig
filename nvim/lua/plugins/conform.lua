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
      http = { "kulala-fmt" },
      lua = { "stylua" },
      sql = { "sql_formatter" },
      xml = { "xmlformatter" },
      yaml = { "prettierd" },
    },
    formatters = {
      ["goimports-reviser"] = {
        prepend_args = function(_, _)
          local goimports_reviser = require("pkg.settings").get("go.goimports_reviser")
          if goimports_reviser == nil then
            return nil
          end

          return {
            "-imports-order",
            "std,project,company,general",
            "-project-name",
            "None",
            "-company-prefixes",
            table.concat(goimports_reviser.company_prefixes, ","),
          }
        end,
      },
    },
  },
}
