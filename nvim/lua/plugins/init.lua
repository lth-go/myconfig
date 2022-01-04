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
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.nvim-treesitter")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    setup = function()
      require("core.mappings").telescope()
    end,
    config = function()
      require("plugins.configs.telescope")
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.configs.nvim-autopairs")
    end,
  })

  use({
    "neoclide/coc.nvim",
    branch = "release",
    setup = function()
      require("core.mappings").coc_nvim()
      require("plugins.configs.coc-nvim")
    end,
  })

  use({
    "fatih/vim-go",
    config = function()
      require("plugins.configs.vim-go")
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
    "glepnir/dashboard-nvim",
    config = function()
      require("plugins.configs.dashboard")
    end,
  })

  use({
    "scrooloose/nerdcommenter",
    setup = function()
      require("core.mappings").nerdcommenter()
      require("plugins.configs.nerdcommenter")
    end,
  })

  use("tpope/vim-surround")

  use("tpope/vim-repeat")

  use("tpope/vim-abolish")

  use({
    "chaoren/vim-wordmotion",
    setup = function()
      require("plugins.configs.vim-wordmotion")
    end,
  })

  use({
    "terryma/vim-expand-region",
    setup = function()
      require("core.mappings").vim_expand_region()
      require("plugins.configs.vim-expand-region")
    end,
  })

  use("AndrewRadev/splitjoin.vim")

  use({
    "justinmk/vim-sneak",
    setup = function()
      require("core.mappings").vim_sneak()
    end,
  })

  use({
    "junegunn/vim-easy-align",
    setup = function()
      require("core.mappings").vim_easy_align()
    end,
  })

  use("tpope/vim-fugitive")

  use({
    "voldikss/vim-floaterm",
    config = function()
      require("plugins.configs.vim-floaterm")
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
end)
