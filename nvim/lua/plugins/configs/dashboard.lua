local present, alpha = pcall(require, "alpha")

if not present then
  return
end

local vim = vim

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "Keyword",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local default = {}

-- https://fsymbols.com/text-art/
local ascii_art_moresec = {
  '███╗░░░███╗░█████╗░██╗░░██╗███████╗',
  '████╗░████║██╔══██╗██║░██╔╝██╔════╝',
  '██╔████╔██║███████║█████═╝░█████╗░░',
  '██║╚██╔╝██║██╔══██║██╔═██╗░██╔══╝░░',
  '██║░╚═╝░██║██║░░██║██║░╚██╗███████╗',
  '╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝',
  '███╗░░░███╗░█████╗░██████╗░███████╗░██████╗███████╗░█████╗░',
  '████╗░████║██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗',
  '██╔████╔██║██║░░██║██████╔╝█████╗░░╚█████╗░█████╗░░██║░░╚═╝',
  '██║╚██╔╝██║██║░░██║██╔══██╗██╔══╝░░░╚═══██╗██╔══╝░░██║░░██╗',
  '██║░╚═╝░██║╚█████╔╝██║░░██║███████╗██████╔╝███████╗╚█████╔╝',
  '╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝░╚════╝░',
  '░██████╗░██████╗░███████╗░█████╗░████████╗  ░█████╗░░██████╗░░█████╗░██╗███╗░░██╗',
  '██╔════╝░██╔══██╗██╔════╝██╔══██╗╚══██╔══╝  ██╔══██╗██╔════╝░██╔══██╗██║████╗░██║',
  '██║░░██╗░██████╔╝█████╗░░███████║░░░██║░░░  ███████║██║░░██╗░███████║██║██╔██╗██║',
  '██║░░╚██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░  ██╔══██║██║░░╚██╗██╔══██║██║██║╚████║',
  '╚██████╔╝██║░░██║███████╗██║░░██║░░░██║░░░  ██║░░██║╚██████╔╝██║░░██║██║██║░╚███║',
  '░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░  ╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝',
}

local ascii_art_list = {
  ascii_art_moresec,
}

local function ramdom_ascii_art()
  return ascii_art_list[ math.random(#ascii_art_list) ]
end

default.get_color_header = function()
  local lines = {}
  for i, line_chars in pairs(ramdom_ascii_art()) do
    local hi = "StartLogo" .. i
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center", },
  }

  return output
end

default.buttons = {
  type = "group",
  val = {
    button("SPC f m", "  Recent File  ", ":Telescope coc mru<CR>"),
    button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
    button("SPC f g", "  Find Word  ", ":Telescope live_grep<CR>"),
    button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
  },
  opts = {
    spacing = 1,
  },
}

alpha.setup({
  layout = {
    { type = "padding", val = 9 },
    default.get_color_header(),
    { type = "padding", val = 2 },
    default.buttons,
  },
  opts = {},
})
