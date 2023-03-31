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
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },

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

    { "sheerun/vim-polyglot" },
    { "kyazdani42/nvim-web-devicons", lazy = true },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = "all",
          highlight = {
            enable = true,
            disable = function(lang, bufnr)
              -- 渲染有问题
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
            use_languagetree = true,
          },
          indent = {
            enable = false,
          },
        })
      end,
    },

    {
      "goolord/alpha-nvim",
      config = function()
        require("plugins.configs.dashboard")
      end,
    },

    {
      "feline-nvim/feline.nvim",
      config = function()
        require("plugins.configs.statusline")
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
          "coc-translator",
          "coc-sumneko-lua",
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
      },
      config = function()
        require("plugins.configs.telescope")
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
          highlight_unlabeled = true,
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

    { "lth-go/vim-bookmarks" },
    -- {
    --   "sindrets/diffview.nvim",
    --   config = function()
    --     require("diffview").setup({})
    --   end,
    -- },

    {
      "windwp/nvim-spectre",
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
  },
})
