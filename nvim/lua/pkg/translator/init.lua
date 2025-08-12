local M = {
  opts = {
    proxy = nil,
  },
}

local namespace = vim.api.nvim_create_namespace("nvim-translator")

local function render(result)
  local lines = {}
  local highlights = {}
  local index = 0

  local text = result.text

  if #text > 30 then
    text = string.sub(text, 1, 30) .. "..."
  end

  table.insert(lines, text)
  table.insert(highlights, {
    group = "Yellow",
    line = index,
    col = 0,
    end_col = #text,
  })
  index = index + 1

  table.insert(lines, "---")
  table.insert(highlights, {
    padding = true,
    group = "Comment",
    line = index,
    col = 0,
    end_col = 0,
  })
  index = index + 1

  if result.phonetic then
    table.insert(lines, "[" .. result.phonetic .. "]")
    table.insert(highlights, {
      group = "Orange",
      line = index,
      col = 1,
      end_col = #result.phonetic + 1,
    })
    index = index + 1
  end

  if result.paraphrase then
    table.insert(lines, result.paraphrase)
    index = index + 1
  end

  if #result.explains > 0 then
    table.insert(lines, "---")
    table.insert(highlights, {
      padding = true,
      group = "Comment",
      line = index,
      col = 0,
      end_col = 0,
    })
    index = index + 1

    for _, x in ipairs(result.explains) do
      for part_of_speech, s in pairs(x) do
        table.insert(lines, part_of_speech .. ". " .. table.concat(s, "; "))
        table.insert(highlights, {
          group = "Red",
          line = index,
          col = 0,
          end_col = #part_of_speech + 1,
        })
        index = index + 1
      end
    end
  end

  local util = require("vim.lsp.util")
  local floating_bufnr, floating_winnr = util.open_floating_preview(lines, "", { border = "rounded" })
  vim.bo[floating_bufnr].modifiable = true

  vim.api.nvim_buf_clear_namespace(floating_bufnr, namespace, 0, -1)

  vim.schedule(function()
    local width = vim.api.nvim_win_get_width(floating_winnr)

    for _, hl in ipairs(highlights) do
      if hl.padding then
        vim.api.nvim_buf_set_lines(floating_bufnr, hl.line, hl.line + 1, false, { string.rep("-", width) })
        hl.end_col = width
      end

      vim.highlight.range(floating_bufnr, namespace, hl.group, { hl.line, hl.col }, { hl.line, hl.end_col })
    end
  end)
end

M.setup = function(opts)
  if opts.proxy then
    M.opts.proxy = opts.proxy
  end

  vim.keymap.set("n", "<leader>t", function()
    local text = vim.fn.expand("<cword>")

    require("pkg/translator/google").translate(text, M.opts, render)
  end)

  vim.keymap.set("v", "<leader>t", function()
    local texts = M.get_visual_selection()

    local mode = vim.fn.mode():sub(1, 1)
    vim.cmd("normal! " .. mode)

    local text = table.concat(texts, " ")

    require("pkg/translator/google").translate(text, M.opts, render)
  end)
end

M.get_visual_selection = function()
  return vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
end

return M
