local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")
local path = require("plenary.path")
local make_entry = require("telescope.make_entry")
local string = string
local vim = vim

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

local function gen_from_mru(opts)
  local make_display = function(entry)
    local display, hl_group, icon = utils.transform_devicons(entry.value, entry.value, false)

    if hl_group then
      icon = icon or " "
      return display, { { { 0, #icon }, hl_group } }
    else
      return display
    end
  end

  return function(entry)
    return {
      valid = entry ~= nil,
      value = entry,
      ordinal = entry,
      display = make_display,
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

local function mru(opts)
  local home = vim.call("coc#util#get_data_home")
  local data = path:new(home .. path.path.sep .. "mru"):read()
  if not data or #data == 0 then
    return
  end

  local results = {}
  local exists = {}
  local cwd = vim.loop.cwd() .. path.path.sep

  for _, val in ipairs(utils.max_split(data, "\n")) do
    local p = path:new(val)
    local lowerPrefix = val:sub(1, #cwd):gsub(path.path.sep, ""):lower()
    local lowerCWD = cwd:gsub(path.path.sep, ""):lower()
    if lowerCWD == lowerPrefix and p:exists() and p:is_file() then
      local v = val:sub(#cwd + 1)
      if not exists[v] then
        results[#results + 1] = v
        exists[v] = true
      end
    end
  end

  pickers
    .new(opts, {
      prompt_title = "Coc MRU",
      sorter = conf.generic_sorter(opts),
      previewer = conf.qflist_previewer(opts),
      finder = finders.new_table({
        results = results,
        entry_maker = gen_from_mru(opts),
      }),
    })
    :find()
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

local function get_workspace_symbols_requester()
  return function(prompt)
    local results = {}
    local symbols = CocAction("getWorkspaceSymbols", prompt)
    if type(symbols) ~= "table" or vim.tbl_isempty(symbols) then
      return results
    end
    for _, s in ipairs(symbols) do
      local filename = vim.uri_to_fname(s.location.uri)
      local kind = vim.lsp.protocol.SymbolKind[s.kind] or "Unknown"
      results[#results + 1] = {
        filename = filename,
        lnum = s.location.range.start.line + 1,
        col = s.location.range.start.character + 1,
        kind = kind,
        text = string.format("[%s] %s", kind, s.name),
      }
    end
    return results
  end
end

local function workspace_symbols(opts)
  pickers
    .new(opts, {
      prompt_title = "Coc Workspace Symbols",
      finder = finders.new_dynamic({
        entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
        fn = get_workspace_symbols_requester(),
      }),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(),
    })
    :find()
end

return require("telescope").register_extension({
  exports = {
    mru = mru,
    references = references,
    implementations = implementations,
    workspace_symbols = workspace_symbols,
  },
})
