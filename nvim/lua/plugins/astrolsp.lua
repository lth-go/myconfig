---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
      semantic_tokens = true,
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
            },
            hints = {
              constantValues = true,
              functionTypeParameters = true,
            },
            staticcheck = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            hint = {
              enable = false,
            },
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
  },
}
