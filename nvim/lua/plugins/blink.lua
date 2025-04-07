local is_file_cmd = function(line)
  local constants = require("blink.cmp.sources.cmdline.constants")

  local ok, cmd = pcall(vim.api.nvim_parse_cmd, line, {})
  if not ok then
    return false
  end
  if not constants.file_commands[cmd.cmd] then
    return false
  end

  return true
end

local on_char_added = function()
  local context = require("blink.cmp.completion.trigger.context")
  local trigger = require("blink.cmp.completion.trigger")

  local bounds = context.get_bounds("full")
  local line = context.get_line()

  if not is_file_cmd(line) then
    return false
  end

  -- trigger when previous character is a slash
  if bounds.length == 1 then
    local i = bounds.start_col - 1
    if string.sub(line, i, i) == "/" then
      trigger.context = nil
      trigger.show({ trigger_kind = "trigger_character", trigger_character = "/" })

      return true
    end
  end

  return false
end

local hijack_trigger = function()
  local on_char_added_wrap = function(fallback)
    return function(char, is_ignored)
      if on_char_added() then
        return
      end

      return fallback(char, is_ignored)
    end
  end

  local listen_wrap = function(fallback)
    return function(self, opts)
      opts.on_char_added = on_char_added_wrap(opts.on_char_added)

      return fallback(self, opts)
    end
  end

  local cmdline_events = require("blink.cmp.lib.cmdline_events")
  cmdline_events.listen = listen_wrap(cmdline_events.listen)
end

local hijack_match = function()
  local sources = require("blink.cmp.sources.lib")

  sources.completions_emitter:on(function(event)
    local context = event.context
    if context == nil then
      return
    end
    if context.mode ~= "cmdline" then
      return
    end
    if not is_file_cmd(context.line) then
      return
    end
    if context.bounds.length == 0 then
      return
    end

    local initial_character
    if context.trigger.initial_kind == "trigger_character" and context.trigger.initial_character ~= " " then
      initial_character = context.trigger.initial_character
    end

    local start_col = context.bounds.start_col
    local first_char = string.sub(context.line, start_col, start_col)
    if first_char == "" then
      return
    end

    local case = string.lower
    if first_char:match("^%u") then
      case = tostring
    end

    local filter = function(item)
      local label = item.filterText or item.label

      if initial_character and vim.startswith(label, initial_character) then
        label = label:sub(#initial_character + 1)
      end

      return case(label:sub(1, 1)) == first_char
    end

    event.items["cmdline"] = vim.tbl_filter(filter, event.items["cmdline"] or {})
  end)
end

local hijack = function()
  hijack_trigger()
  hijack_match()
end

local cmdline_transform_items = function(_, items)
  local completion_type = vim.fn.getcmdcompltype()
  if completion_type ~= "file" then
    for _, item in ipairs(items) do
      item.kind_icon = ""
    end
    return items
  end

  for _, item in ipairs(items) do
    local label = item.label
    local file_path = item.label

    local is_dir = vim.endswith(file_path, "/")

    file_path = vim.fs.normalize(file_path)
    file_path = vim.fn.fnamemodify(file_path, ":t")

    item.label = is_dir and file_path .. "/" or file_path
    item.filterText = item.label
    item.sortText = (is_dir and "1" or "2") .. file_path:lower()
    item.kind_icon, item.kind_hl = require("mini.icons").get(is_dir and "directory" or "file", label)
  end

  return items
end

return {
  "saghen/blink.cmp",
  specs = {
    {
      "AstroNvim/astroui",
      opts = {
        highlights = {
          init = {
            ["BlinkCmpLabelMatch"] = { fg = "#f4468f" },
          },
        },
      },
    },
  },
  opts = {
    keymap = {
      ["<C-D>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-J>"] = {},
      ["<C-K>"] = {},
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        border = "none",
      },
    },
    sources = {
      providers = {
        cmdline = {
          transform_items = cmdline_transform_items,
        },
      },
    },
    cmdline = {
      keymap = {
        ["<CR>"] = {},
        ["<Tab>"] = { "show", "select_next" },
        ["<S-Tab>"] = { "show", "select_prev" },
        ["/"] = { "accept", "fallback" },
      },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
        },
      },
    },
  },
  config = function(_, opts)
    hijack()

    require("blink.cmp").setup(opts)
  end,
}
