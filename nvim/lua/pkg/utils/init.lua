local M = {}

local uv = vim.uv

M.exists = function(filepath)
  local stat = uv.fs_stat(filepath)
  return stat ~= nil and stat.type ~= nil
end

M.read_file = function(filepath)
  if not M.exists(filepath) then
    return nil
  end
  local fd = assert(uv.fs_open(filepath, "r", 420)) -- 0644
  local stat = assert(uv.fs_fstat(fd))
  local data = uv.fs_read(fd, stat.size)
  uv.fs_close(fd)
  return data
end

M.load_json_file = function(filepath)
  local content = M.read_file(filepath)
  if content then
    return vim.json.decode(content, { luanil = { object = true } })
  end
end

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
