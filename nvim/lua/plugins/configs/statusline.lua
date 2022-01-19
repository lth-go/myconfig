local present, windline = pcall(require, "windline")

if not present then
  return
end

local basic_components = require("windline.components.basic")

local state = _G.WindLine.state

local statusline_style = {
  left_rounded = "",
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

local basic = {}

basic.divider = { basic_components.divider, "" }

basic.vi_mode = {
  hl_colors = {
    Normal = { "red", "one_bg", "bold" },
    Insert = { "green", "one_bg", "bold" },
    Visual = { "yellow", "one_bg", "bold" },
    Replace = { "blue_light", "one_bg", "bold" },
    Command = { "magenta", "one_bg", "bold" },
    NormalBefore = { "red", "one_bg2" },
    InsertBefore = { "green", "one_bg2" },
    VisualBefore = { "yellow", "one_bg2" },
    ReplaceBefore = { "blue_light", "one_bg2" },
    CommandBefore = { "magenta", "one_bg2" },
    NormalIcon = { "statusline_bg", "red" },
    InsertIcon = { "statusline_bg", "green" },
    VisualIcon = { "statusline_bg", "yellow" },
    ReplaceIcon = { "statusline_bg", "blue_light" },
    CommandIcon = { "statusline_bg", "magenta" },
  },

  text = function()
    return {
      { " " .. statusline_style.left_rounded, { "one_bg2" } },
      { statusline_style.left_rounded, state.mode[2] .. "Before" },
      { statusline_style.vi_mode_icon, state.mode[2] .. "Icon" },
      { " " .. state.mode[1] .. " ", state.mode[2] },
    }
  end,
}

local icon_comp = basic_components.cache_file_icon({ default = "", hl_colors = { "white", "lightbg" } })

local file_info = function()
  local filename = vim.api.nvim_buf_get_name(0)

  if filename == "" then
    return ""
  end

  filename = vim.fn.fnamemodify(filename, ":~:.")

  local extension = vim.fn.fnamemodify(filename, ":e")
  local readonly_str, modified_str

  if vim.bo.readonly then
    readonly_str = "🔒"
  else
    readonly_str = ""
  end

  if vim.bo.modified then
    modified_str = " ●"
  else
    modified_str = ""
  end

  return string.format(" %s%s%s ", readonly_str, filename, modified_str)
end

basic.file = {
  hl_colors = {
    default = { "white", "lightbg" },
  },
  text = function(bufnr)
    return {
      { statusline_style.right, { "one_bg2", "lightbg" } },
      icon_comp(bufnr),
      { file_info, "default" },
      { statusline_style.right, { "lightbg", "one_bg2" } },
    }
  end,
}

local default = {
  filetypes = { "default" },
  active = {
    { statusline_style.main_icon, { "statusline_bg", "blue" } },
    { statusline_style.right, { "blue", "one_bg2" } },
    basic.file,
    {
      function()
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
      { "red" },
    },
    {
      function()
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
      { "yellow" },
    },
    {
      function()
        if vim.api.nvim_buf_get_name(0) == "" then
          return ""
        end

        local lnum = vim.fn.search("\\s$", "nw")

        if lnum == 0 then
          return ""
        end

        return "  " .. string.format("(L%d)", lnum)
      end,
      {
        "white",
      },
    },
    {
      function()
        local text = vim.g["coc_status"] or ""

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
      {
        "green",
      },
    },
    basic.divider,
    {
      function()
        local func = vim.b["coc_current_function"] or ""
        return func .. " "
      end,
      {
        "white",
      },
    },
    basic.vi_mode,
    { statusline_style.left_rounded, { "grey", "one_bg" } },
    {
      statusline_style.left_rounded,
      { "green", "grey" },
    },
    {
      statusline_style.position_icon,
      { "black", "green" },
    },
    {
      function()
        return string.format(" %d/%d ", vim.fn.line("."), vim.fn.line("$"))
      end,
      { "green", "one_bg" },
    },
  },
  inactive = {},
}

local quickfix = {
  filetypes = { "qf" },
  active = {
    { "🚦 Quickfix ", { "statusline_bg", "blue" } },
    { statusline_style.right, { "blue", "one_bg2" } },
    { statusline_style.right, { "one_bg2", "lightbg" } },
    { statusline_style.right, { "lightbg" } },
    basic.divider,
  },
}

local explorer = {
  filetypes = { "coc-explorer" },
  active = {
    { "  ", { "statusline_bg", "blue" } },
    { statusline_style.right, { "blue", "one_bg2" } },
    { statusline_style.right, { "one_bg2", "lightbg" } },
    { statusline_style.right, { "lightbg" } },
    basic.divider,
  },
}

local floatline_component = {
  {
    hl_colors = {
      line = { "grey", "NormalBg" },
    },
    text = function(_, winid, width)
      return {
        { string.rep("—", math.floor(width - 1), ""), "line" },
        { "—", "line" },
      }
    end,
  },
}

local floatline = {
  filetypes = { "floatline" },
  active = floatline_component,
  inactive = floatline_component,
}

windline.setup({
  colors_name = function(colors)
    colors.black = "#282828"
    colors.white = "#ebdbb2"
    colors.red = "#fb4934"
    colors.green = "#b8bb26"
    colors.blue = "#83a598"
    colors.yellow = "#d79921"
    colors.cyan = "#00cccc"
    colors.magenta = "#c6c6c6"
    colors.grey = "#464646"
    colors.line = "#2c2f30"
    colors.one_bg = "#353535"
    colors.one_bg2 = "#3f3f3f"
    colors.statusline_bg = "#2c2c2c"
    colors.lightbg = "#353535"

    return colors
  end,
  statuslines = {
    default,
    quickfix,
    explorer,
    floatline,
  },
})

local wlfloatline = require("wlfloatline")

wlfloatline.floatline_on_cmd_enter = function() end

wlfloatline.setup({
  ui = {
    active_hl = nil,
  },
  skip_filetypes = {},
})

vim.opt.fillchars:append("stl:—,stlnc:—")
