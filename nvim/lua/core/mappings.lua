local utils = require("core.utils")

local map = utils.map

local M = {}

M.misc = function()
  map("", "\\", ";")

  map("c", "/", [[v:lua.require("core.utils").smart_cmd_slash()]], { expr = true, noremap = true, silent = false })

  map("n", "<F1>", "<Nop>")
  map("i", "<F1>", "<Nop>")
  map("n", "Q", "<Nop>")

  map("n", "<Leader>q", ":q<CR>")
  map("n", "<Leader>w", ":w<CR>")

  vim.cmd([[ cabbrev w!! w !sudo tee % > /dev/null ]])

  -- 切换布局快捷键
  map("n", "<C-J>", "<C-W><C-J>")
  map("n", "<C-K>", "<C-W><C-K>")
  map("n", "<C-L>", "<C-W><C-L>")
  map("n", "<C-H>", "<C-W><C-H>")

  map("n", "j", [[ (v:count > 1 ? "m'" . v:count : '') . 'j' ]],  { expr = true })
  map("n", 'k', [[ (v:count > 1 ? "m'" . v:count : '') . 'k' ]],  { expr = true })

  -- 替换行首行尾快捷键
  map("", "H", "^")
  map("", 'L', "g_")

  -- 命令行模式增强
  map("c", "<C-P>", "<Up>", { noremap = true, silent = false })
  map("c", "<C-N>", "<Down>", { noremap = true, silent = false })
  map("c", "<C-B>", "<Left>", { noremap = true, silent = false })
  map("c", "<C-F>", "<Right>", { noremap = true, silent = false })
  map("c", "<C-A>", "<Home>", { noremap = true, silent = false })
  map("c", "<C-E>", "<End>", { noremap = true, silent = false })
  map("c", "<C-D>", "<Del>", { noremap = true, silent = false })

  -- 插入模式增强
  map("i", "<C-B>", "<Left>")
  map("i", "<C-F>", "<Right>")
  map("i", "<C-A>", "<Home>")
  map("i", "<C-E>", "<End>")
  map("i", "<C-D>", "<Del>")

  -- 搜索关键词居中
  map("n", "n", "nzz")
  map("n", "N", "Nzz")
  map("n", "<C-o>", "<C-o>zz")
  map("n", "<C-i>", "<C-i>zz")
  map("n", "<C-]>", "<C-]>zz")

  map("n", "<Backspace>", ":nohlsearch<CR>")

  -- 调整缩进后自动选中
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  -- 复制当前行号
  map("n", "<C-g>", [[:lua require("core.utils").show_current_line()<CR>]])

  -- 粘贴不覆盖
  map("x", "p", [[ 'pgv"' . v:register . 'y' ]],  { expr = true })

  -- 块粘贴修正
  map("", "<Leader>y", [[ ""y ]])
  map("", "<Leader>d", [[ ""d ]])
  map("", "<Leader>p", [[ ""p ]])
  map("", "<Leader>P", [[ ""P ]])

  map("n", "<Leader><Space>", ":vs<CR>")

  map("x", "<A-j>", [[ :m '>+1<CR>gv-gv ]])
  map("x", "<A-k>", [[ :m '<-2<CR>gv-gv ]])

  map("n", "*", [[:lua require("core.utils").start_search()<CR>]])
  map("v", "*", [[:lua require("core.utils").v_start_search()<CR>]])

  map("n", "<Leader>bd", ":lua require('core.utils').buf_only()<CR>", { noremap = true, silent = true })
end

return M
