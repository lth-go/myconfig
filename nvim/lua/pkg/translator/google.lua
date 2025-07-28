local M = {}

M.translate = function(text, opts, handler)
  if not text or text == "" then
    return
  end

  text = string.gsub(text, "\n", " ")

  local sl = opts.sl or "auto"
  local tl = opts.tl or "zh"

  local url = "https://translate.googleapis.com/translate_a/single"

  local req_opts = {
    proxy = opts.proxy,
    query = {
      client = "gtx",
      sl = sl,
      tl = tl,
      dt = { "at", "bd", "ex", "ld", "md", "qca", "rw", "rm", "ss", "t" },
      q = text,
    },
  }

  require("pkg.translator.requests").get(url, req_opts, function(body)
    local data = vim.json.decode(body)

    -- 0:  translation
    -- 1:  all-translations
    -- 2:  original-language
    -- 5:  possible-translations
    -- 6:  confidence
    -- 7:  possible-mistakes
    -- 8:  language
    -- 11: synonyms
    -- 12: definitions
    -- 13: examples
    -- 14: see-also

    local result = {
      ["text"] = text,
      ["phonetic"] = M.get_phonetic(data),
      ["paraphrase"] = M.get_paraphrase(data),
      ["explains"] = M.get_explains(data),
    }

    handler(result)
  end)
end

-- 音标
M.get_phonetic = function(data)
  for _, x in ipairs(data[1]) do
    if #x == 4 then
      return x[4]
    end
  end
end

-- 简单释义
M.get_paraphrase = function(data)
  local s = {}

  for _, x in ipairs(data[1]) do
    if x[1] and x[1] ~= vim.NIL then
      table.insert(s, x[1])
    end
  end

  if #s == 0 then
    return nil
  end

  return table.concat(s, "\n")
end

-- 分行解释
M.get_explains = function(data)
  local explains = {}

  if data[2] and data[2] ~= vim.NIL then
    for _, x in ipairs(data[2]) do
      local expl = string.sub(x[1], 1, 1) .. ". "

      local s = {}

      for _, y in ipairs(x[3]) do
        table.insert(s, y[1])
      end

      table.insert(explains, expl .. table.concat(s, "; "))
    end
  end

  return explains
end

return M
