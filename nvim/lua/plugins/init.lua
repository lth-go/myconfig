vim.cmd("packadd packer.nvim")

local plugins = {
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "wbthomason/packer.nvim" },

  {
    "lifepillar/vim-gruvbox8",
    config = function()
      local vim = vim
      local g = vim.g

      g.gruvbox_italics = 0

      require("plugins.configs.highlights")
    end,
  },

  { "sheerun/vim-polyglot" },
  { "kyazdani42/nvim-web-devicons" },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.nvim_treesitter")
    end,
  },

  {
    "goolord/alpha-nvim",
    after = "vim-gruvbox8",
    config = function()
      require("plugins.configs.dashboard")
    end,
  },

  {
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    branch = "main",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.bufferline")
    end,
  },

  {
    "gelguy/wilder.nvim",
    run = ":UpdateRemotePlugins",
    config = function()
      require("plugins.configs.wilder")
    end,
  },

  {
    "neoclide/coc.nvim",
    branch = "release",
    setup = function()
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

  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     local g = vim.g

  --     g.copilot_no_tab_map = true
  --     g.copilot_hide_during_completion = 0
  --   end,
  -- },

  {
    "nvim-telescope/telescope.nvim",
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      local telescope = require("telescope")

      require("plugins.configs.telescope")
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
    config = function()
      require("plugins.configs.nvim_autopairs")
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
    requires = { "nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })

      vim.api.nvim_set_keymap("n", "gJ", ":TSJJoin<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gS", ":TSJSplit<CR>", { noremap = true, silent = true })
    end,
  },

  { "tpope/vim-abolish" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "junegunn/vim-easy-align" },

  {
    "terryma/vim-expand-region",
    setup = function()
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
    after = "vim-gruvbox8",
    config = function()
      require("plugins.configs.leap")
    end,
  },

  {
    "chaoren/vim-wordmotion",
    setup = function()
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
      require("plugins.configs.nvim_gomove")
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
  {
    "sindrets/diffview.nvim",
    setup = function()
      require("plugins.configs.diffview")
    end,
  },

  {
    "windwp/nvim-spectre",
    config = function()
      require("plugins.configs.nvim_spectre")
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
      require("pqf").setup()
    end,
  },
}

require("core.packer").bootstrap()
require("core.packer").run(plugins)
