---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
    },
    config = {
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            hint = {
              enable = false,
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            hints = {
              constantValues = true,
              functionTypeParameters = true,
            },
            staticcheck = true,
          },
        },
      },
    },
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    autocmds = {
      lsp_auto_signature_help = false,
      lsp_auto_format = false,
    },
  },
}
