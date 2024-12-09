local filename = ".vim/settings.json"

local load_try = function(dir)
  local file = require("pkg.utils.file")

  local data = file.load_json_file(file.join(dir, filename))
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

return M
