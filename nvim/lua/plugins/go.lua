return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    run = "cd lua/fzy && make",
  },
  ft = { "go", "gomod" },
  keys = {
    {
      "<F5>",
      function()
        local filename = vim.fn.expand("%:t")

        if not vim.endswith(filename, "_test.go") then
          print("not a test file")
          return
        end

        require("go.gotest").test_func("-v", "-F")

        vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:Grey", { win = 0 })
      end,
      ft = { "go" },
    },
    {
      "<C-A-O>",
      function()
        vim.cmd.GoImports()
      end,
      ft = { "go" },
    },
  },
  config = function()
    require("go").setup({
      lsp_codelens = false,
      diagnostic = false,
      dap_debug = false,
      textobjects = false,
    })
  end,
}
