vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4

local go = require("pkg.langs.go")

vim.keymap.set("n", "<C-A-O>", go.go_imports, { buffer = true })
vim.keymap.set("n", "<F5>", go.go_test, { buffer = true })
