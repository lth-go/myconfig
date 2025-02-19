return {
  "folke/snacks.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>ff"] = {
          function()
            require("snacks").picker.files({})
          end,
        }

        maps.n["<Leader>fg"] = {
          function()
            require("snacks").picker.grep()
          end,
        }

        for _, mode in ipairs({ "n", "x" }) do
          maps[mode]["<Leader>fc"] = {
            function()
              require("snacks").picker.grep_word()
            end,
          }
        end

        local format = function(item, picker)
          item.file = require("pkg.settings").path_display(item.file)
          item.line = nil
          return require("snacks").picker.format.file(item, picker)
        end

        maps.n["<Leader>g"] = {
          function()
            require("snacks").picker.lsp_definitions({
              format = format,
            })
          end,
        }

        maps.n["gy"] = {
          function()
            require("snacks").picker.lsp_type_definitions({
              format = format,
            })
          end,
        }

        maps.n["gr"] = {
          function()
            require("snacks").picker.lsp_references({
              include_declaration = false,
              include_current = true,
              auto_confirm = false,
              format = format,
            })
          end,
        }

        maps.n["gi"] = {
          function()
            require("snacks").picker.lsp_implementations({
              format = format,
            })
          end,
        }
      end,
    },
  },
  opts = function(_, opts)
    opts.styles = {
      input = {
        width = 40,
        relative = "cursor",
        row = -3,
        col = 0,
        keys = {
          i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
        },
      },
    }

    opts.dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "r", desc = "Recent Files", action = "<Leader>fm" },
          { icon = " ", key = "f", desc = "Find File", action = "<Leader>ff" },
          { icon = " ", key = "g", desc = "Find Text", action = "<Leader>fg" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        { pane = 2, width = 42, text = { require("pkg.utils.os").exec("lunar 2>/dev/null"), hl = "SnacksDashboardFooter", align = "center" } },
      },
    }

    opts.input = {
      icon = "",
    }

    opts.notifier = {
      style = "fancy",
    }

    opts.picker = {
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    }

    return opts
  end,
}
