local M = {}

M.exec = function(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return ""
  end

  local out = handle:read("*a")
  handle:close()

  return out
end

return M
