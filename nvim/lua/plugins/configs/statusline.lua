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
  lightbg2 = "#303030",
  pmenu_bg = "#83a598",
  folder_bg = "#83a598",
}

local statusline_style = {
  left = "",
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

-- Initialize the components table
local components = {
  left = { active = {}, inactive = {} },
  mid = { active = {}, inactive = {} },
  right = { active = {}, inactive = {} },
}

components.left.active[1] = {
  provider = statusline_style.main_icon,

  hl = {
    fg = colors.statusline_bg,
    bg = colors.nord_blue,
  },

  right_sep = { str = statusline_style.right, hl = {
    fg = colors.nord_blue,
    bg = colors.one_bg2,
  } },
}

components.left.active[2] = {
  provider = statusline_style.right,

  hl = {
    fg = colors.one_bg2,
    bg = colors.lightbg,
  },
}

components.left.active[3] = {
  provider = "file_info" ,

  type = "relative",

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
}

components.left.active[4] = {
  provider = function()
    if vim.bo.readonly then
      return "" .. " "
    else
      return ""
    end
  end,
}

-- coc

components.left.active[5] = {
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

  hl = { fg = colors.red },
}

components.left.active[6] = {
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

  hl = { fg = colors.yellow },
}

components.left.active[7] = {
  provider = function()
    local lnum = vim.fn.search('\\s$', 'nw')

    if lnum == 0 then
      return ""
    end

    return "  " .. string.format("(L%d)", lnum)
  end,

  hl = { fg = colors.white },
}

components.mid.active[1] = {
  provider = function()
    local status = vim.g['coc_status'] or ""
    return string.sub(status, 1, 90)
  end,

  hl = { fg = colors.green },
}

components.right.active[1] = {
  provider = function ()
    local func = vim.b["coc_current_function"] or ""
    return func .. " "
  end,

  hl = {
    fg = colors.white,
  },
}

components.right.active[2] = {
  provider = " " .. statusline_style.left,

  hl = {
    fg = colors.one_bg2,
    bg = colors.statusline_bg,
  },
}

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

components.right.active[3] = {
  provider = statusline_style.left,

  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg2,
    }
  end,
}

components.right.active[4] = {
  provider = statusline_style.vi_mode_icon,

  hl = function()
    return {
      fg = colors.statusline_bg,
      bg = mode_colors[vim.fn.mode()][2],
    }
  end,
}

components.right.active[5] = {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,

  hl = function()
    return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
    }
  end,
}

components.right.active[6] = {
  provider = statusline_style.left,

  hl = {
    fg = colors.grey,
    bg = colors.one_bg,
  },
}

components.right.active[7] = {
  provider = statusline_style.left,

  hl = {
    fg = colors.green,
    bg = colors.grey,
  },
}

components.right.active[8] = {
  provider = statusline_style.position_icon,

  hl = {
    fg = colors.black,
    bg = colors.green,
  },
}

components.right.active[9] = {
  provider = function()
    return string.format(' %d/%d ', vim.fn.line('.'), vim.fn.line('$'))
  end,

  hl = {
    fg = colors.green,
    bg = colors.one_bg,
  },
}

require("feline").setup {
  default_bg = colors.statusline_bg,
  default_fg = colors.fg,
  components = components,
  properties = {
    force_inactive = {
      filetypes = {
        "coc-explorer",
        "vista",
      },
      buftypes = {},
      bufnames = {},
    },
  },
}
