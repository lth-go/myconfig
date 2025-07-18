local get_bufs = function()
  local bufline = require("heirline").eval_tabline()
  local pattern = [[%%(%d+)@v:lua.heirline_tabline_close_buffer_callback]]

  local matches = {}

  for match in string.gmatch(bufline, pattern) do
    table.insert(matches, tonumber(match))
  end

  return matches
end

local go_to_buf = function(i)
  return function()
    local bufs = get_bufs()

    if i > #bufs then
      i = #bufs
    end

    local buf_id = bufs[i]
    if not buf_id then
      return
    end

    vim.api.nvim_set_current_buf(buf_id)
  end
end

--
--
--

local hijack = function()
  local astro = require("astrocore")
  local provider = require("astroui.status.provider")
  local status_utils = require("astroui.status.utils")

  provider.ruler = function(opts)
    return function()
      local line = vim.fn.line(".")
      local char = vim.fn.virtcol(".")
      local last_line = vim.fn.line("$")

      local padding_str = " %d/%d :%-3d"
      return status_utils.stylize(padding_str:format(line, last_line, char), opts)
    end
  end

  provider.showcmd = function(opts)
    local get_visual_selection = function()
      local row_start = vim.fn.getpos("v")[2]
      local row_end = vim.fn.getpos(".")[2]
      local col_start = vim.fn.virtcol("v")
      local col_end = vim.fn.virtcol(".")

      local a = { row = math.min(row_start, row_end), col = math.min(col_start, col_end) }
      local b = { row = math.max(row_start, row_end), col = math.max(col_start, col_end) }

      return a, b
    end

    opts = astro.extend_tbl({ minwid = 0, maxwid = 7, escape = false }, opts)

    return function()
      local begin_pos, end_pos = get_visual_selection()
      local mode = vim.fn.mode()

      if vim.tbl_contains({ "v" }, mode) then
        local row = end_pos.row - begin_pos.row + 1
        local col = end_pos.col - begin_pos.col + 1

        return status_utils.stylize(("%%%d.%d(%d%%)"):format(opts.minwid, opts.maxwid, row == 1 and col or row), opts)
      end

      if vim.tbl_contains({ "V" }, mode) then
        local row = end_pos.row - begin_pos.row + 1

        return status_utils.stylize(("%%%d.%d(%d%%)"):format(opts.minwid, opts.maxwid, row), opts)
      end

      if vim.tbl_contains({ "" }, mode) then
        local row = end_pos.row - begin_pos.row + 1
        local col = end_pos.col - begin_pos.col + 1

        return status_utils.stylize(("%%%d.%d(%dx%d%%)"):format(opts.minwid, opts.maxwid, row, col), opts)
      end

      return ""
    end
  end
end

--
--
--

local is_visual_mode = function()
  return vim.tbl_contains({ "v", "V", "" }, vim.fn.mode())
end

local is_search_count = function()
  local condition = require("astroui.status.condition")

  if not condition.is_hlsearch() then
    return false
  end

  local ok, search = pcall(vim.fn.searchcount)
  if not ok then
    return false
  end
  if type(search) ~= "table" then
    return false
  end
  if search.exact_match == 0 then
    return false
  end
  if search.total == 0 then
    return false
  end

  return true
end

--
--
--

return {
  "rebelot/heirline.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        for i = 1, 9, 1 do
          maps.n[string.format("<Leader>%s", i)] = go_to_buf(i)
        end

        return opts
      end,
    },
  },
  opts = function(_, opts)
    local condition = require("astroui.status.condition")
    local status = require("astroui.status")

    hijack()

    opts.winbar = nil
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.file_info({
        file_icon = {
          padding = {
            left = 0,
          },
        },
        filename = {
          modify = ":~:.",
          condition = condition.is_file,
        },
        filetype = false,
      }),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info({
        search_count = {
          condition = is_search_count,
        },
        showcmd = {
          condition = is_visual_mode,
        },
        surround = {
          condition = function()
            return condition.is_hlsearch() or condition.is_macro_recording() or is_visual_mode()
          end,
        },
      }),
      status.component.fill(),
      status.component.nav({ percentage = false, scrollbar = false }),
      status.component.mode({ surround = { separator = "right" } }),
    }

    return opts
  end,
}
