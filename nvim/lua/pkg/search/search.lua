local function build_search(value)
  value = value:gsub([[\]], [[\\]])
  return string.format("%s%s", [[\V]], value)
end

--- @class Search
--- @field winid        integer
--- @field bufnr        integer
--- @field reg          table     saved contents of the "/" register
--- @field start_cursor integer[]  original cursor position {row, col}
local Search = {}
Search.__index = Search

--- @return Search
function Search.new()
  return setmetatable({
    winid = vim.fn.win_getid(),
    bufnr = vim.fn.bufnr(),
    reg = vim.fn.getreginfo("/"),
    start_cursor = vim.api.nvim_win_get_cursor(0),
  }, Search)
end

function Search:reset_cursor()
  vim.api.nvim_win_set_cursor(self.winid, self.start_cursor)
end

function Search:restore_reg()
  vim.fn.setreg("/", self.reg)
end

function Search:set_history(value)
  local query = build_search(value)
  vim.fn.histadd("search", query)
end

function Search:set_jumplist()
  local cursor = vim.api.nvim_win_get_cursor(0)
  if cursor[1] == self.start_cursor[1] and cursor[2] == self.start_cursor[2] then
    return
  end

  self:reset_cursor()
  vim.cmd("normal! m'")
  vim.api.nvim_win_set_cursor(self.winid, cursor)
end

function Search:reset()
  self:restore_reg()
  self:reset_cursor()
  vim.v.hlsearch = 0
end

--- @param value string  current input value
function Search:on_change(value)
  vim.api.nvim_win_call(self.winid, function()
    if value == "" then
      self:reset()
      return
    end

    local query = build_search(value)
    vim.fn.setreg("/", query)
    self:reset_cursor()
    vim.v.hlsearch = 1

    local pos = vim.fn.searchpos(query, "cn")
    if pos[1] == 0 then
      return
    end

    vim.api.nvim_win_set_cursor(self.winid, { pos[1], pos[2] - 1 })
  end)
end

function Search:on_close()
  self:reset()
end

--- @param value string  submitted input value
function Search:on_submit(value)
  if #value == 0 then
    return
  end

  self:set_history(value)
  self:set_jumplist()
end

return Search
