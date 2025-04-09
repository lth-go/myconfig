local file_types = {
  "bash",
  "go",
  "json",
  "lua",
  "make",
  "proto",
  "python",
  "rust",
  "sh",
  "sql",
  "toml",
  "yaml",
}

return {
  "lth-go/supermaven-nvim",
  ft = file_types,
  config = function()
    require("supermaven-nvim").setup({
      filetypes = file_types,
    })
  end,
}
