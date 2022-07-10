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

  {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
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

  { "github/copilot.vim" },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("plugins.configs.telescope")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    after = "telescope.nvim",
    run = "make",
    config = function()
      require("telescope").load_extension("fzf")
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
    "ggandor/lightspeed.nvim",
    after = "vim-gruvbox8",
    setup = function()
      vim.g.lightspeed_no_default_keymaps = true
    end,
    config = function()
      require("plugins.configs.lightspeed")
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
}

require("core.packer").run(plugins)
