local vim = vim
local Path = require("plenary.path")
local transform_mod = require("telescope.actions.mt").transform_mod
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local utils = require("telescope.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function delete_bookmark(entry)
  local bookmark = vim.fn["bm#get_bookmark_by_line"](entry.filename, tonumber(entry.lnum))
  vim.fn["bm_sign#del"](entry.filename, tonumber(bookmark.sign_idx))
  vim.fn["bm#del_bookmark_at_line"](entry.filename, tonumber(entry.lnum))
end

local delete_at_cursor = function(prompt_bufnr)
  local selectedEntry = action_state.get_selected_entry()
  delete_bookmark(selectedEntry)
end

local bookmark_actions = transform_mod({
  delete_at_cursor = delete_at_cursor,
})

local function get_bookmarks(files)
  local bookmarks = {}

  local cwd = vim.loop.cwd() .. Path.path.sep

  for _, file in ipairs(files) do
    local p = Path:new(file)
    local lowerPrefix = file:sub(1, #cwd):gsub(Path.path.sep, ""):lower()
    local lowerCWD = cwd:gsub(Path.path.sep, ""):lower()

    if lowerCWD == lowerPrefix and p:exists() and p:is_file() then
      for _, line in ipairs(vim.fn["bm#all_lines"](file)) do
        local bookmark = vim.fn["bm#get_bookmark_by_line"](file, line)

        local text = bookmark.annotation ~= "" and "NOTE: " .. bookmark.annotation or bookmark.content
        if text == "" then
          text = "(empty line)"
        end

        table.insert(bookmarks, {
          filename = file,
          lnum = tonumber(line),
          col = 1,
          text = text,
        })
      end
    end
  end

  return bookmarks
end

local function make_entry_from_bookmarks(opts)
  opts = opts or {}

  local make_display = function(entry)
    local display_string = "%s:%s"
    local display_filename = utils.transform_path(opts, entry.filename)
    local coordinates = string.format("%s: %s", entry.lnum, entry.text)

    local display, hl_group = utils.transform_devicons(entry.filename, string.format(display_string, display_filename, coordinates), false)

    if hl_group then
      return display, { { { 1, 3 }, hl_group } }
    else
      return display
    end
  end

  return function(entry)
    return {
      valid = true,
      value = entry,
      ordinal = entry.filename .. " " .. entry.text,
      display = make_display,
      filename = entry.filename,
      lnum = entry.lnum,
      col = 1,
      text = entry.text,
    }
  end
end

local function make_bookmark_picker(filenames, opts)
  opts = opts or {}

  local make_finder = function()
    local bookmarks = get_bookmarks(filenames)

    if vim.tbl_isempty(bookmarks) then
      print("No bookmarks!")
      return
    end

    return finders.new_table({
      results = bookmarks,
      entry_maker = make_entry_from_bookmarks(opts),
    })
  end

  local initial_finder = make_finder()
  if not initial_finder then
    return
  end

  pickers
    .new(opts, {
      prompt_title = "vim-bookmarks",
      finder = initial_finder,
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        local refresh_picker = function()
          local new_finder = make_finder()
          if new_finder then
            action_state.get_current_picker(prompt_bufnr):refresh(new_finder)
          else
            actions.close(prompt_bufnr)
          end
        end

        map("n", "dd", bookmark_actions.delete_at_cursor)
        bookmark_actions.delete_at_cursor:enhance({ post = refresh_picker })

        return true
      end,
    })
    :find()
end

local all = function(opts)
  make_bookmark_picker(vim.fn["bm#all_files"](), opts)
end

return require("telescope").register_extension({
  exports = {
    all = all,
  },
})
