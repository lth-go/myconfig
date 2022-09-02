local vim = vim
local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

local M = {}

M.general = function()
  nvim_set_keymap("", [[\]], ";", { noremap = true })

  nvim_set_keymap("c", "/", [[v:lua.require("core.utils").smart_cmd_slash()]], { expr = true })

  nvim_set_keymap("n", "<F1>", "<Nop>", { noremap = true })
  nvim_set_keymap("i", "<F1>", "<Nop>", { noremap = true })
  nvim_set_keymap("n", "Q", "<Nop>", { noremap = true })

  nvim_set_keymap("n", "<Leader>q", ":q<CR>", { noremap = true })
  nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true })
  nvim_set_keymap("n", "<Leader>z", ":qa!<CR>", { noremap = true })

  cmd([[cabbrev w!! w !sudo tee % > /dev/null]])

  -- 切换布局快捷键
  nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
  nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
  nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })
  nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })

  nvim_set_keymap("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j']], { expr = true, noremap = true })
  nvim_set_keymap("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k']], { expr = true, noremap = true })

  -- 替换行首行尾快捷键
  nvim_set_keymap("", "H", "^", { noremap = true })
  nvim_set_keymap("", "L", "g_", { noremap = true })

  -- 命令行模式增强
  nvim_set_keymap("c", "<C-P>", "<Up>", { noremap = true })
  nvim_set_keymap("c", "<C-N>", "<Down>", { noremap = true })
  nvim_set_keymap("c", "<C-B>", "<Left>", { noremap = true })
  nvim_set_keymap("c", "<C-F>", "<Right>", { noremap = true })
  nvim_set_keymap("c", "<C-A>", "<Home>", { noremap = true })
  nvim_set_keymap("c", "<C-E>", "<End>", { noremap = true })
  nvim_set_keymap("c", "<C-D>", "<Del>", { noremap = true })

  -- 插入模式增强
  nvim_set_keymap("i", "<C-B>", "<Left>", { noremap = true })
  nvim_set_keymap("i", "<C-F>", "<Right>", { noremap = true })
  nvim_set_keymap("i", "<C-A>", "<Home>", { noremap = true })
  nvim_set_keymap("i", "<C-E>", "<End>", { noremap = true })
  nvim_set_keymap("i", "<C-D>", "<Del>", { noremap = true })

  -- 搜索关键词居中
  nvim_set_keymap("n", "n", "nzz", { noremap = true })
  nvim_set_keymap("n", "N", "Nzz", { noremap = true })
  nvim_set_keymap("n", "<C-o>", "<C-o>zz", { noremap = true })
  nvim_set_keymap("n", "<C-i>", "<C-i>zz", { noremap = true })
  nvim_set_keymap("n", "<C-]>", "<C-]>zz", { noremap = true })

  nvim_set_keymap("n", "<Backspace>", "<Cmd>nohlsearch<CR>", { noremap = true })

  -- 调整缩进后自动选中
  nvim_set_keymap("v", "<", "<gv", { noremap = true })
  nvim_set_keymap("v", ">", ">gv", { noremap = true })

  -- 复制当前行号
  nvim_set_keymap("n", "<C-g>", [[<Cmd>lua require("core.utils").show_current_line()<CR>]], { noremap = true })

  -- 粘贴不覆盖
  nvim_set_keymap("x", "p", [['pgv"' . v:register . 'y']], { expr = true, noremap = true })

  -- 块粘贴修正
  nvim_set_keymap("", "<Leader>y", [[""y]], {})
  nvim_set_keymap("", "<Leader>d", [[""d]], {})
  nvim_set_keymap("", "<Leader>p", [[""p]], {})
  nvim_set_keymap("", "<Leader>P", [[""P]], {})

  nvim_set_keymap("n", "<Leader><Space>", ":vs<CR>", { noremap = true })

  nvim_set_keymap("n", "<Leader>bd", "<Cmd>lua require('core.utils').buf_only()<CR>", { noremap = true, silent = true })
end

M.bufferline = function()
  nvim_set_keymap("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
  nvim_set_keymap("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
end

M.wilder = function()
  nvim_set_keymap("c", "/", [[wilder#can_accept_completion() ? wilder#accept_completion(0) : "/"]], { expr = true, noremap = true })
end

M.coc = function()
  nvim_set_keymap("i", "<Tab>", [[v:lua.require("core.utils").smart_tab()]], { expr = true, noremap = true, silent = true })
  nvim_set_keymap("i", "<S-Tab>", [[v:lua.require("core.utils").smart_shift_tab()]], { expr = true, noremap = true })
  nvim_set_keymap("i", "<CR>", [[v:lua.require("core.utils").smart_enter()]], { expr = true, noremap = true, silent = true })

  nvim_set_keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
  nvim_set_keymap("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

  nvim_set_keymap("n", "<leader>g", "<Plug>(coc-definition)zz", { silent = true })
  nvim_set_keymap("n", "gd", "<Plug>(coc-definition)zz", { silent = true })
  nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })

  nvim_set_keymap("n", "K", [[<Cmd>lua require("core.utils").show_documentation()<CR>]], { noremap = true, silent = true })

  nvim_set_keymap("n", "<Leader>rn", [[<Plug>(coc-rename)]], {})
  nvim_set_keymap("n", "<Leader>rf", [[<Plug>(coc-refactor)]], {})

  nvim_set_keymap("x", "<Leader>af", [[<Plug>(coc-format-selected)]], {})
  nvim_set_keymap("n", "<Leader>af", [[<Plug>(coc-format)]], {})
  nvim_set_keymap("x", "<C-A-l>", [[<Plug>(coc-format-selected)]], {})
  nvim_set_keymap("n", "<C-A-l>", [[<Plug>(coc-format)]], {})
  nvim_set_keymap("n", "<Leader>ac", [[<Plug>(coc-codeaction-cursor)]], {})

  nvim_set_keymap("x", "if", [[<Plug>(coc-funcobj-i)]], {})
  nvim_set_keymap("o", "if", [[<Plug>(coc-funcobj-i)]], {})
  nvim_set_keymap("x", "af", [[<Plug>(coc-funcobj-a)]], {})
  nvim_set_keymap("o", "af", [[<Plug>(coc-funcobj-a)]], {})
  nvim_set_keymap("x", "ic", [[<Plug>(coc-classobj-i)]], {})
  nvim_set_keymap("o", "ic", [[<Plug>(coc-classobj-i)]], {})
  nvim_set_keymap("x", "ac", [[<Plug>(coc-classobj-a)]], {})
  nvim_set_keymap("o", "ac", [[<Plug>(coc-classobj-a)]], {})

  nvim_set_keymap("n", "<C-f>", [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { expr = true, noremap = true, nowait = true, silent = true })
  nvim_set_keymap("n", "<C-b>", [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { expr = true, noremap = true, nowait = true, silent = true })
  nvim_set_keymap("n", "<C-d>", [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"]], { expr = true, noremap = true, nowait = true, silent = true })
  nvim_set_keymap("n", "<C-u>", [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"]], { expr = true, noremap = true, nowait = true, silent = true })

  nvim_set_keymap("n", "<C-A-o>", [[<Cmd>silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>]], { noremap = true, silent = true })

  nvim_set_keymap("n", "<F2>", [[<Cmd>CocOutline<CR>]], { noremap = true })

  nvim_set_keymap("n", "<Space>gf", "<Cmd>call CocActionAsync('codeAction', 'cursor', ['refactor.rewrite'])<CR>", { noremap = true, silent = true })

  nvim_set_keymap("n", "<Leader>t", [[<Plug>(coc-translator-p)]], {})
  nvim_set_keymap("v", "<Leader>t", [[<Plug>(coc-translator-pv)]], {})

  -- coc-explorer
  nvim_set_keymap("n", [[<C-\>]], [[<Cmd>CocCommand explorer<CR>]], {})
  nvim_set_keymap("n", [[<F1>]], [[<Cmd>CocCommand explorer --no-toggle --no-focus<CR>]], {})
end

M.copilot = function()
  nvim_set_keymap("i", "<C-j>", [[copilot#Accept("")]], { expr = true, script = true, silent = true })
end

M.telescope = function()
  nvim_set_keymap("n", "<Leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fm", [[<Cmd>Telescope coc mru<CR>]], { noremap = true })
  nvim_set_keymap("n", "<Leader>fc", [[<Cmd>Telescope grep_string<CR>]], { noremap = true })

  nvim_set_keymap("n", "gr", [[<Cmd>Telescope coc references initial_mode=normal<CR>]], { silent = true })
  nvim_set_keymap("n", "gi", [[<Cmd>Telescope coc implementations initial_mode=normal<CR>]], { silent = true })

  nvim_set_keymap("v", "<Leader>fc", [[<Cmd>lua require('core.utils').grep_from_selected()<CR>]], { noremap = true, silent = true })
end

M.nerdcommenter = function()
  nvim_set_keymap("", "<C-_>", [[<Plug>NERDCommenterToggle]], {})
end

M.vim_easy_align = function()
  nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
  nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
end

M.vim_expand_region = function()
  nvim_set_keymap("v", "v", "<Plug>(expand_region_expand)", {})
  nvim_set_keymap("v", "V", "<Plug>(expand_region_shrink)", {})
end

M.gomove = function()
  nvim_set_keymap("x", "<A-h>", "<Plug>GoVSMLeft", {})
  nvim_set_keymap("x", "<A-j>", "<Plug>GoVSMDown", {})
  nvim_set_keymap("x", "<A-k>", "<Plug>GoVSMUp", {})
  nvim_set_keymap("x", "<A-l>", "<Plug>GoVSMRight", {})
end

M.bookmarks = function()
  nvim_set_keymap("n", "mm", "<Plug>BookmarkToggle", {})
  nvim_set_keymap("n", "mi", "<Plug>BookmarkAnnotate", {})
  nvim_set_keymap("n", "<Leader>m", [[<Cmd>lua require('core.utils').open_telescope_bookmarks()<CR>]], {})
  nvim_set_keymap("n", "]m", "<Plug>BookmarkNext", {})
  nvim_set_keymap("n", "[m", "<Plug>BookmarkPrev", {})
  nvim_set_keymap("n", "mc", "<Plug>BookmarkClear", {})
end

M.init = function()
  vim.defer_fn(function()
    M.general()
    M.bufferline()
    M.wilder()
    M.coc()
    M.copilot()
    M.telescope()
    M.nerdcommenter()
    M.vim_easy_align()
    M.vim_expand_region()
    M.gomove()
    M.bookmarks()
  end, 0)
end

return M
