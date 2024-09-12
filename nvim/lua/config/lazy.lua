local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },

    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        local g = vim.g
        local cmd = vim.cmd
        local nvim_set_hl = vim.api.nvim_set_hl

        g.gruvbox_material_background = "hard"
        g.gruvbox_material_foreground = "original"
        g.gruvbox_material_better_performance = 0
        g.gruvbox_material_disable_italic_comment = 1

        cmd.colorscheme("gruvbox-material")

        nvim_set_hl(0, "CocExplorerFileDirectoryExpanded", { fg = "#8094b4" })
        nvim_set_hl(0, "CocExplorerFileDirectoryCollapsed", { fg = "#8094b4" })

        nvim_set_hl(0, "SpectreSearch", { reverse = true, ctermfg = 107, ctermbg = 234, fg = "#8ec07c", bg = "#1d2021" })
        nvim_set_hl(0, "SpectreReplace", { reverse = true, ctermfg = 203, ctermbg = 234, fg = "#fb4934", bg = "#1d2021" })
      end,
    },

    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
      config = function()
        require("nvim-web-devicons").setup({
          override_by_filename = {
            ["go.mod"] = {
              icon = "",
              color = "#519aba",
              cterm_color = "74",
              name = "GoMod",
            },
            ["go.sum"] = {
              icon = "",
              color = "#519aba",
              cterm_color = "74",
              name = "GoSum",
            },
          },
        })
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "bash",
            "c",
            "comment",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "groovy",
            "html",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "luau",
            "make",
            "markdown",
            "markdown_inline",
            "proto",
            "python",
            "query",
            "rust",
            "sql",
            "toml",
            "tsx",
            "vim",
            "vimdoc",
            "yaml",
          },
          highlight = {
            enable = true,
            disable = function(lang, bufnr)
              for _, file_type in ipairs({
                "dockerfile",
                "gomod",
                "gosum",
                "query",
                "sql",
              }) do
                if lang == file_type then
                  return true
                end
              end

              if vim.api.nvim_buf_line_count(bufnr) > 8192 then
                return true
              end

              local buf_name = vim.api.nvim_buf_get_name(bufnr)
              local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
              if file_size > 256 * 1024 then
                return true
              end

              return false
            end,
          },
          indent = {
            enable = true,
          },
        })
      end,
    },

    {
      "nvimdev/dashboard-nvim",
      lazy = false,
      config = function()
        local header = {
          [[     ⠀⠀⠀⠀⠀⠀⠀⡴⠞⠉⢉⣭⣿⣿⠿⣳⣤⠴⠖⠛⣛⣿⣿⡷⠖⣶⣤⡀⠀⠀⠀  ]],
          [[   ⠀⠀⠀⠀⠀⠀⠀⣼⠁⢀⣶⢻⡟⠿⠋⣴⠿⢻⣧⡴⠟⠋⠿⠛⠠⠾⢛⣵⣿⠀⠀⠀⠀  ]],
          [[   ⣼⣿⡿⢶⣄⠀⢀⡇⢀⡿⠁⠈⠀⠀⣀⣉⣀⠘⣿⠀⠀⣀⣀⠀⠀⠀⠛⡹⠋⠀⠀⠀⠀  ]],
          [[   ⣭⣤⡈⢑⣼⣻⣿⣧⡌⠁⠀⢀⣴⠟⠋⠉⠉⠛⣿⣴⠟⠋⠙⠻⣦⡰⣞⠁⢀⣤⣦⣤⠀  ]],
          [[   ⠀⠀⣰⢫⣾⠋⣽⠟⠑⠛⢠⡟⠁⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠘⣷⡈⠻⣍⠤⢤⣌⣀  ]],
          [[   ⢀⡞⣡⡌⠁⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠸⣇⠀⢾⣷⢤⣬⣉  ]],
          [[   ⡞⣼⣿⣤⣄⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠸⣿⣇⠈⠻  ]],
          [[   ⢰⣿⡿⢹⠃⠀⣠⠤⠶⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⣿⠛⡄⠀  ]],
          [[   ⠈⠉⠁⠀⠀⠀⡟⡀⠀⠈⡗⠲⠶⠦⢤⣤⣤⣄⣀⣀⣸⣧⣤⣤⠤⠤⣿⣀⡀⠉⣼⡇⠀  ]],
          [[   ⣿⣴⣴⡆⠀⠀⠻⣄⠀⠀⠡⠀⠀⠀⠈⠛⠋⠀⠀⠀⡈⠀⠻⠟⠀⢀⠋⠉⠙⢷⡿⡇⠀  ]],
          [[   ⣻⡿⠏⠁⠀⠀⢠⡟⠀⠀⠀⠣⡀⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⢀⠈⠀⢀⣀⡾⣴⠃⠀  ]],
          [[   ⢿⠛⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠈⠢⠄⣀⠠⠼⣁⠀⡱⠤⠤⠐⠁⠀⠀⣸⠋⢻⡟⠀⠀  ]],
          [[   ⠈⢧⣀⣤⣶⡄⠘⣆⠀⠀⠀⠀⠀⠀⠀⢀⣤⠖⠛⠻⣄⠀⠀⠀⢀⣠⡾⠋⢀⡞⠀⠀⠀  ]],
          [[   ⠀⠀⠻⣿⣿⡇⠀⠈⠓⢦⣤⣤⣤⡤⠞⠉⠀⠀⠀⠀⠈⠛⠒⠚⢩⡅⣠⡴⠋⠀⠀⠀⠀  ]],
          [[   ⠀⠀⠀⠈⠻⢧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣻⠿⠋⠀⠀⠀⠀⠀⠀  ]],
          [[   ⠀⠀⠀⠀⠀⠀⠉⠓⠶⣤⣄⣀⡀⠀⠀⠀⠀⠀⢀⣀⣠⡴⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀  ]],
        }

        for _ = 1, 4 do
          table.insert(header, 1, "")
        end
        for _ = 1, 2 do
          table.insert(header, "")
        end

        local center = {
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Recent File",
            desc_hl = "String",
            key = "r",
            key_hl = "Number",
            key_format = " %s",
            action = "Telescope coc mru",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Find File",
            desc_hl = "String",
            key = "f",
            key_hl = "Number",
            key_format = " %s",
            action = "Telescope find_files",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Settings",
            desc_hl = "String",
            key = "c",
            key_hl = "Number",
            key_format = " %s",
            action = function()
              vim.api.nvim_input("<cmd>e $MYVIMRC | :cd %:p:h <cr>")
            end,
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Quit",
            desc_hl = "String",
            key = "q",
            key_hl = "Number",
            key_format = " %s",
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
          },
        }

        for _, button in ipairs(center) do
          button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        end

        local exec = function(cmd)
          local handle = io.popen(cmd)
          if handle == nil then
            return ""
          end

          local out = handle:read("*a")
          handle:close()

          return out
        end

        local footer = vim.split(exec("lunar 2>/dev/null"), "\n")

        require("dashboard").setup({
          theme = "doom",
          config = {
            header = header,
            center = center,
            footer = footer,
          },
        })
      end,
    },

    {
      "nvim-lualine/lualine.nvim",
      opts = function()
        local colors = {
          white = "#ebdbb2",
          black = "#282828",
          grey = "#464646",
          darkgray = "#504945",
          red = "#fb4934",
          green = "#b8bb26",
          blue = "#2b83ba",
          yellow = "#d79921",
          orange = "#e78a4e",
          cyan = "#82b3a8",
          lightbg = "#353535",
        }

        return {
          options = {
            globalstatus = true,
            disabled_filetypes = {
              statusline = {
                "coc-explorer",
                "TelescopePrompt",
                "fugitive",
                "fugitiveblame",
                "floaterm",
                "qf",
              },
            },
          },
          sections = {
            lualine_a = {
              {
                function()
                  return ""
                end,
                separator = { right = "" },
                color = {
                  fg = colors.black,
                  bg = colors.blue,
                },
              },
            },
            lualine_b = {
              {
                "filetype",
                color = {
                  bg = colors.darkgray,
                },
                icon_only = true,
                separator = "",
                padding = { left = 1, right = 0 },
              },
              {

                "filename",
                file_status = true,
                path = 1,
                symbols = { modified = "", readonly = "󰌾", unnamed = "" },
                separator = { right = "" },
                color = {
                  bg = colors.darkgray,
                },
                padding = { left = 0, right = 1 },
              },
            },
            lualine_c = {
              {
                function()
                  local info = vim.b["coc_diagnostic_info"] or {}

                  if vim.tbl_isempty(info) then
                    return ""
                  end

                  local cnt = info["error"] or 0

                  if cnt == 0 then
                    return ""
                  end

                  local lnum = string.format("(L%d)", info["lnums"][1])

                  return cnt .. lnum
                end,
                icon = "",
                color = { fg = colors.red },
                separator = "",
              },
              {
                function()
                  local info = vim.b["coc_diagnostic_info"] or {}

                  if vim.tbl_isempty(info) then
                    return ""
                  end

                  local cnt = info["warning"] or 0

                  if cnt == 0 then
                    return ""
                  end

                  local lnum = string.format("(L%d)", info["lnums"][2])

                  return cnt .. lnum
                end,
                icon = "",
                color = { fg = colors.yellow },
                separator = "",
              },
              {
                function()
                  local buf_name = vim.api.nvim_buf_get_name(0)
                  if buf_name == "" then
                    return ""
                  end

                  local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
                  if file_size > 256 * 1024 then
                    return ""
                  end

                  local lnum = vim.fn.search("\\s$", "nw")
                  if lnum == 0 then
                    return ""
                  end

                  return string.format("(L%d)", lnum)
                end,
                icon = "",
                color = { fg = colors.white },
                separator = "",
              },
            },
            lualine_x = {
              {
                function()
                  return require("noice").api.status.command.get()
                end,
                cond = function()
                  local modes = {
                    "SELECT",
                    "S-LINE",
                    "VISUAL",
                    "V-LINE",
                    "V-BLOCK",
                    "V-REPLACE",
                  }
                  local mode = require("lualine.utils.mode").get_mode()

                  if not vim.tbl_contains(modes, mode) then
                    return false
                  end

                  return package.loaded["noice"] and require("noice").api.status.command.has()
                end,
                separator = "",
                color = { fg = colors.red },
              },
              {
                function()
                  local content = require("noice").api.status.search.get() or ""

                  local v = content:match(".*(%[%d+/%d+%])$")
                  if v then
                    content = v
                  end

                  return content
                end,
                cond = require("noice").api.status.search.has,
                separator = "",
                color = { fg = colors.orange },
              },
              {
                function()
                  local icon = "󰘦 "
                  local msg = (vim.api.nvim_call_function("codeium#GetStatusString", {}) or "")

                  msg = msg:gsub("%s+", "")
                  if msg == "" then
                    return ""
                  end

                  return icon .. msg
                end,
                cond = function()
                  local mode = require("lualine.utils.mode").get_mode()

                  return mode == "INSERT"
                end,
                separator = "",
              },
              {
                function()
                  return vim.b["coc_current_function"] or ""
                end,
                cond = function()
                  local func = vim.b["coc_current_function"] or ""
                  return func ~= ""
                end,
                separator = "",
              },
              { "filetype" },
            },
            lualine_y = {
              {
                "mode",
                color = {
                  bg = colors.darkgray,
                },
              },
            },
            lualine_z = {
              {
                function()
                  return string.format(" %d/%d ", vim.fn.line("."), vim.fn.line("$"))
                end,
                color = {
                  fg = colors.black,
                  bg = colors.blue,
                },
              },
            },
          },
        }
      end,
    },

    {
      "akinsho/bufferline.nvim",
      branch = "main",
      config = function()
        require("bufferline").setup({
          options = {
            offsets = {
              { filetype = "coc-explorer", text = "" },
            },
            show_buffer_close_icons = false,
            show_close_icon = false,
            separator_style = "slope",
          },
        })
      end,
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
              wilder.check(function(_, x) return x == "" end),
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
          })
        })
      end,
    },

    {
      "neoclide/coc.nvim",
      branch = "release",
      init = function()
        local g = vim.g

        g.coc_snippet_next = "<C-n>"
        g.coc_snippet_prev = "<C-p>"

        g.coc_global_extensions = {
          "coc-clangd",
          "coc-explorer",
          "coc-go",
          "coc-html",
          "coc-json",
          "coc-lists",
          "coc-lua",
          "coc-pyright",
          "coc-sh",
          "coc-sql",
          "coc-vimlsp",
          "coc-xml",
          "coc-yaml",
        }
      end,
    },

    {
      "fatih/vim-go",
      config = function()
        local g = vim.g

        g.go_code_completion_enabled = 0
        g.go_doc_keywordprg_enabled = 0
        g.go_def_mapping_enabled = 0
        g.go_gopls_enabled = 0
        g.go_fmt_autosave = 0
        g.go_imports_autosave = 0
        g.go_mod_fmt_autosave = 0
        g.go_template_autocreate = 0
        g.go_textobj_enabled = 0
        g.go_term_enabled = 1
      end,
    },

    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "nvim-treesitter" },
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
          defaults = {
            prompt_prefix = "   ",
            selection_caret = "  ",
            mappings = {
              i = {
                ["<esc>"] = actions.close,
                ["<C-l>"] = false,
              },
              n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
              },
            },
            file_ignore_patterns = { "vendor/.*" },
            layout_config = {
              horizontal = {
                prompt_position = "top",
              },
              width = 0.87,
              height = 0.80,
              preview_cutoff = 120,
            },
            sorting_strategy = "ascending",
            path_display = { "truncate" },
          },
          extensions = {
            live_grep_args = {
              mappings = {
                i = {
                  ["<C-k>"] = lga_actions.quote_prompt(),
                  ["<C-j>"] = actions.to_fuzzy_refine,
                },
              },
            },
          },
        })

        --
        -- extension
        --

        telescope.load_extension("coc")
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
      end,
    },

    {
      "voldikss/vim-floaterm",
      config = function()
        local g = vim.g

        g.floaterm_width = 0.9
        g.floaterm_height = 0.9
      end,
    },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({
          map_cr = false,
        })
      end,
    },

    {
      "scrooloose/nerdcommenter",
      config = function()
        local g = vim.g

        g.NERDCreateDefaultMappings = 0
        g.NERDDefaultAlign = "left"
        g.NERDSpaceDelims = 1
      end,
    },

    { "tpope/vim-fugitive" },

    {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter" },
      config = function()
        require("treesj").setup({
          use_default_keymaps = false,
        })
      end,
    },

    {
      "Wansmer/sibling-swap.nvim",
      dependencies = { "nvim-treesitter" },
      config = function()
        require("sibling-swap").setup({
          use_default_keymaps = false,
        })

        vim.keymap.set("n", "<A-h>", require("sibling-swap").swap_with_left)
        vim.keymap.set("n", "<A-l>", require("sibling-swap").swap_with_right)
      end,
    },

    { "tpope/vim-abolish" },
    { "tpope/vim-repeat" },
    { "tpope/vim-surround" },
    { "junegunn/vim-easy-align" },

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
              else
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
        local g = vim.g
        g.wordmotion_mappings = {
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
      "booperlv/nvim-gomove",
      config = function()
        require("gomove").setup({
          map_defaults = false,
          reindent = false,
          undojoin = true,
          move_past_end_col = false,
          ignore_indent_lh_dup = true,
        })
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
      config = function()
        require("spectre").setup({
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
      end,
    },

    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("bqf").setup({
          -- auto_resize_height = false,
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
      "Exafunction/codeium.vim",
      config = function()
        vim.g.codeium_no_map_tab = 1
        vim.keymap.set("i", "<C-j>", [[codeium#Accept()]], { expr = true, script = true, silent = true })
      end,
    },

    { "MunifTanjim/nui.nvim", lazy = true },

    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          stages = "static",
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
      "folke/noice.nvim",
      config = function()
        local formatters = require("noice.text.format.formatters")

        function formatters.search_count(message, opts, input)
          local content = input:content()

          local v = content:match(".*(%[%d+/%d+%])$")
          if v then
            content = v
          end

          message:append(content)
        end

        require("noice").setup({
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
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
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
  },
})
