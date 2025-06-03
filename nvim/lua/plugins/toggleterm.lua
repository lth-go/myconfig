return {
  "akinsho/toggleterm.nvim",
  keys = { "<F12>" },
  opts = {
    open_mapping = "<F12>",
    on_open = function(term)
      vim.cmd("nohlsearch")

      local dir = vim.uv.cwd()
      if not dir then
        return
      end
      if dir == term.dir then
        return
      end

      term:send(string.format("cd %s", vim.fn.shellescape(dir)), false)
      term.dir = dir
    end,
    highlights = {
      NormalFloat = { link = "Normal" },
      FloatBorder = { link = "Grey" },
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
  },
}
