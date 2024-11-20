return {
  "folke/noice.nvim",
  init = function()
    local formatters = require("noice.text.format.formatters")

    function formatters.search_count(message, _, input)
      local content = input:content()

      local v = content:match(".*(%[%d+/%d+%])$")
      if v then
        content = v
      end

      message:append(content)
    end
  end,
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        cmdline = false,
        lua = false,
        help = false,
      },
    },
    lsp = {
      signature = {
        enabled = false,
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
    },
    views = {
      virtualtext = {
        format = { "{search_count}" },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "lines yanked" },
            { find = "more lines" },
            { find = "fewer lines" },
            { find = "E486: Pattern not found" },
          },
        },
        view = "mini",
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = [[^\<.*\>$]] },
            { find = [[^\V.*]] },
            { find = "Already at newest change" },
          },
        },
        opts = {
          skip = true,
        },
      },
    },
  },
}
