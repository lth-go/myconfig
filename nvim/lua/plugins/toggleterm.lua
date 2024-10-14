return {
  "akinsho/toggleterm.nvim",
  keys = { "<F12>" },
  opts = {
    open_mapping = [[<F12>]],
    highlights = {
      NormalFloat = { link = "Normal" },
      FloatBorder = { link = "Comment" },
    },
    direction = "float",
    float_opts = {
      width = function(_)
        return vim.fn.float2nr(vim.o.columns * 0.9)
      end,
      height = function(_)
        return vim.fn.float2nr((vim.o.lines - vim.o.cmdheight - 1) * 0.9)
      end,
      winblend = 0,
    },
    shading_factor = -30,
  },
}
