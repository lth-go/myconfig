local M = {}

M.uniq = function(list)
  local seen = {}
  local result = {}

  for _, item in ipairs(list) do
    if not seen[item] then
      table.insert(result, item)
      seen[item] = true
    end
  end

  return result
end

M.filter = function(list, predicate)
  return vim.tbl_filter(predicate, list)
end

return M
