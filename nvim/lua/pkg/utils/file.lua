local M = {}

local uv = vim.uv or vim.loop

M.sep = "/"

M.exists = function(filepath)
  local stat = uv.fs_stat(filepath)
  return stat ~= nil and stat.type ~= nil
end

M.join = function(...)
  return table.concat({ ... }, M.sep)
end

M.is_subpath = function(dir, path)
  return string.sub(path, 0, string.len(dir)) == dir
end

M.read_file = function(filepath)
  if not M.exists(filepath) then
    return nil
  end
  local fd = assert(uv.fs_open(filepath, "r", 420)) -- 0644
  local stat = assert(uv.fs_fstat(fd))
  local content = uv.fs_read(fd, stat.size)
  uv.fs_close(fd)
  return content
end

M.load_json_file = function(filepath)
  local content = M.read_file(filepath)
  if content then
    return vim.json.decode(content, { luanil = { object = true } })
  end
end

return M
