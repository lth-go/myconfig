return {
  "ray-x/go.nvim",
  config = function()
    require("go").setup({
      lsp_keymaps = false,
      lsp_codelens = false,
      null_ls = false,
      diagnostic = false,
      lsp_document_formatting = false,
      lsp_inlay_hints = {
        enable = false,
      },
      dap_debug = false,
      textobjects = false,
    })

    vim.treesitter.query.set("go", "injections", "")
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
}
