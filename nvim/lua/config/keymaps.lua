local cmd = vim.cmd
local keymap_set = vim.keymap.set
local nvim_set_keymap = vim.api.nvim_set_keymap

local M = {}

M.general = function()
  local smart_cmd_slash = function()
    local key = vim.api.nvim_replace_termcodes("<Down>", true, true, true)
    return vim.fn.pumvisible() == 1 and key or "/"
  end

  local show_current_line = function()
    local msg = string.format("%s:%s", vim.fn.expand("%"), vim.fn.line("."))
    vim.fn.setreg("+", msg)
    print(msg)
  end

  local show_current_dir = function()
    local msg = string.format("%s/", vim.fn.expand("%:h"))
    vim.fn.setreg("+", msg)
    print(msg)
  end

  local buf_only = function()
    local current_buf_map = {}

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      current_buf_map[vim.api.nvim_win_get_buf(win)] = true
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_option(buf, "modified") then
        goto continue
      end

      if not vim.bo[buf].buflisted then
        goto continue
      end

      if not vim.api.nvim_buf_is_valid(buf) then
        goto continue
      end

      if current_buf_map[buf] then
        goto continue
      end

      if vim.api.nvim_buf_get_option(buf, "buftype") == "" then
        vim.cmd(string.format("%s %d", "bdelete", buf))
      end

      ::continue::
    end
  end

  keymap_set("", [[\]], ";", { noremap = true })

  keymap_set("c", "/", smart_cmd_slash, { expr = true })

  -- keymap_set("n", "<F1>", "<Nop>", { noremap = true })
  keymap_set("i", "<F1>", "<Nop>", { noremap = true })
  keymap_set("n", "Q", "<Nop>", { noremap = true })

  keymap_set("n", "<Leader>q", "<cmd>q<CR><ESC>", { noremap = true })
  keymap_set("n", "<Leader>w", "<cmd>w<CR><ESC>", { noremap = true })
  keymap_set("n", "<Leader>z", "<cmd>qa!<CR><ESC>", { noremap = true })

  cmd([[cabbrev w!! w !sudo tee % > /dev/null]])

  -- 切换布局快捷键
  keymap_set("n", "<C-J>", "<C-W><C-J>", { noremap = true })
  keymap_set("n", "<C-K>", "<C-W><C-K>", { noremap = true })
  keymap_set("n", "<C-L>", "<C-W><C-L>", { noremap = true })
  keymap_set("n", "<C-H>", "<C-W><C-H>", { noremap = true })

  keymap_set("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j']], { expr = true, noremap = true })
  keymap_set("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k']], { expr = true, noremap = true })

  -- 替换行首行尾快捷键
  keymap_set("", "H", "^", { noremap = true })
  keymap_set("", "L", "g_", { noremap = true })

  -- 命令行模式增强
  keymap_set("c", "<C-P>", "<Up>", { noremap = true })
  keymap_set("c", "<C-N>", "<Down>", { noremap = true })
  keymap_set("c", "<C-B>", "<Left>", { noremap = true })
  keymap_set("c", "<C-F>", "<Right>", { noremap = true })
  keymap_set("c", "<C-A>", "<Home>", { noremap = true })
  keymap_set("c", "<C-E>", "<End>", { noremap = true })
  keymap_set("c", "<C-D>", "<Del>", { noremap = true })

  -- 插入模式增强
  keymap_set("i", "<C-B>", "<Left>", { noremap = true })
  keymap_set("i", "<C-F>", "<Right>", { noremap = true })
  keymap_set("i", "<C-A>", "<Home>", { noremap = true })
  keymap_set("i", "<C-E>", "<End>", { noremap = true })
  keymap_set("i", "<C-D>", "<Del>", { noremap = true })

  -- 搜索关键词居中
  keymap_set("n", "n", "nzz", { noremap = true })
  keymap_set("n", "N", "Nzz", { noremap = true })
  keymap_set("n", "<C-o>", "<C-o>zz", { noremap = true })
  keymap_set("n", "<C-i>", "<C-i>zz", { noremap = true })
  keymap_set("n", "<C-]>", "<C-]>zz", { noremap = true })

  keymap_set("n", "<Backspace>", "<Cmd>nohlsearch<CR>", { noremap = true })
  keymap_set({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { noremap = true })

  -- 调整缩进后自动选中
  keymap_set("v", "<", "<gv", { noremap = true })
  keymap_set("v", ">", ">gv", { noremap = true })

  -- 复制当前行号
  keymap_set("n", "<C-g>", show_current_line, { noremap = true })
  keymap_set("n", "<A-g>", show_current_dir, { noremap = true })

  -- 粘贴不覆盖
  keymap_set("x", "p", [['pgv"' . v:register . 'y']], { expr = true, noremap = true })

  -- 块粘贴修正
  keymap_set("", "<Leader>y", [[""y]], {})
  keymap_set("", "<Leader>d", [[""d]], {})
  keymap_set("", "<Leader>p", [[""p]], {})
  keymap_set("", "<Leader>P", [[""P]], {})

  keymap_set("n", "<Leader><Space>", "<cmd>vs<CR><ESC>", { noremap = true })

  keymap_set("n", "<Leader>bd", buf_only, { noremap = true, silent = true })

  keymap_set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {})

  keymap_set("x", "i<space>", [[:<c-u>normal! viW<CR>]], { noremap = true, silent = true })
  keymap_set("o", "i<space>", [[:normal viW<CR>]], { noremap = true, silent = true })
  keymap_set("x", "a<space>", [[:<c-u>normal! viW<CR>]], { noremap = true, silent = true })
  keymap_set("o", "a<space>", [[:normal viW<CR>]], { noremap = true, silent = true })

  keymap_set("", "<C-ScrollWheelUp>", "4zh", {})
  keymap_set("", "<C-ScrollWheelDown>", "4zl", {})

  vim.keymap.del("n", "grr")
  vim.keymap.del("n", "grn")
  vim.keymap.del({ "n", "x" }, "gra")
end

M.coc = function()
  local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    end

    return false
  end

  local smart_tab = function()
    if vim.fn["coc#pum#visible"]() == 1 then
      return vim.fn["coc#pum#next"](1)
    end

    if check_back_space() then
      return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
    end

    return vim.fn["coc#refresh"]()
  end

  local smart_shift_tab = function()
    if vim.fn["coc#pum#visible"]() == 1 then
      return vim.fn["coc#pum#prev"](1)
    end

    return vim.api.nvim_replace_termcodes("<C-h>", true, true, true)
  end

  _G.MUtils = {}
  MUtils.completion_confirm = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
      return vim.fn["coc#pum#confirm"]()
    else
      return require("nvim-autopairs").autopairs_cr()
    end
  end

  local show_documentation = function()
    if vim.fn.index({ "vim", "help" }, vim.opt.filetype:get()) >= 0 then
      vim.cmd([[execute 'h ' . expand('<cword>')]])
    elseif vim.fn["coc#rpc#ready"]() then
      vim.cmd([[call CocActionAsync('doHover')]])
    end
  end

  local toggle_outline = function()
    local winid = vim.fn["coc#window#find"]("cocViewId", "OUTLINE")
    if winid == -1 then
      vim.fn["CocActionAsync"]("showOutline", 1)
    else
      vim.fn["coc#window#close"](winid)
    end
  end

  keymap_set("i", "<C-d>", "coc#refresh()", { expr = true, noremap = true, silent = true })
  keymap_set("i", "<Tab>", smart_tab, { expr = true, noremap = true, silent = true })
  keymap_set("i", "<S-Tab>", smart_shift_tab, { expr = true, noremap = true })
  nvim_set_keymap("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })

  keymap_set("n", "[g", "m'<Plug>(coc-diagnostic-prev)", { silent = true })
  keymap_set("n", "]g", "m'<Plug>(coc-diagnostic-next)", { silent = true })

  keymap_set("n", "<leader>g", "<Plug>(coc-definition)", { silent = true })
  keymap_set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })

  keymap_set("n", "K", show_documentation, { noremap = true, silent = true })

  keymap_set("n", "<Leader>rn", [[<Plug>(coc-rename)]], {})
  keymap_set("n", "<Space>gf", "<Cmd>call CocActionAsync('codeAction', 'cursor', ['refactor.rewrite'])<CR>", { noremap = true, silent = true })

  keymap_set("x", "<Leader>af", [[<Plug>(coc-format-selected)]], {})
  keymap_set("n", "<Leader>af", [[<Plug>(coc-format)]], {})
  keymap_set("x", "<C-A-l>", [[<Plug>(coc-format-selected)]], {})
  keymap_set("n", "<C-A-l>", [[<Plug>(coc-format)]], {})
  keymap_set("n", "<C-A-o>", [[<Cmd>silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>]], { noremap = true, silent = true })

  keymap_set("n", "<C-f>", [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { expr = true, noremap = true, nowait = true, silent = true })
  keymap_set("n", "<C-b>", [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { expr = true, noremap = true, nowait = true, silent = true })
  keymap_set("n", "<C-d>", [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"]], { expr = true, noremap = true, nowait = true, silent = true })
  keymap_set("n", "<C-u>", [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"]], { expr = true, noremap = true, nowait = true, silent = true })

  keymap_set("n", "<F2>", toggle_outline, { noremap = true, nowait = true, silent = true })

  keymap_set("n", [[<Space>gtg]], [[<Cmd>CocCommand go.test.generate.function<CR>]], {})
  keymap_set("n", [[<Space>gtr]], [[<Cmd>GoTestFunc<CR>]], {})
end

M.telescope = function()
  local live_grep_args = function()
    require("telescope").extensions.live_grep_args.live_grep_args()
  end

  local grep_from_selected = function()
    local lines = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })

    if #lines ~= 1 then
      vim.api.nvim_input("<Esc>")
      return
    end

    local word = lines[1]

    if not word or word == "" then
      vim.api.nvim_input("<Esc>")
      return
    end

    require("telescope.builtin").grep_string({ search = word })
  end

  keymap_set("n", "<Leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true })
  keymap_set("n", "<Leader>fg", live_grep_args, { noremap = true })
  keymap_set("n", "<Leader>fm", [[<Cmd>Telescope custom mru<CR>]], { noremap = true })
  keymap_set("n", "<Leader>fc", [[<Cmd>Telescope grep_string<CR>]], { noremap = true })
  keymap_set("v", "<Leader>fc", grep_from_selected, { noremap = true, silent = true })
  keymap_set("n", "<Leader>fb", [[<Cmd>Telescope buffers<CR>]], { noremap = true })

  keymap_set("n", "gr", [[<Cmd>Telescope coc references initial_mode=normal<CR>]], { silent = true })
  keymap_set("n", "gi", [[<Cmd>Telescope coc implementations initial_mode=normal<CR>]], { silent = true })
end

M.init = function()
  vim.defer_fn(function()
    M.general()
    M.coc()
    M.telescope()
  end, 0)
end

M.init()
