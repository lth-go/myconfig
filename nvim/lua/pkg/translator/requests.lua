local M = {}

M.get = function(url, opts, on_response)
  local header = opts.header or {}

  if not header["User-Agent"] then
    header["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:141.0) Gecko/20100101 Firefox/141.0"
  end

  local args = { "curl" }

  vim.list_extend(args, { "--silent", "--show-error", "--fail" })

  local retry = opts.retry or 3
  vim.list_extend(args, { "--location", "--retry", tostring(retry) })

  if opts.proxy then
    vim.list_extend(args, { "--proxy", opts.proxy })
  end

  if opts.query then
    local s = {}

    for k, v in pairs(opts.query) do
      if type(v) == "table" then
        for _, vv in ipairs(v) do
          table.insert(s, k .. "=" .. vim.uri_encode(vv))
        end
      else
        table.insert(s, k .. "=" .. vim.uri_encode(v))
      end
    end

    url = url .. "?" .. table.concat(s, "&")
  end

  table.insert(args, url)

  local function on_exit(res)
    if res.code ~= 0 then
      local err_msg = (res.stderr ~= "" and res.stderr) or string.format("Request failed with exit code %d", res.code)

      vim.notify(err_msg, vim.log.levels.ERROR)
      return
    end

    if #res.stdout == 0 then
      return
    end

    if on_response then
      vim.schedule(function()
        on_response(res.stdout)
      end)
    end
  end

  vim.system(args, { text = true }, on_exit)
end

return M
