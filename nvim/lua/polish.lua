vim.cmd([[cabbrev w!! w !sudo tee % > /dev/null]])

vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del({ "n", "x" }, "gra")
