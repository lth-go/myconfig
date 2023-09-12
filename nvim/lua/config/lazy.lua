local vim = vim

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
      priority = 1000,
      config = function()
        local vim = vim
        local g = vim.g
        local cmd = vim.cmd
        local nvim_set_hl = vim.api.nvim_set_hl

        g.gruvbox_material_background = "hard"
        g.gruvbox_material_foreground = "original"
        g.gruvbox_material_better_performance = 1
        g.gruvbox_material_disable_italic_comment = 1

        cmd.colorscheme("gruvbox-material")

        nvim_set_hl(0, "CocExplorerFileDirectoryExpanded", { fg = "#8094b4" })
        nvim_set_hl(0, "CocExplorerFileDirectoryCollapsed", { fg = "#8094b4" })

        nvim_set_hl(0, "StartLogo1", { fg = "#1C506B" })
        nvim_set_hl(0, "StartLogo2", { fg = "#1D5D68" })
        nvim_set_hl(0, "StartLogo3", { fg = "#1E6965" })
        nvim_set_hl(0, "StartLogo4", { fg = "#1F7562" })
        nvim_set_hl(0, "StartLogo5", { fg = "#21825F" })
        nvim_set_hl(0, "StartLogo6", { fg = "#228E5C" })
        nvim_set_hl(0, "StartLogo7", { fg = "#239B59" })
        nvim_set_hl(0, "StartLogo8", { fg = "#24A755" })

        nvim_set_hl(0, "SpectreSearch", { reverse = true, ctermfg = 107, ctermbg = 234, fg = "#8ec07c", bg = "#1d2021" })
        nvim_set_hl(0, "SpectreReplace", { reverse = true, ctermfg = 203, ctermbg = 234, fg = "#fb4934", bg = "#1d2021" })
      end,
    },

    {
      "kyazdani42/nvim-web-devicons",
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
              if lang == "dockerfile" then
                return true
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
      "goolord/alpha-nvim",
      event = "VimEnter",
      config = function()
        local dashboard = require("alpha.themes.dashboard")

        local header = {
          [[                                                                   ]],
          [[      ████ ██████           █████      ██                    ]],
          [[     ███████████             █████                            ]],
          [[     █████████ ███████████████████ ███   ███████████  ]],
          [[    █████████  ███    █████████████ █████ ██████████████  ]],
          [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
          [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
          [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
        }

        local function colorize_header()
          local lines = {}

          for i, chars in pairs(header) do
            local line = {
              type = "text",
              val = chars,
              opts = {
                hl = "StartLogo" .. i,
                shrink_margin = false,
                position = "center",
              },
            }

            table.insert(lines, line)
          end

          return lines
        end

        dashboard.section.header.type = "group"
        dashboard.section.header.val = colorize_header()
        dashboard.section.buttons.val = {
          dashboard.button("<Leader> f m", "  Recent File  ", ":Telescope coc mru<CR>"),
          dashboard.button("<Leader> f f", "  Find File  ", ":Telescope find_files<CR>"),
          dashboard.button("<Leader> f g", "  Find Word  ", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"),
          dashboard.button("<Leader> e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
          button.opts.hl = "Keyword"
          button.opts.hl_shortcut = "Title"
        end
        dashboard.section.footer.val = require("alpha.fortune")()
        dashboard.section.footer.opts.hl = "Number"
        dashboard.section.footer.opts.position = "center"
        dashboard.opts.layout[1].val = 8

        require("alpha").setup(dashboard.config)
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
                "alpha",
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
                  return ""
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
                separator = { right = "" },
                color = {
                  bg = colors.darkgray,
                },
                path = 1,
                symbols = { modified = "  ", readonly = "", unnamed = "" },
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
        require("plugins.configs.bufferline")
      end,
    },

    {
      "gelguy/wilder.nvim",
      build = ":UpdateRemotePlugins",
      config = function()
        require("plugins.configs.wilder")
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
          "coc-lists",
          "coc-explorer",
          "coc-json",
          "coc-xml",
          "coc-html",
          "coc-yaml",
          "coc-sh",
          "coc-sql",
          "coc-go",
          "coc-pyright",
          "coc-clangd",
          "coc-vimlsp",
          "coc-lua",
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
              mappings = { -- extend mappings
                i = {
                  ["<C-k>"] = lga_actions.quote_prompt(),
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

        leap.set_default_keymaps()
        leap.setup({
          max_phase_one_targets = 0,
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
          -- whether or not to map default key bindings, (true/false)
          map_defaults = false,
          -- whether or not to reindent lines moved vertically (true/false)
          reindent = false,
          -- whether or not to undojoin same direction moves (true/false)
          undojoin = true,
          -- whether to not to move past end column when moving blocks horizontally, (true/false)
          move_past_end_col = false,
          -- whether or not to ignore indent when duplicating lines horizontally, (true/false)
          ignore_indent_lh_dup = true,
        })
      end,
    },

    {
      "haya14busa/vim-asterisk",
      config = function()
        -- vim.g["asterisk#keeppos"] = 1
        vim.api.nvim_set_keymap("", "*", [[<Plug>(asterisk-z*)]], {})
      end,
    },

    -- {
    --   "sindrets/diffview.nvim",
    --   config = function()
    --     require("diffview").setup({})
    --   end,
    -- },

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
      "lth-go/searchbox.nvim",
      config = function()
        vim.keymap.set("n", "/", ":SearchBoxMatchAll<CR>", { silent = true })
      end,
    },
    {
      "folke/noice.nvim",
      config = function()
        local Formatters = require("noice.text.format.formatters")

        function Formatters.search_count(message, opts, input)
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
              cmdline = { lang = "" },
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
        local vim = vim
        local g = vim.g

        g.translator_default_engines = { "google" }
        g.translator_proxy_url = "http://192.168.56.1:7890"

        vim.keymap.set("n", "<Leader>t", [[<Plug>TranslateW]], { silent = true })
        vim.keymap.set("v", "<Leader>t", [[<Plug>TranslateWV]], { silent = true })
      end,
    },
  },
})
