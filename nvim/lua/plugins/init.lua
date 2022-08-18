vim.cmd("packadd packer.nvim")

local plugins = {
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "wbthomason/packer.nvim" },

  {
    "lifepillar/vim-gruvbox8",
    config = function()
      require("plugins.configs.theme")
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
      require("plugins.configs.coc")
    end,
  },

  {
    "fatih/vim-go",
    config = function()
      require("plugins.configs.vim_go")
    end,
  },

  -- { "github/copilot.vim" },

  {
    "nvim-telescope/telescope.nvim",
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "tom-anders/telescope-vim-bookmarks.nvim" },
    },
    config = function()
      require("plugins.configs.telescope")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("vim_bookmarks")
    end,
  },

  {
    "voldikss/vim-floaterm",
    config = function()
      require("plugins.configs.vim_floaterm")
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
      require("plugins.configs.nerdcommenter")
    end,
  },

  { "tpope/vim-fugitive" },
  { "AndrewRadev/splitjoin.vim" },
  {
    "AndrewRadev/sideways.vim",
    config = function()
      vim.api.nvim_set_keymap("n", "<Leader>h", ":SidewaysLeft<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>l", ":SidewaysRight<CR>", { noremap = true, silent = true })
    end,
  },
  { "tpope/vim-abolish" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "junegunn/vim-easy-align" },

  {
    "terryma/vim-expand-region",
    setup = function()
      require("plugins.configs.vim_expand_region")
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
      require("plugins.configs.vim_wordmotion")
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

  {
    "MattesGroeger/vim-bookmarks",
    setup = function()
      require("plugins.configs.bookmarks")
    end,
  },

  { "lewis6991/impatient.nvim" },
}

require("core.packer").run(plugins)
