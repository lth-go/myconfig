local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local path = require("plenary.path")
local make_entry = require("telescope.make_entry")

---@return boolean
local function buf_in_cwd(bufname, cwd)
  if cwd:sub(-1) ~= path.path.sep then
    cwd = cwd .. path.path.sep
  end
  local bufname_prefix = bufname:sub(1, #cwd)
  return bufname_prefix == cwd
end

local function oldfiles(opts)
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local cwd = vim.loop.cwd()
  local results = {}

  for _, file in ipairs(vim.v.oldfiles) do
    local file_stat = vim.loop.fs_stat(file)
    if file_stat and file_stat.type == "file" and not vim.tbl_contains(results, file) and file ~= current_file and buf_in_cwd(file, cwd) then
      table.insert(results, file)
    end
  end

  pickers
    .new(opts, {
      prompt_title = "MRU",
      __locations_input = true,
      finder = finders.new_table({
        results = results,
        entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
      }),
      sorter = conf.file_sorter(opts),
      previewer = conf.grep_previewer(opts),
    })
    :find()
end

return require("telescope").register_extension({
  exports = {
    mru = oldfiles,
  },
})
