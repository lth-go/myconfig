local M = {}

local cmd = vim.cmd

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  -- all valid modes allowed for mappings
  -- :h map-modes
  local valid_modes = {
    [""] = true,
    ["n"] = true,
    ["v"] = true,
    ["s"] = true,
    ["x"] = true,
    ["o"] = true,
    ["!"] = true,
    ["i"] = true,
    ["l"] = true,
    ["c"] = true,
    ["t"] = true,
  }

  -- helper function for M.map
  -- can gives multiple modes and keys
  local function map_wrapper(sub_mode, lhs, rhs, sub_options)
    if type(lhs) == "table" then
      for _, key in ipairs(lhs) do
        map_wrapper(sub_mode, key, rhs, sub_options)
      end
    else
      if type(sub_mode) == "table" then
        for _, m in ipairs(sub_mode) do
          map_wrapper(m, lhs, rhs, sub_options)
        end
      else
        if valid_modes[sub_mode] and lhs and rhs then
          vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
        else
          sub_mode, lhs, rhs = sub_mode or "", lhs or "", rhs or ""
          print("Cannot set mapping [ mode = '" .. sub_mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]")
        end
      end
    end
  end

  map_wrapper(mode, keys, command, options)
end

--
-- buf_only
--
M.buf_only = function()
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

--
-- mkdir start
--
M.auto_mkdir = function()
  local dir = vim.fn.expand("%:p:h")

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

--
-- smart_cmd_slash
--
M.smart_cmd_slash = function()
  return vim.fn.pumvisible() == 1 and t("<Down>") or "/"
end

--
-- show current line
--
M.show_current_line = function()
  local msg = string.format("%s:%s", vim.fn.expand("%"), vim.fn.line("."))
  vim.fn.setreg("+", msg)
  print(msg)
end

--
-- start search
--
M.start_search = function()
  vim.opt.hlsearch = false

  local cword = vim.fn.expand("<cword>")

  if string.len(cword) == 0 then
    return
  end

  if string.sub(cword, 1, 2) ~= "\\<" then
    cword = "\\<" .. cword .. "\\>"
  end

  vim.fn.setreg("/", cword)

  vim.opt.hlsearch = true
end

M.v_start_search = function()
  vim.opt.hlsearch = false

  local save_reg = vim.fn.getreg("s")

  vim.cmd([[normal! gv"sy]])

  vim.fn.setreg("/", "\\V" .. vim.fn.substitute(vim.fn.escape(vim.fn.getreg("s"), "\\"), "\\n", "\\\\n", "g"))
  vim.fn.setreg("s", save_reg)

  vim.opt.hlsearch = true
end

--
-- smart tab
--
local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  end

  return false
end

M.smart_tab = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  else
    local col = vim.fn.col(".") - 1

    if check_back_space() then
      return t("<Tab>")
    else
      return vim.fn["coc#refresh"]()
    end
  end
end

M.smart_shift_tab = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  else
    return t("<C-h")
  end
end

M.smart_enter = function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["coc#_select_confirm"]()
  else
    return t([[<C-g>u<CR><C-r>=coc#on_enter()<CR>]])
  end
end

M.show_documentation = function()
  if vim.fn.index({ "vim", "help" }, vim.opt.filetype:get()) >= 0 then
    vim.cmd([[execute 'h ' . expand('<cword>')]])
  elseif vim.fn["coc#rpc#ready"]() then
    vim.cmd([[call CocActionAsync('doHover')]])
  end
end

M.get_selected = function(type)
  local saved_unnamed_register = vim.fn.getreg("@")

  if type == "v" then
    vim.cmd([[normal! `<v`>y]])
  elseif type == "char" then
    vim.cmd([[normal! `[v`]y]])
  else
    return
  end

  local word = vim.fn.substitute(vim.fn.getreg("@"), "\\n$", "", "g")
  word = vim.fn.escape(word, "| ")

  vim.fn.setreg("@", saved_unnamed_register)

  return word
end

M.grep_from_selected = function()
  local word = M.get_selected(vim.fn.visualmode())

  if word then
    vim.cmd([[Telescope grep_string search=]] .. word)
  end
end

return M
