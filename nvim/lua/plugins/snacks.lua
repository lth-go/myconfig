return {
  "folke/snacks.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>ff"] = {
          function()
            require("snacks").picker.files({
              cmd = "rg",
            })
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

        --
        --
        --

        local commands = opts.commands

        commands["SnacksNotifierShowHistory"] = {
          function()
            require("snacks").notifier.show_history()
          end,
        }

        commands["SnacksPicker"] = {
          function()
            require("snacks").picker()
          end,
        }
      end,
    },
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local maps = opts.mappings

        local lsp_format = function(item, picker)
          local pos_bak = item.pos
          local line_bak = item.line

          item._path = require("pkg.settings").path_display(item.file)
          item.pos = item.pos and { item.pos[1], 0 }
          item.line = nil

          local result = require("snacks").picker.format.file(item, picker)

          item._path = item.file
          item.pos = pos_bak
          item.line = line_bak

          return result
        end

        maps.n["<Leader>g"] = {
          function()
            require("snacks").picker.lsp_definitions({
              format = lsp_format,
              unique_lines = true,
              jump = { reuse_win = false },
            })
          end,
        }

        maps.n["gy"] = {
          function()
            require("snacks").picker.lsp_type_definitions({
              format = lsp_format,
            })
          end,
        }

        maps.n["gr"] = {
          function()
            require("snacks").picker.lsp_references({
              include_declaration = false,
              include_current = true,
              auto_confirm = false,
              format = lsp_format,
            })
          end,
        }

        maps.n["gi"] = {
          function()
            require("snacks").picker.lsp_implementations({
              format = lsp_format,
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
        { pane = 2, width = 42, text = { require("pkg.utils").exec("lunar 2>/dev/null"), hl = "SnacksDashboardFooter", align = "center" } },
      },
    }

    opts.indent = {
      enabled = false,
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
