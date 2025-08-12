---@type LazySpec
return {
  { "L3MON4D3/LuaSnip", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "brenoprata10/nvim-highlight-colors", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "mfussenegger/nvim-dap", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "s1n7ax/nvim-window-picker", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },

  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          foldcolumn = "0",
          timeoutlen = 1000,
          title = false,
          undofile = false,
        },
      },
      mappings = {
        n = {
          ["\\"] = false,
          ["|"] = false,
          ["<Leader>gb"] = false,
          ["<Leader>gc"] = false,
          ["<Leader>gC"] = false,
          ["<Leader>gg"] = false,
          ["<Leader>go"] = false,
          ["<Leader>gt"] = false,
          ["<Leader>gT"] = false,
          ["<Leader>tf"] = false,
          ["<Leader>th"] = false,
          ["<Leader>tl"] = false,
          ["<Leader>tn"] = false,
          ["<Leader>tp"] = false,
          ["<Leader>tt"] = false,
          ["<Leader>tv"] = false,
        },
      },
      autocmds = {
        highlightyank = false,
      },
      on_keys = {
        auto_hlsearch = false,
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    opts = {
      formatting = {
        format_on_save = {
          enabled = false,
        },
      },
      autocmds = {
        lsp_auto_signature_help = false,
        lsp_auto_format = false,
      },
    },
  },
}
