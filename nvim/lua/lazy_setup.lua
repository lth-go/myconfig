local spec = {
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = ";",
    },
  },
  { import = "community" },
  { import = "plugins" },
}

local config = {
  install = { colorscheme = { "gruvbox-material", "default" } },
  ui = { backdrop = 100 },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
}

require("lazy").setup(spec, config)
