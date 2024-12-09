local file = require("pkg.utils.file")
local lo = require("pkg.utils.lo")

local mru = {
  file = vim.fn.stdpath("data") .. "/mru",
  threshold = 500,
}

mru.load = function()
  local stat = file.stat(mru.file)
  if stat == nil then
    return {}
  end

  local content = file.read_file(mru.file)
  if content == nil then
    return {}
  end

  local files = vim.split(content, "\n")

  files = lo.uniq(vim.fn.reverse(lo.filter(files, function(item)
    return item ~= ""
  end)))

  if #files == 0 then
    return {}
  end

  local is_sync = false

  if stat.mtime.sec < (os.time() - 3600 * 3) then
    is_sync = is_sync or true
  end

  if #files > mru.threshold * 2 then
    is_sync = is_sync or true

    files = vim.list_slice(files, 1, mru.threshold)
  end

  if is_sync then
    mru.sync(vim.fn.reverse(vim.fn.copy(files)))
  end

  return files
end

mru.add = function(line)
  file.write_file_append(mru.file, line .. "\n")
end

mru.sync = function(lines)
  file.write_file(mru.file, table.concat(lines, "\n"))
end

return {
  load = mru.load,
  add = mru.add,
}
