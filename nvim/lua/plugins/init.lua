local present, packer = pcall(require, "plugins.packerInit")

if not present then
  return false
end

local use = packer.use

return packer.startup(function()
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("lewis6991/impatient.nvim")
  use("nathom/filetype.nvim")

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  use({
    "lifepillar/vim-gruvbox8",
    after = "packer.nvim",
    config = function()
      require("plugins.configs.theme")
    end,
  })

  use("sheerun/vim-polyglot")

  use({
    "kyazdani42/nvim-web-devicons",
    after = "vim-gruvbox8",
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.nvim_treesitter")
    end,
  })

  use({
    "goolord/alpha-nvim",
    config = function()
      require("plugins.configs.dashboard")
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    branch = 'main',
    after = "nvim-web-devicons",
    setup = function()
      require("core.mappings").bufferline()
    end,
    config = function()
      require("plugins.configs.bufferline")
    end,
  })

  use({
    "gelguy/wilder.nvim",
    run = ":UpdateRemotePlugins",
    setup = function()
      require("core.mappings").wilder()
    end,
    config = function()
      require("plugins.configs.wilder")
    end,
  })

  use({
    "neoclide/coc.nvim",
    branch = "release",
    setup = function()
      require("core.mappings").coc()
      require("plugins.configs.coc")
    end,
  })

  use({
    "fatih/vim-go",
    config = function()
      require("plugins.configs.vim_go")
    end,
  })

  use({
    "github/copilot.vim",
    setup = function()
      require("plugins.configs.copilot")
      require("core.mappings").copilot()
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    after = "packer.nvim",
    setup = function()
      require("core.mappings").telescope()
    end,
    config = function()
      require("plugins.configs.telescope")
    end,
  })

  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    after = "telescope.nvim",
    run = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  })

  use("tpope/vim-fugitive")

  use({
    "voldikss/vim-floaterm",
    config = function()
      require("plugins.configs.vim_floaterm")
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.configs.nvim_autopairs")
    end,
  })

  use({
    "scrooloose/nerdcommenter",
    setup = function()
      require("core.mappings").nerdcommenter()
      require("plugins.configs.nerdcommenter")
    end,
  })

  use("AndrewRadev/splitjoin.vim")

  use("tpope/vim-abolish")
  use("tpope/vim-repeat")
  use("tpope/vim-surround")

  use({
    "junegunn/vim-easy-align",
    setup = function()
      require("core.mappings").vim_easy_align()
    end,
  })

  use({
    "terryma/vim-expand-region",
    setup = function()
      require("core.mappings").vim_expand_region()
      require("plugins.configs.vim_expand_region")
    end,
  })

  -- use({
  --   "andymass/vim-matchup",
  -- })

  use({
    "ggandor/lightspeed.nvim",
    after = "vim-gruvbox8",
    setup = function()
      vim.g.lightspeed_no_default_keymaps = true
      require("core.mappings").lightspeed()
    end,
    config = function()
      require("plugins.configs.lightspeed")
    end,
  })

  use({
    "chaoren/vim-wordmotion",
    setup = function()
      require("plugins.configs.vim_wordmotion")
    end,
  })

  use({
    "booperlv/nvim-gomove",
    setup = function()
      require("core.mappings").gomove()
    end,
    config = function()
      require("plugins.configs.nvim_gomove")
    end,
  })
end)
