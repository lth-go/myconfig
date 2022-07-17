local present, feline = pcall(require, "feline")
if not present then
  return
end

local vim = vim

local default = {}

default.colors = {
  white = "#ebdbb2",
  darker_black = "#232323",
  black = "#282828", --  nvim bg
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
  line = "#2c2f30", -- for lines like vertsplit
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
  violet = "#a9a1e1",
}

-- statusline style
default.statusline_style = {
  left = "",
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

-- Initialize the components table
default.components = {
  active = {},
}

default.main_icon = {
  provider = default.statusline_style.main_icon,

  hl = {
    fg = default.colors.statusline_bg,
    bg = default.colors.blue,
  },

  right_sep = {
    str = default.statusline_style.right,
    hl = {
      fg = default.colors.blue,
      bg = default.colors.lightbg,
    },
  },
}

default.file_name = {
  provider = {
    name = "file_info",
    opts = {
      type = "relative",
    },
  },

  enabled = function(winid)
    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
  end,

  hl = {
    fg = default.colors.white,
    bg = default.colors.lightbg,
  },

  right_sep = {
    str = default.statusline_style.right,
    hl = { fg = default.colors.lightbg },
  },
}

default.diagnostic = {
  error = {
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

      return cnt .. lnum
    end,
    hl = { fg = default.colors.red },
    icon = "  ",
  },

  warning = {
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

      return cnt .. lnum
    end,
    hl = { fg = default.colors.yellow },
    icon = "  ",
  },

  white_space = {
    provider = function()
      if vim.api.nvim_buf_get_name(0) == "" then
        return ""
      end

      local lnum = vim.fn.search("\\s$", "nw")

      if lnum == 0 then
        return ""
      end

      return string.format("(L%d)", lnum)
    end,
    hl = { fg = default.colors.white },
    icon = "  ",
  },
}

default.coc_current_function = {
  provider = function()
    local func = vim.b["coc_current_function"] or ""
    return func .. " "
  end,
  hl = { fg = default.colors.white },
}

default.file_type = {
  provider = {
    name = "file_type",
    opts = {
      filetype_icon = true,
      case = "lowercase",
    },
  },
  left_sep = " ",
}

default.mode_colors = {
  ["n"] = { "NORMAL", default.colors.red },
  ["no"] = { "N-PENDING", default.colors.red },
  ["i"] = { "INSERT", default.colors.dark_purple },
  ["ic"] = { "INSERT", default.colors.dark_purple },
  ["t"] = { "TERMINAL", default.colors.green },
  ["v"] = { "VISUAL", default.colors.cyan },
  ["V"] = { "V-LINE", default.colors.cyan },
  [""] = { "V-BLOCK", default.colors.cyan },
  ["R"] = { "REPLACE", default.colors.orange },
  ["Rv"] = { "V-REPLACE", default.colors.orange },
  ["s"] = { "SELECT", default.colors.blue },
  ["S"] = { "S-LINE", default.colors.blue },
  [""] = { "S-BLOCK", default.colors.blue },
  ["c"] = { "COMMAND", default.colors.pink },
  ["cv"] = { "COMMAND", default.colors.pink },
  ["ce"] = { "COMMAND", default.colors.pink },
  ["r"] = { "PROMPT", default.colors.teal },
  ["rm"] = { "MORE", default.colors.teal },
  ["r?"] = { "CONFIRM", default.colors.teal },
  ["!"] = { "SHELL", default.colors.green },
}

default.chad_mode_hl = function()
  return {
    fg = default.mode_colors[vim.fn.mode()][2],
    bg = default.colors.one_bg,
  }
end

default.empty_space = {
  provider = " " .. default.statusline_style.left,
  hl = {
    fg = default.colors.one_bg2,
    bg = default.colors.statusline_bg,
  },
}

-- this matches the vi mode color
default.empty_spaceColored = {
  provider = default.statusline_style.left,
  hl = function()
    return {
      fg = default.mode_colors[vim.fn.mode()][2],
      bg = default.colors.one_bg2,
    }
  end,
}

default.mode_icon = {
  provider = default.statusline_style.vi_mode_icon,
  hl = function()
    return {
      fg = default.colors.statusline_bg,
      bg = default.mode_colors[vim.fn.mode()][2],
    }
  end,
}

default.empty_space2 = {
  provider = function()
    return " " .. default.mode_colors[vim.fn.mode()][1] .. " "
  end,
  hl = default.chad_mode_hl,
}

default.separator_right = {
  provider = default.statusline_style.left,
  enabled = function(winid)
    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
  end,
  hl = {
    fg = default.colors.grey,
    bg = default.colors.one_bg,
  },
}

default.separator_right2 = {
  provider = default.statusline_style.left,
  enabled = function(winid)
    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
  end,
  hl = {
    fg = default.colors.green,
    bg = default.colors.grey,
  },
}

default.position_icon = {
  provider = default.statusline_style.position_icon,
  enabled = function(winid)
    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
  end,
  hl = {
    fg = default.colors.black,
    bg = default.colors.green,
  },
}

default.current_line = {
  provider = function()
    return string.format(" %d/%d ", vim.fn.line("."), vim.fn.line("$"))
  end,

  hl = {
    fg = default.colors.green,
    bg = default.colors.one_bg,
  },
}

local function add_table(a, b)
  table.insert(a, b)
end

default.left = {}
default.middle = {}
default.right = {}

-- left
add_table(default.left, default.main_icon)
add_table(default.left, default.file_name)
add_table(default.left, default.diagnostic.error)
add_table(default.left, default.diagnostic.warning)
add_table(default.left, default.diagnostic.white_space)

-- right
add_table(default.right, default.coc_current_function)
add_table(default.right, default.file_type)
add_table(default.right, default.empty_space)
add_table(default.right, default.empty_spaceColored)
add_table(default.right, default.mode_icon)
add_table(default.right, default.empty_space2)
add_table(default.right, default.separator_right)
add_table(default.right, default.separator_right2)
add_table(default.right, default.position_icon)
add_table(default.right, default.current_line)

default.components.active[1] = default.left
default.components.active[2] = default.middle
default.components.active[3] = default.right

feline.setup({
  theme = {
    bg = default.colors.statusline_bg,
    fg = default.colors.fg,
  },
  components = default.components,
  disable = {
    filetypes = {
      "^alpha$",
      "^coc%-explorer$",
      "^TelescopePrompt$",
      "^packer$",
      "^fugitive$",
      "^fugitiveblame$",
      "^qf$",
      "^help$",
    },
  },
})
