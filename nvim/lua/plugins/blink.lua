return {
  "saghen/blink.cmp",
  specs = {
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local astrocore = require("astrocore")
        opts.capabilities = astrocore.extend_tbl(opts.capabilities, {
          textDocument = {
            completion = {
              completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
              },
            },
          },
        })
      end,
    },
  },
  version = "*",
  opts = {
    keymap = {
      ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
      },
    },
    cmdline = {
      enabled = false,
    },
  },
}
