local colors = {
  white = "#ebdbb2",
  darker_black = "#232323",
  black = "#282828",
  black2 = "#2e2e2e",
  one_bg = "#353535",
  one_bg2 = "#3f3f3f",
  one_bg3 = "#444444",
  grey = "#464646",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#505050",
  light_grey = "#565656",
  red = "#fb4934",
  baby_pink = "#cc241d",
  pink = "#ff75a0",
  line = "#2c2f30",
  green = "#b8bb26",
  vibrant_green = "#a9b665",
  nord_blue = "#83a598",
  blue = "#458588",
  yellow = "#d79921",
  sun = "#fabd2f",
  purple = "#b4bbc8",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#2c2c2c",
  lightbg = "#353535",
}

local statusline_style = {
  left = "",
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

local components = {
  active = {
    {},
    {},
    {},
  },
  inactive = {}
}

table.insert(components.active[1], {
  provider = statusline_style.main_icon,

  hl = {
    fg = colors.statusline_bg,
    bg = colors.nord_blue,
  },

  right_sep = {
    str = statusline_style.right,
    hl = {
     fg = colors.nord_blue,
     bg = colors.one_bg2,
    },
  },
})

table.insert(components.active[1], {
  provider = statusline_style.right,

  hl = {
    fg = colors.one_bg2,
    bg = colors.lightbg,
  },
})

table.insert(components.active[1], {
  provider = {
    name = "file_info",
    opts = {
      type = "relative",
    },
  },

  hl = {
    fg = colors.white,
    bg = colors.lightbg,
  },

  right_sep = {
    str = statusline_style.right,
    hl = {
      fg = colors.lightbg,
    },
  },
})

table.insert(components.active[1], {
  provider = function()
    if vim.bo.readonly then
      return "" .. " "
    else
      return ""
    end
  end,
})

-- coc

table.insert(components.active[1], {
  provider = function()
    local info = vim.b["coc_diagnostic_info"] or {}

    if vim.tbl_isempty(info) then
      return ""
    end

    local cnt = info["error"] or 0

    if cnt == 0 then
      return ""
    end

    local lnum = string.format("(L%d)", info["lnums"][1])

    return "  " .. cnt .. lnum
  end,

  hl = {
    fg = colors.red,
  },
})

table.insert(components.active[1], {
  provider = function()
    local info = vim.b["coc_diagnostic_info"] or {}

    if vim.tbl_isempty(info) then
      return ""
    end

    local cnt = info["warning"] or 0

    if cnt == 0 then
      return ""
    end

    local lnum = string.format("(L%d)", info["lnums"][2])

    return "  " .. cnt .. lnum
  end,

  hl = {
    fg = colors.yellow,
  },
})

table.insert(components.active[1], {
  provider = function()
    local lnum = vim.fn.search('\\s$', 'nw')

    if lnum == 0 then
      return ""
    end

    return "  " .. string.format("(L%d)", lnum)
  end,

  hl = {
    fg = colors.white
  },
})

table.insert(components.active[2], {
  provider = function()
    local text = vim.g['coc_status'] or ""

    if text == "" then
      return ""
    end

    local winwidth = 91
    local minwidth = 9

    if string.len(text) > winwidth then
      text = string.sub(text, 1, winwidth)
    end

    if vim.fn.winwidth(nr) < winwidth then
      return string.sub(text, 1, minwidth) .. "..."
    else
      return text
    end
  end,

  hl = {
    fg = colors.green,
  },
})

table.insert(components.active[3], {
  provider = function ()
    local func = vim.b["coc_current_function"] or ""
    return func .. " "
  end,

  hl = {
    fg = colors.white,
  },
})

table.insert(components.active[3], {
  provider = " " .. statusline_style.left,

  hl = {
    fg = colors.one_bg2,
    bg = colors.statusline_bg,
  },
})

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

table.insert(components.active[3], {
  provider = statusline_style.left,

  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg2,
    }
  end,
})

table.insert(components.active[3], {
  provider = statusline_style.vi_mode_icon,

  hl = function()
    return {
      fg = colors.statusline_bg,
      bg = mode_colors[vim.fn.mode()][2],
    }
  end,
})

table.insert(components.active[3], {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,

  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
    }
  end,
})

table.insert(components.active[3], {
  provider = statusline_style.left,

  hl = {
    fg = colors.grey,
    bg = colors.one_bg,
  },
})

table.insert(components.active[3], {
  provider = statusline_style.left,

  hl = {
    fg = colors.green,
    bg = colors.grey,
  },
})

table.insert(components.active[3], {
  provider = statusline_style.position_icon,

  hl = {
    fg = colors.black,
    bg = colors.green,
  },
})

table.insert(components.active[3], {
  provider = function()
    return string.format(' %d/%d ', vim.fn.line('.'), vim.fn.line('$'))
  end,

  hl = {
    fg = colors.green,
    bg = colors.one_bg,
  },
})

require("feline").setup {
  colors = {
    bg = colors.statusline_bg,
    fg = colors.fg,
  },
  components = components,
  force_inactive = {
    filetypes = {
      "coc-explorer",
      "vista",
    },
    buftypes = {},
    bufnames = {},
  },
}
