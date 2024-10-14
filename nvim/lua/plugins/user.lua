---@type LazySpec
return {
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "mrjones2014/smart-splits.nvim", enabled = false },
  { "s1n7ax/nvim-window-picker", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },

  {
    "sainnhe/gruvbox-material",
    dependencies = {
      "AstroNvim/astroui",
      opts = function()
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_better_performance = 0
        vim.g.gruvbox_material_disable_italic_comment = 1
      end,
    },
  },

  {
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
    config = function()
      local wilder = require("wilder")

      wilder.setup({
        modes = { ":" },
      })

      wilder.set_option({
        pipeline = {
          wilder.branch(
            wilder.check(function(_, x)
              return x == ""
            end),
            wilder.cmdline_pipeline({
              fuzzy = 1,
              sorter = wilder.python_difflib_sorter(),
            })
          ),
        },
        renderer = wilder.renderer_mux({
          [":"] = wilder.popupmenu_renderer({
            highlights = {
              accent = wilder.make_hl("WilderAccent", "Pmenu", { {}, {}, { "#f4468f" } }),
            },
            highlighter = {
              wilder.highlighter_with_gradient({
                wilder.basic_highlighter(),
              }),
            },
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
          }),
        }),
      })

      vim.api.nvim_set_keymap("c", "/", [[wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"]], { expr = true, noremap = true })
    end,
  },

  { "tpope/vim-fugitive" },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    config = function()
      local treesj = require("treesj")

      treesj.setup({
        use_default_keymaps = false,
      })

      vim.keymap.set("n", "gJ", treesj.join)
      vim.keymap.set("n", "gS", treesj.split)
    end,
  },

  { "tpope/vim-abolish" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  {
    "junegunn/vim-easy-align",
    init = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {})
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {})
    end,
  },

  {
    "terryma/vim-expand-region",
    init = function()
      local g = vim.g

      -- 选中区域配置, 1表示递归
      g.expand_region_text_objects = {
        ["iw"] = 0,
        ['i"'] = 1,
        ["i'"] = 1,
        ["i`"] = 1,
        ["i)"] = 1,
        ["i]"] = 1,
        ["i}"] = 1,
        ["it"] = 1,
        ["a)"] = 1,
        ["a]"] = 1,
        ["a}"] = 1,
        ["at"] = 1,
      }

      vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", {})
      vim.keymap.set("v", "V", "<Plug>(expand_region_shrink)", {})
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")

      vim.keymap.set({ "n" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n" }, "S", "<Plug>(leap-backward)")

      leap.setup({
        max_phase_one_targets = 0,
        safe_labels = {},
        on_beacons = function(targets, start, end_)
          for i = start or 1, end_ or #targets do
            local target = targets[i]
            local beacon = target.beacon

            if type(beacon) == "table" and beacon[1] ~= nil and beacon[2] ~= nil then
              local virttexts = beacon[2]

              for _, virttext in ipairs(virttexts) do
                virttext[1] = virttext[1]:gsub("%s+$", "")
              end
            end
          end

          return true
        end,
      })
    end,
  },

  {
    "chaoren/vim-wordmotion",
    init = function()
      vim.g.wordmotion_mappings = {
        ["w"] = "<M-w>",
        ["b"] = "<M-b>",
        ["e"] = "<M-e>",
        ["ge"] = "g<M-e>",
        ["aw"] = "a<M-w>",
        ["iw"] = "i<M-w>",
        ["<C-R><C-W>"] = "<C-R><M-w>",
      }
    end,
  },

  {
    "haya14busa/vim-asterisk",
    config = function()
      vim.api.nvim_set_keymap("", "*", [[<Plug>(asterisk-z*)]], {})
    end,
  },

  {
    "windwp/nvim-spectre",
    lazy = true,
    keys = { "<Leader>sr" },
    config = function()
      local spectre = require("spectre")

      spectre.setup({
        highlight = {
          ui = "String",
          search = "SpectreSearch",
          replace = "SpectreReplace",
        },
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix",
          },
        },
      })

      vim.keymap.set("n", "<Leader>sr", spectre.open, { noremap = true })
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").setup({
        preview = {
          auto_preview = false,
        },
      })
    end,
  },

  {
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    config = function()
      require("pqf").setup({})
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    init = function()
      local binary = require("supermaven-nvim.binary.binary_handler")

      local old_on_update = binary.on_update

      local include_filetypes = {
        "bash",
        "go",
        "gomod",
        "json",
        "lua",
        "make",
        "proto",
        "python",
        "rust",
        "sh",
        "sql",
        "toml",
        "yaml",
      }

      binary.on_update = function(self, buffer, file_name, event_type)
        if not vim.tbl_contains(include_filetypes, vim.bo.filetype) then
          return
        end

        old_on_update(self, buffer, file_name, event_type)
      end
    end,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-j>",
          clear_suggestion = "<C-]>",
          accept_word = "<A-j>",
        },
        ignore_filetypes = {},
        color = {
          suggestion_color = "#928374",
          cterm = 245,
        },
        log_level = "error",
        disable_inline_completion = false,
        disable_keymaps = false,
      })
    end,
  },

  {
    "lth-go/searchx.nvim",
    config = function()
      vim.keymap.set("n", "/", ":Searchx<CR>", { silent = true })
    end,
  },

  {
    "lth-go/vim-translator",
    config = function()
      local g = vim.g

      g.translator_default_engines = { "google" }
      g.translator_proxy_url = "http://192.168.56.1:7890"

      vim.keymap.set("n", "<Leader>t", [[<Plug>TranslateW]], { silent = true })
      vim.keymap.set("v", "<Leader>t", [[<Plug>TranslateWV]], { silent = true })
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "static",
      })
    end,
  },

  {
    "folke/noice.nvim",
    init = function()
      local formatters = require("noice.text.format.formatters")

      function formatters.search_count(message, opts, input)
        local content = input:content()

        local v = content:match(".*(%[%d+/%d+%])$")
        if v then
          content = v
        end

        message:append(content)
      end
    end,
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = false,
          lua = false,
          help = false,
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
      },
      views = {
        virtualtext = {
          format = { "{search_count}" },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "lines yanked" },
              { find = "more lines" },
              { find = "fewer lines" },
              { find = "E486: Pattern not found" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = [[^\<.*\>$]] },
              { find = [[^\V.*]] },
              { find = "Already at newest change" },
            },
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },

  {
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
      },
      formatters = {
        ["goimports-reviser"] = {
          prepend_args = { "-imports-order", "std,project,company,general", "-project-name", "None", "-company-prefixes", "sc_,common" },
        },
      },
    },
  },
}
