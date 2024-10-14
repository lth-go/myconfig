return {
  "rebelot/heirline.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        local get_bufs = function()
          local bufline = require("heirline").eval_tabline()
          local pattern = [[%%(%d+)@v:lua.heirline_tabline_close_buffer_callback]]

          local matches = {}

          for match in string.gmatch(bufline, pattern) do
            table.insert(matches, tonumber(match))
          end

          return matches
        end

        for i = 1, 9, 1 do
          maps.n[string.format("<Leader>%s", i)] = function()
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

        maps.n["<Leader>bd"] = {
          function()
            local current_buf_map = {}

            for _, win in ipairs(vim.api.nvim_list_wins()) do
              current_buf_map[vim.api.nvim_win_get_buf(win)] = true
            end

            for _, bufnr in ipairs(vim.t.bufs) do
              if not current_buf_map[bufnr] then
                require("astrocore.buffer").close(bufnr, false)
              end
            end
          end,
        }

        return opts
      end,
    },
  },
  opts = function(_, opts)
    local astro = require("astrocore")
    local extend_tbl = astro.extend_tbl
    local condition = require("astroui.status.condition")
    local provider = require("astroui.status.provider")
    local status = require("astroui.status")
    local status_utils = require("astroui.status.utils")

    provider.ruler = function(opts)
      opts = extend_tbl({ pad_ruler = { line = 3, char = 2 } }, opts)
      local padding_str = ("%%%dd/%%-%dd"):format(opts.pad_ruler.line, opts.pad_ruler.char)
      return function()
        local line = vim.fn.line(".")
        local char = vim.fn.line("$")
        return status_utils.stylize(padding_str:format(line, char), opts)
      end
    end

    opts.winbar = nil
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.file_info({ file_icon = { padding = { left = 0, right = 1 } }, filename = { modify = ":~:.", condition = condition.is_file }, filetype = false }),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info({}),
      status.component.fill(),
      status.component.nav({ percentage = false }),
      status.component.mode({ surround = { separator = "right" } }),
    }

    return opts
  end,
}
