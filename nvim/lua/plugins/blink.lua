local is_path_completion = function()
  local constants = require("blink.cmp.sources.cmdline.constants")

  local completion_type = vim.fn.getcmdcompltype()

  return vim.tbl_contains(constants.completion_types.path, completion_type)
end

local cmdline_transform_items = function(_, items)
  if not is_path_completion() then
    for _, item in ipairs(items) do
      item.kind_icon = ""
    end

    return items
  end

  for _, item in ipairs(items) do
    local is_dir = vim.endswith(item.label, "/")

    item.sortText = (is_dir and "1" or "2") .. item.sortText
    item.kind_icon, item.kind_hl = require("mini.icons").get(is_dir and "directory" or "file", item.label)
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
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
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
        preset = "none",
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
}
