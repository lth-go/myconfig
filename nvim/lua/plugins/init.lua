local present, packer = pcall(require, "plugins.packerInit")

if not present then
  return false
end

local use = packer.use

return packer.startup(function()
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  use({
    "lifepillar/vim-gruvbox8",
    after = "packer.nvim",
    config = function()
      require("plugins.configs.gruvbox")
    end,
  })

  use("sheerun/vim-polyglot")

  use({
    "kyazdani42/nvim-web-devicons",
    after = "vim-gruvbox8",
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.nvim_treesitter")
    end,
  })

  use({
    "glepnir/dashboard-nvim",
    config = function()
      require("plugins.configs.dashboard")
    end,
  })

  use({
    "famiu/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
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
    "lth-go/copilot.vim",
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
    "justinmk/vim-sneak",
    setup = function()
      require("core.mappings").vim_sneak()
    end,
  })

  use({
    "chaoren/vim-wordmotion",
    setup = function()
      require("plugins.configs.vim_wordmotion")
    end,
  })
end)
