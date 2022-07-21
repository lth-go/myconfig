local vim = vim

local M = {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
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
-- mkdir
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

--
-- smart_enter
--
M.smart_enter = function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["coc#_select_confirm"]()
  else
    return t([[<C-g>u<CR><C-r>=coc#on_enter()<CR>]])
  end
end

--
-- show_documentation
--
M.show_documentation = function()
  if vim.fn.index({ "vim", "help" }, vim.opt.filetype:get()) >= 0 then
    vim.cmd([[execute 'h ' . expand('<cword>')]])
  elseif vim.fn["coc#rpc#ready"]() then
    vim.cmd([[call CocActionAsync('doHover')]])
  end
end

--
-- grep_from_selected
--
M.grep_from_selected = function()
  local word = M.get_visual_selection()

  if not word or word == "" then
    return
  end

  require("telescope.builtin").grep_string({ search = word })
end

return M
