local conf = require("telescope.config").values
local finders = require("telescope.finders")
local lo = require("pkg.utils.lo")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local telescope = require("telescope")

local strings = require("pkg.utils.strings")

local mru = function(opts)
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local cwd = (vim.loop.cwd() or opts.cwd) .. "/"
  local limit = opts.limit or 20

  local files = require("pkg.utils.mru").load()

  files = lo.filter(files, function(file)
    return strings.has_prefix(file, cwd)
  end)

  local results = {}
  local seen = {}

  for _, file in ipairs(files) do
    local file_stat = vim.loop.fs_stat(file)
    if file_stat and file_stat.type == "file" and not seen[file] and file ~= current_file then
      table.insert(results, file)
      seen[file] = true
    end

    if #results >= limit then
      break
    end
  end

  pickers
    .new(opts, {
      prompt_title = "MRU",
      finder = finders.new_table({
        results = results,
        entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
      }),
      sorter = conf.file_sorter(opts),
      previewer = conf.grep_previewer(opts),
    })
    :find()
end

return telescope.register_extension({
  exports = {
    mru = mru,
  },
})
