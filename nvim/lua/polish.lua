vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del({ "n", "x" }, "gra")

require("pkg.translator").setup({
  proxy = "http://192.168.56.1:7890",
})
