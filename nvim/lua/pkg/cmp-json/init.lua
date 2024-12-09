local source = {}

---@return boolean
function source:is_available()
  local file_types = {
    "go",
  }

  return vim.tbl_contains(file_types, vim.bo.filetype)
end

---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
  local settings = require("pkg/settings").load()

  if settings == nil or settings.cmp == nil or settings.cmp[vim.bo.filetype] == nil then
    callback({})
    return
  end

  callback({
    items = settings.cmp[vim.bo.filetype].items,
  })
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
  if not completion_item.command or completion_item.command.command == "" then
    callback(completion_item)
    return
  end

  local cmds = { completion_item.command.command }

  if completion_item.command.arguments ~= nil then
    vim.list_extend(cmds, completion_item.command.arguments)
  end

  vim.cmd(table.concat(cmds, " "))

  callback(completion_item)
end

require("cmp").register_source("cmp-json", source)
