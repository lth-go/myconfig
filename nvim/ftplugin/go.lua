local vim = vim
local api = vim.api
local keymap_set = vim.keymap.set
local opt_local = vim.opt_local

opt_local.expandtab = false

local exec = function(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return ""
  end

  local out = handle:read("*a")
  handle:close()

  return out
end

local decl_location = function(direction, cnt)
  local fname = vim.fn.expand("%:p")
  local tmpname

  if vim.bo.modified == true then
    tmpname = vim.fn.tempname()
    vim.fn.writefile(vim.fn.getline(1, "$"), tmpname)
    fname = tmpname
  end

  local cmd = {
    "motion",
    "-format",
    "json",
    "-file",
    fname,
    "-offset",
    vim.fn.line2byte(vim.fn.line(".")) + (vim.fn.col(".") - 2),
    "-shift",
    cnt,
    "-mode",
    direction,
  }

  local out = exec(table.concat(cmd, " ") .. " 2>/dev/null")

  if tmpname then
    os.remove(tmpname)
  end

  if out == "" then
    return 0
  end

  local result = vim.json.decode(out)
  if type(result) ~= "table" then
    return 0
  end

  return result
end

local decl_jump = function(direction)
  return function()
    local result = decl_location(direction, 0)

    if not result then
      return
    end

    if result == 0 then
      return
    end

    if result.err then
      return
    end

    local info = result.decl

    if not info then
      return
    end

    api.nvim_win_set_cursor(0, { info.name_pos.line, info.name_pos.col - 1 })
  end
end

keymap_set("n", "]]", decl_jump("decl_next"), { noremap = true, silent = true })
keymap_set("n", "[[", decl_jump("decl_prev"), { noremap = true, silent = true })
