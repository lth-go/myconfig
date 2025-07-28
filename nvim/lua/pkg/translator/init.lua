local M = {
  opts = {
    proxy = nil,
  },
}

local function render(result)
  local lines = {}

  table.insert(lines, result.text)
  table.insert(lines, "---")

  if result.phonetic then
    table.insert(lines, "`[" .. result.phonetic .. "]`")
  end

  if result.paraphrase then
    table.insert(lines, "`" .. result.paraphrase .. "`")
  end

  if #result.explains > 0 then
    table.insert(lines, "---")

    if result.explains then
      for _, x in ipairs(result.explains) do
        table.insert(lines, "`" .. x .. "`")
      end
    end
  end

  local util = require("vim.lsp.util")
  local floating_bufnr = util.open_floating_preview(lines, "markdown", { border = "rounded" })
  vim.bo[floating_bufnr].modifiable = true
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
