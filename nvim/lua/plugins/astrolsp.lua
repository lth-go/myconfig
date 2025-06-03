---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
      semantic_tokens = false,
    },
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
          },
        },
      },
    },
    config = {
      gopls = {
        cmd = { "gopls", "-remote=auto", "-remote.listen.timeout=10m0s" },
        settings = {
          gopls = {
            directoryFilters = {
              "-**/node_modules",
              "-**/lo",
            },
            analyses = {
              QF1003 = false, -- Convert if/else-if chain to tagged switch
              QF1008 = false, -- Omit embedded fields from selector expression
              S1008 = false, -- Simplify returning boolean expression
              S1039 = false, -- Unnecessary use of fmt.Sprint
              S1025 = false, -- the argument is already a string, there's no need to use fmt.Sprintf
            },
            hints = {
              constantValues = true,
            },
            staticcheck = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              libraryFiles = "Disable",
            },
            hint = {
              enable = false,
            },
            window = {
              progressBar = false,
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      },
    },
  },
}
