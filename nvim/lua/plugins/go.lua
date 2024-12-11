local fix_term_highlights = function()
  local go_term = require("go.term")

  local old_run = go_term.run

  go_term.run = function(opts)
    local buf, win, closer = old_run(opts)

    if win ~= nil and win > 0 then
      vim.api.nvim_set_option_value("winhl", "NormalFloat:Normal,FloatBorder:Comment", { win = win })
    end

    return buf, win, closer
  end
end

return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    run = "cd lua/fzy && make",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
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
      verbose_tests = true,
      run_in_floaterm = true,
    })

    --
    --
    --

    vim.treesitter.query.set("go", "injections", "")
    fix_term_highlights()
    vim.api.nvim_del_augroup_by_name("go.filetype")
  end,
}
