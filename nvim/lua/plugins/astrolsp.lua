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
            analyses = {
              QF1003 = false,
              S1008 = false,
            },
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
    lsp_handlers = {
      ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        local key = string.format("%s_%s_%s", ctx.method, ctx.client_id, result.uri)
        require("pkg.utils.tasks").add_task(key, 3000, vim.lsp.diagnostic.on_publish_diagnostics, { _, result, ctx, config })
      end,
    },
  },
}
