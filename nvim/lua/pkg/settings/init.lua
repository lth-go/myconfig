local _filename = ".vim/settings.json"

local load_try = function(dir)
  local file = require("pkg.utils.file")

  local data = file.load_json_file(file.join(dir, _filename))
  if data == nil then
    return nil
  end

  data.__meta__ = {
    dir = dir,
  }

  return data
end

local load_recursive = function()
  local dir = vim.fn.getcwd()

  for _ = 1, 3 do
    if dir == "/" then
      break
    end

    local data = load_try(dir)
    if data then
      return data
    end

    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

local M = {
  settings = nil,
  is_loaded = false,
}

M.load = function()
  if M.is_loaded then
    return M.settings
  end

  M.settings = load_recursive() or {}
  M.is_loaded = true

  return M.settings
end

--
--
--

M.path_display = function(filename)
  local settings = M.load()

  if settings == nil or settings.telescope == nil or settings.telescope.path_replace == nil then
    return filename
  end

  for _, item in ipairs(settings.telescope.path_replace) do
    if vim.startswith(filename, item.prefix) then
      return string.gsub(filename, item.prefix, item.replace)
    end
  end

  return filename
end

return M
