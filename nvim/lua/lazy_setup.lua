require("lazy").setup({
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
} --[[@as LazySpec]], {
  install = { colorscheme = { "gruvbox-material", "desert" } },
  ui = { backdrop = 100 },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
} --[[@as LazyConfig]])
