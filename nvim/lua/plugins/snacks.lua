return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope mru" },
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep_args" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        { pane = 2, width = 42, text = { require("pkg.utils.os").exec("lunar 2>/dev/null"), hl = "SnacksDashboardFooter", align = "center" } },
      },
    }

    opts.notifier = {
      style = "fancy",
    }
  end,
}
