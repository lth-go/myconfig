local S = {}

function S:new(data, meta)
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.data = data or {}
  o.meta = meta or {}

  return o
end

function S:get(key)
  local keys = vim.split(key, ".", { plain = true })

  local value = self.data

  for _, k in ipairs(keys) do
    value = value[k]

    if value == nil then
      break
    end
  end

  return value
end

--
--
--

local _filename = ".vim/settings.json"

local load_try = function(dir)
  local utils = require("pkg.utils")

  local data = utils.load_json_file(vim.fs.joinpath(dir, _filename))
  if data == nil then
    return nil
  end

  return data
end

local load_recursive = function()
  local dir = vim.fn.getcwd()

  for _ = 1, 5 do
    if dir == "/" then
      break
    end

    local data = load_try(dir)
    if data then
      local meta = { dir = dir }

      return S:new(data, meta)
    end

    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return S:new()
end

--
--
--

local M = {
  settings = S:new(),
  is_loaded = false,
}

M.load = function()
  if M.is_loaded then
    return M.settings
  end

  M.settings = load_recursive()
  M.is_loaded = true

  return M.settings
end

M.get = function(key)
  return M.load():get(key)
end

--
--
--

M.path_display = function(filename)
  if not filename then
    return filename
  end

  local path_replace = M.get("picker.path_replace")
  if path_replace == nil then
    return filename
  end

  for _, item in ipairs(path_replace) do
    local s, count = string.gsub(filename, item.prefix, item.replace)
    if count > 0 then
      return s
    end
  end

  return filename
end

return M
