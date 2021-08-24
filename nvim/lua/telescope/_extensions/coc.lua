local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local utils = require('telescope.utils')
local string = string
local vim = vim

local function is_ready(feature)
  local is_running = vim.call('coc#client#is_running', 'coc')
  if is_running ~= 1 then
    return false
  end
  local ready = vim.call('coc#rpc#ready')
  if ready ~= 1 then
    return false
  end

  local ok = true
  if feature then
    ok = vim.call('CocHasProvider', feature)
    if not ok then
      print("Coc: server does not support " .. feature)
    end
  end
  return ok
end

local locations_to_items = function(locs)
  local items = {}
  for _, l in ipairs(locs) do
    if l.targetUri and l.targetRange then
      -- LocationLink
      l.uri = l.targetUri
      l.range = l.targetRange
    end
    local bufnr = vim.uri_to_bufnr(l.uri)
    vim.fn.bufload(bufnr)
    local filename = vim.uri_to_fname(l.uri)
    local row = l.range.start.line
    local line = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or {""})[1]
    items[#items+1] = {
      filename = filename,
      lnum = row + 1,
      col = l.range.start.character + 1,
      text = line,
    }
  end

  return items
end

local gen_from_quickfix_custom = function(opts)
  opts = opts or {}

  local make_display = function(entry)
    local display_string = "%s:%s"
    local display_filename = utils.transform_path(opts, entry.filename)
    local coordinates = string.format("%s:%s", entry.lnum, entry.col)

    local display, hl_group = utils.transform_devicons(
        entry.filename,
        string.format(display_string, display_filename, coordinates),
        false
    )

    if hl_group then
        return display, { { { 1, 3 }, hl_group } }
    else
        return display
    end
  end

  return function(entry)
    local filename = entry.filename

    return {
      valid = true,

      value = entry,
      ordinal = (filename or "") .. " " .. entry.text,
      display = make_display,

      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.text,
    }
  end
end

local function list_or_jump(opts)
  if not is_ready(opts.coc_provider) then
    return
  end

  local defs = vim.call('CocAction', opts.coc_action)
  if type(defs) ~= 'table' or vim.tbl_isempty(defs) then
    return
  end

  if #defs == 1 then
    vim.lsp.util.jump_to_location(defs[1])
  else
    local results = locations_to_items(defs)
    pickers.new(opts, {
      prompt_title = opts.coc_title,
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      finder = finders.new_table {
        results = results,
        entry_maker = gen_from_quickfix_custom(opts),
      },
    }):find()
  end
end

local implementations = function(opts)
  opts.coc_provider = 'implementation'
  opts.coc_action = 'implementations'
  opts.coc_title = 'Coc Implementations'
  list_or_jump(opts)
end

local references = function(opts)
  if not is_ready('reference') then
    return
  end

  local refs = vim.call('CocAction', 'references')
  if type(refs) ~= 'table' or vim.tbl_isempty(refs) then
    return
  end

  local results = locations_to_items(refs)

  pickers.new(opts, {
    prompt_title = 'Coc References',
    previewer = conf.qflist_previewer(opts),
    sorter = conf.generic_sorter(opts),
    finder    = finders.new_table {
      results = results,
      entry_maker = gen_from_quickfix_custom(opts),
    },
  }):find()
end

return require('telescope').register_extension{
  exports = {
    references = references,
    implementations = implementations,
  },
}
