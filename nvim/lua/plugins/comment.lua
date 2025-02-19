return {
  "preservim/nerdcommenter",
  init = function()
    vim.g.NERDCreateDefaultMappings = 0
    vim.g.NERDDefaultAlign = "left"
    vim.g.NERDSpaceDelims = 1

    vim.keymap.set("", "<C-_>", [[<Plug>NERDCommenterToggle]])
  end,
}
