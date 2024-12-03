return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local dashboard = require("alpha.themes.dashboard")
    local get_icon = require("astroui").get_icon

    opts.section.header.val = {
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }

    opts.section.buttons.val = {
      dashboard.button("LDR f m", get_icon("DefaultFile", 2, true) .. "Recents  "),
      dashboard.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      dashboard.button("LDR f g", get_icon("WordFile", 2, true) .. "Find Word  "),
      dashboard.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
    }

    opts.config.layout = {
      { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
      opts.section.header,
      { type = "padding", val = 3 },
      opts.section.buttons,
      { type = "padding", val = 1 },
      opts.section.footer,
    }

    return opts
  end,
  config = function(_, opts)
    local exec = function(cmd)
      local handle = io.popen(cmd)
      if handle == nil then
        return ""
      end

      local out = handle:read("*a")
      handle:close()

      return out
    end

    opts.section.footer.val = vim.split(exec("lunar 2>/dev/null"), "\n")

    require("alpha").setup(opts.config)
  end,
}
