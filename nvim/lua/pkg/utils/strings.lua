local M = {}

M.has_prefix = function(str, prefix)
  return str:sub(1, #prefix) == prefix
end

M.has_suffix = function(str, suffix)
  return str:sub(-#suffix) == suffix
end

return M
