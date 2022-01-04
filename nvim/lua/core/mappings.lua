local utils = require("core.utils")

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

local map = utils.map

local M = {}

M.misc = function()
  map("", "\\", ";")

  map("c", "/", [[v:lua.require("core.utils").smart_cmd_slash()]], { expr = true, silent = false })

  map("n", "<F1>", "<Nop>")
  map("i", "<F1>", "<Nop>")
  map("n", "Q", "<Nop>")

  map("n", "<Leader>q", ":q<CR>")
  map("n", "<Leader>w", ":w<CR>")

  cmd([[ cabbrev w!! w !sudo tee % > /dev/null ]])

  -- 切换布局快捷键
  map("n", "<C-J>", "<C-W><C-J>")
  map("n", "<C-K>", "<C-W><C-K>")
  map("n", "<C-L>", "<C-W><C-L>")
  map("n", "<C-H>", "<C-W><C-H>")

  map("n", "j", [[ (v:count > 1 ? "m'" . v:count : '') . 'j' ]], { expr = true })
  map("n", "k", [[ (v:count > 1 ? "m'" . v:count : '') . 'k' ]], { expr = true })

  -- 替换行首行尾快捷键
  map("", "H", "^")
  map("", "L", "g_")

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
  map("x", "p", [[ 'pgv"' . v:register . 'y' ]], { expr = true })

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

  map("n", "<Leader>bd", ":lua require('core.utils').buf_only()<CR>", { silent = true })

  local function required_mappings()
    -- Add Packer commands because we are not loading it at startup
    cmd("silent! command PackerClean lua require('plugins') require('packer').clean()")
    cmd("silent! command PackerCompile lua require('plugins') require('packer').compile()")
    cmd("silent! command PackerInstall lua require('plugins') require('packer').install()")
    cmd("silent! command PackerStatus lua require('plugins') require('packer').status()")
    cmd("silent! command PackerSync lua require('plugins') require('packer').sync()")
    cmd("silent! command PackerUpdate lua require('plugins') require('packer').update()")
  end

  required_mappings()
end

M.bufferline = function()
  map("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
  map("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
  map("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
  map("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
  map("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
  map("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
  map("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
  map("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
  map("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
end

M.copilot = function()
  map("i", "<C-j>", [[copilot#Accept("")]], { expr = true, script = true })
end

M.coc_nvim = function()
  map("i", "<Tab>", [[v:lua.require("core.utils").smart_tab()]], { expr = true })
  map("i", "<S-Tab>", [[v:lua.require("core.utils").smart_shift_tab()]], { expr = true })
  map("i", "<CR>", [[v:lua.require("core.utils").smart_enter()]], { expr = true })

  map("n", "[g", "<Plug>(coc-diagnostic-prev)", { noremap = false })
  map("n", "]g", "<Plug>(coc-diagnostic-next)", { noremap = false })

  nvim_set_keymap("n", "<leader>g", "<Plug>(coc-definition)zz", { silent = true })
  nvim_set_keymap("n", "gd", "<Plug>(coc-definition)zz", { silent = true })
  nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })

  nvim_set_keymap("n", "K", [[:lua require("core.utils").show_documentation()<CR>]], { noremap = true, silent = true })

  nvim_set_keymap("n", "<Leader>rn", [[<Plug>(coc-rename)]], {})
  nvim_set_keymap("n", "<Leader>rf", [[<Plug>(coc-refactor)]], {})

  nvim_set_keymap("x", "<Leader>af", [[<Plug>(coc-format-selected)]], {})
  nvim_set_keymap("n", "<Leader>af", [[<Plug>(coc-format)]], {})
  nvim_set_keymap("x", "<C-A-l>", [[<Plug>(coc-format-selected)]], {})
  nvim_set_keymap("n", "<C-A-l>", [[<Plug>(coc-format)]], {})

  nvim_set_keymap("x", "if", [[<Plug>(coc-funcobj-i)]], {})
  nvim_set_keymap("o", "if", [[<Plug>(coc-funcobj-i)]], {})
  nvim_set_keymap("x", "af", [[<Plug>(coc-funcobj-a)]], {})
  nvim_set_keymap("o", "af", [[<Plug>(coc-funcobj-a)]], {})
  nvim_set_keymap("x", "ic", [[<Plug>(coc-classobj-i)]], {})
  nvim_set_keymap("o", "ic", [[<Plug>(coc-classobj-i)]], {})
  nvim_set_keymap("x", "ac", [[<Plug>(coc-classobj-a)]], {})
  nvim_set_keymap("o", "ac", [[<Plug>(coc-classobj-a)]], {})

  nvim_set_keymap(
    "n",
    "<C-f>",
    [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]],
    { expr = true, noremap = true, nowait = true, silent = true }
  )
  nvim_set_keymap(
    "n",
    "<C-b>",
    [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]],
    { expr = true, noremap = true, nowait = true, silent = true }
  )
  nvim_set_keymap(
    "n",
    "<C-d>",
    [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"]],
    { expr = true, noremap = true, nowait = true, silent = true }
  )
  nvim_set_keymap(
    "n",
    "<C-u>",
    [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"]],
    { expr = true, noremap = true, nowait = true, silent = true }
  )

  nvim_set_keymap(
    "n",
    "<C-A-o>",
    [[:silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>]],
    { noremap = true, silent = true }
  )

  nvim_set_keymap("n", "<F2>", [[:CocOutline<CR>]], { noremap = true })

  nvim_set_keymap(
    "n",
    "<Space>gf",
    ":call CocActionAsync('codeAction', 'cursor', ['refactor.rewrite'])<CR>",
    { noremap = true, silent = true }
  )

  nvim_set_keymap("n", "<Leader>t", [[<Plug>(coc-translator-p)]], {})
  nvim_set_keymap("v", "<Leader>t", [[<Plug>(coc-translator-pv)]], {})

  -- coc-explorer
  nvim_set_keymap("n", [[<C-\>]], [[<Cmd>CocCommand explorer<CR>]], {})
end

M.vim_sneak = function()
  map("", [[\]], [[<Plug>Sneak_;]], { noremap = false })
end

M.nerdcommenter = function()
  map("", "<C-_>", [[<Plug>NERDCommenterToggle]], { noremap = false })
end

M.vim_expand_region = function()
  nvim_set_keymap("v", "v", "<Plug>(expand_region_expand)", {})
  nvim_set_keymap("v", "V", "<Plug>(expand_region_shrink)", {})
end

M.vim_easy_align = function()
  nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
  nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
end

M.telescope = function()
  nvim_set_keymap("n", "<Leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fm", [[<Cmd>Telescope coc mru<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fc", [[<Cmd>Telescope grep_string initial_mode=normal<CR>]], { noremap = true })

  nvim_set_keymap("n", "gr", [[<Cmd>Telescope coc references initial_mode=normal<CR>]], { silent = true })
  nvim_set_keymap("n", "gi", [[<Cmd>Telescope coc implementations initial_mode=normal<CR>]], { silent = true })

  nvim_set_keymap(
    "v",
    "<Leader>fc",
    [[:lua require('core.utils').grep_from_selected()<CR>]],
    { noremap = true, silent = true }
  )
end

M.wilder = function()
  nvim_set_keymap(
    "c",
    "/",
    [[wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"]],
    { expr = true, noremap = true }
  )
end

return M
