local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")
local Path = require("plenary.path")
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
    local line = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { "" })[1]
    items[#items + 1] = {
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

    local display, hl_group = utils.transform_devicons(entry.filename, string.format(display_string, display_filename, coordinates), false)

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

local gen_from_mru = function(opts)
  local make_display = function(entry)
    local display, hl_group = utils.transform_devicons(entry.value, entry.value, false)

    if hl_group then
      return display, { { { 1, 3 }, hl_group } }
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
    pickers.new(opts, {
      prompt_title = opts.coc_title,
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      finder = finders.new_table({
        results = results,
        entry_maker = gen_from_quickfix_custom(opts),
      }),
    }):find()
  end
end

local mru = function(opts)
  if not is_ready() then
    return
  end

  local home = vim.call("coc#util#get_data_home")
  local data = Path:new(home .. Path.path.sep .. "mru"):read()
  if not data or #data == 0 then
    return
  end

  local results = {}
  local exists = {}
  local cwd = vim.loop.cwd() .. Path.path.sep

  for _, val in ipairs(utils.max_split(data, "\n")) do
    local p = Path:new(val)
    local lowerPrefix = val:sub(1, #cwd):gsub(Path.path.sep, ""):lower()
    local lowerCWD = cwd:gsub(Path.path.sep, ""):lower()
    if lowerCWD == lowerPrefix and p:exists() and p:is_file() then
      local v = val:sub(#cwd + 1)
      if not exists[v] then
        results[#results + 1] = v
        exists[v] = true
      end
    end
  end

  pickers.new(opts, {
    prompt_title = "Coc MRU",
    sorter = conf.generic_sorter(opts),
    previewer = conf.qflist_previewer(opts),
    finder = finders.new_table({
      results = results,
      entry_maker = gen_from_mru(opts),
    }),
  }):find()
end

local implementations = function(opts)
  opts.coc_provider = "implementation"
  opts.coc_action = "implementations"
  opts.coc_title = "Coc Implementations"
  list_or_jump(opts)
end

local references = function(opts)
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

  pickers.new(opts, {
    prompt_title = "Coc References",
    previewer = conf.qflist_previewer(opts),
    sorter = conf.generic_sorter(opts),
    finder = finders.new_table({
      results = results,
      entry_maker = gen_from_quickfix_custom(opts),
    }),
  }):find()
end

return require("telescope").register_extension({
  exports = {
    mru = mru,
    references = references,
    implementations = implementations,
  },
})
