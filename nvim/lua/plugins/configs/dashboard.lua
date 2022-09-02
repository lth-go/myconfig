local present, alpha = pcall(require, "alpha")

if not present then
  return
end

local vim = vim
local fortune = require("alpha.fortune")

local header = {
  [[                                                                   ]],
  [[      ████ ██████           █████      ██                    ]],
  [[     ███████████             █████                            ]],
  [[     █████████ ███████████████████ ███   ███████████  ]],
  [[    █████████  ███    █████████████ █████ ██████████████  ]],
  [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
  [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
  [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
}

-- Make the header a bit more fun with some color!
local function colorize_header()
  local lines = {}

  for i, chars in pairs(header) do
    local line = {
      type = "text",
      val = chars,
      opts = {
        hl = "StartLogo" .. i,
        shrink_margin = false,
        position = "center",
      },
    }

    table.insert(lines, line)
  end

  return lines
end

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
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local default = {}

default.header = {
  type = "group",
  val = colorize_header(),
}

default.buttons = {
  type = "group",
  val = {
    button("SPC f m", "  Recent File  ", ":Telescope coc mru<CR>"),
    button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
    button("SPC f g", "  Find Word  ", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"),
    button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
  },
  opts = {
    spacing = 1,
  },
}

default.footer = {
  type = "text",
  val = fortune(),
  opts = {
    position = "center",
    hl = "Number",
  },
}

alpha.setup({
  layout = {
    { type = "padding", val = 9 },
    default.header,
    { type = "padding", val = 2 },
    default.buttons,
    default.footer,
  },
  opts = {},
})
