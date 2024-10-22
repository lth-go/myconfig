---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
      semantic_tokens = true,
    },
    config = {
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = false,
            },
          },
        },
      },
      gopls = {
        cmd = { "gopls", "-remote=auto", "-remote.listen.timeout=10m0s" },
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
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = true,
            },
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
