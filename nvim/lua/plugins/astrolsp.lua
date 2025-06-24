---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
      semantic_tokens = true,
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
              S1025 = false, -- Don't use fmt.Sprintf("%s", x) unnecessarily
              ST1000 = false, -- Incorrect or missing package comment
              ST1003 = false, -- Poorly chosen identifier
              ST1020 = false, -- The documentation of an exported function should start with the function’s name
              ST1021 = false, -- The documentation of an exported type should start with type's name
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
