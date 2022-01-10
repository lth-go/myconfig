local M = {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--- Get the region between two marks and the start and end positions for the region
---
--@param mark1 Name of mark starting the region
--@param mark2 Name of mark ending the region
--@param options Table containing the adjustment function, register type and selection mode
--@return region region between the two marks, as returned by |vim.region|
--@return start (row,col) tuple denoting the start of the region
--@return finish (row,col) tuple denoting the end of the region
M.get_marked_region = function(mark1, mark2, options)
  local bufnr = 0
  local adjust = options.adjust or function(pos1, pos2)
    return pos1, pos2
  end
  local regtype = options.regtype or vim.fn.visualmode()
  local selection = options.selection or (vim.o.selection ~= "exclusive")

  local pos1 = vim.fn.getpos(mark1)
  local pos2 = vim.fn.getpos(mark2)
  pos1, pos2 = adjust(pos1, pos2)

  local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
  local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

  -- Return if start or finish are invalid
  if start[2] < 0 or finish[1] < start[1] then
    return
  end

  local region = vim.region(bufnr, start, finish, regtype, selection)
  return region, start, finish
end

--- Get the current visual selection as a string
---
--@return selection string containing the current visual selection
M.get_visual_selection = function()
  local bufnr = 0
  local visual_modes = {
    v = true,
    V = true,
    -- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
  }

  -- Return if not in visual mode
  if visual_modes[vim.api.nvim_get_mode().mode] == nil then
    return
  end

  local options = {}
  options.adjust = function(pos1, pos2)
    if vim.fn.visualmode() == "V" then
      pos1[3] = 1
      pos2[3] = 2 ^ 31 - 1
    end

    if pos1[2] > pos2[2] then
      pos2[3], pos1[3] = pos1[3], pos2[3]
      return pos2, pos1
    elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
      return pos2, pos1
    else
      return pos1, pos2
    end
  end

  local region, start, finish = M.get_marked_region("v", ".", options)

  -- Compute the number of chars to get from the first line,
  -- because vim.region returns -1 as the ending col if the
  -- end of the line is included in the selection
  local lines = vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
  local line1_end
  if region[start[1]][2] - region[start[1]][1] < 0 then
    line1_end = #lines[1] - region[start[1]][1]
  else
    line1_end = region[start[1]][2] - region[start[1]][1]
  end

  lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
  if start[1] ~= finish[1] then
    lines[#lines] = vim.fn.strpart(lines[#lines], region[finish[1]][1], region[finish[1]][2] - region[finish[1]][1])
  end
  return table.concat(lines)
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
-- star search
--
M.star_search = function()
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

M.v_star_search = function()
  vim.opt.hlsearch = false

  local word = M.get_visual_selection()

  if not word or word == "" then
    return
  end

  vim.fn.setreg("/", "\\V" .. vim.fn.substitute(vim.fn.escape(word, "\\"), "\\n", "\\\\n", "g"))

  vim.opt.hlsearch = true

  vim.api.nvim_input("o<Esc>")
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
