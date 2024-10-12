local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")

local fn = vim.fn
local CocAction = fn.CocAction

local function is_ready(feature)
  if vim.g.coc_service_initialized ~= 1 then
    print("Coc is not ready!")
    return
  end

  if feature and not fn.CocHasProvider(feature) then
    print("Coc: server does not support " .. feature)
    return
  end

  return true
end

local function locations_to_items(locs)
  local items = {}
  for _, l in ipairs(locs) do
    if l.targetUri and l.targetRange then
      l.uri = l.targetUri
      l.range = l.targetRange
    end

    local bufnr = vim.uri_to_bufnr(l.uri)
    vim.fn.bufload(bufnr)
    local filename = vim.uri_to_fname(l.uri)
    local row = l.range.start.line
    local line = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { "" })[1]

    -- TODO: 限定golang
    -- if filename:match(".*_test%.go") then
    --   goto continue
    -- end

    -- if filename:match(".*/mocks/.*") then
    --   goto continue
    -- end

    items[#items + 1] = {
      filename = filename,
      lnum = row + 1,
      col = l.range.start.character + 1,
      text = line,
    }

    ::continue::
  end

  return items
end

local function gen_from_quickfix_custom(opts)
  opts = opts or {}

  local make_display = function(entry)
    local display_string = "%s:%s"
    local display_filename = utils.transform_path(opts, entry.filename)
    local coordinates = string.format("%s:%s", entry.lnum, entry.col)

    local display, hl_group, icon = utils.transform_devicons(entry.filename, string.format(display_string, display_filename, coordinates), false)

    if hl_group then
      icon = icon or " "
      return display, { { { 0, #icon }, hl_group } }
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

  local defs = CocAction(opts.coc_action)
  if type(defs) ~= "table" then
    return
  end

  if vim.tbl_isempty(defs) then
    print(("No %s found"):format(opts.coc_action))
  elseif #defs == 1 then
    vim.lsp.util.jump_to_location(defs[1])
  else
    local results = locations_to_items(defs)
    if not results then
      return
    end
    pickers
      .new(opts, {
        prompt_title = opts.coc_title,
        previewer = conf.qflist_previewer(opts),
        sorter = conf.generic_sorter(opts),
        finder = finders.new_table({
          results = results,
          entry_maker = gen_from_quickfix_custom(opts),
        }),
        push_cursor_on_edit = true,
      })
      :find()
  end
end

local function implementations(opts)
  opts.coc_provider = "implementation"
  opts.coc_action = "implementations"
  opts.coc_title = "Coc Implementations"
  list_or_jump(opts)
end

local function references(opts)
  if not is_ready("reference") then
    return
  end

  local excludeDeclaration = true
  local refs = CocAction("references", excludeDeclaration)
  if type(refs) ~= "table" or vim.tbl_isempty(refs) then
    return
  end

  local results = locations_to_items(refs)
  if not results then
    return
  end

  if #results == 0 then
    return
  end

  pickers
    .new(opts, {
      prompt_title = "Coc References",
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      finder = finders.new_table({
        results = results,
        entry_maker = gen_from_quickfix_custom(opts),
      }),
      push_cursor_on_edit = true,
    })
    :find()
end

return require("telescope").register_extension({
  exports = {
    references = references,
    implementations = implementations,
  },
})
