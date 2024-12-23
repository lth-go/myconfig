local M = {}

local uv = vim.uv

M.stat = function(filepath)
  local stat = uv.fs_stat(filepath)
  return stat
end

M.exists = function(filepath)
  local stat = uv.fs_stat(filepath)
  return stat ~= nil and stat.type ~= nil
end

M.join = function(...)
  return table.concat({ ... }, "/")
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

M.mkdir = function(dirname, perms)
  if not perms then
    perms = 493 -- 0755
  end
  if not M.exists(dirname) then
    local parent = vim.fn.fnamemodify(dirname, ":h")
    if not M.exists(parent) then
      M.mkdir(parent)
    end
    uv.fs_mkdir(dirname, perms)
  end
end

M.write_file = function(filename, contents)
  M.mkdir(vim.fn.fnamemodify(filename, ":h"))
  local fd = assert(uv.fs_open(filename, "w", 420)) -- 0644
  uv.fs_write(fd, contents)
  uv.fs_close(fd)
end

return M
