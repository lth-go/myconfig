local opt_local = vim.opt_local

opt_local.expandtab = false
opt_local.tabstop = 4

local M = {}

M.go_imports = function()
  vim.lsp.buf.code_action({
    context = { only = { vim.lsp.protocol.CodeActionKind.SourceOrganizeImports } },
    apply = true,
  })
end

M.go_test = function()
  local filename = vim.fn.expand("%:t")

  if not vim.endswith(filename, "_test.go") then
    print("not a test file")
    return
  end

  local params = vim.lsp.util.make_range_params(0, "utf-8")
  params.context = { only = { "source.test" } }

  vim.lsp.buf_request(0, vim.lsp.protocol.Methods.textDocument_codeAction, params, M.select_test)
end

M.select_test = function(err, results)
  if err then
    vim.notify(tostring(err.code) .. ": " .. err.message, vim.log.levels.ERROR)
    return
  end

  if not results then
    vim.notify("No tests found")
    return
  end

  local tests = {}

  for _, result in ipairs(results) do
    for _, argument in ipairs(result.command.arguments) do
      for _, test in ipairs(argument.Tests) do
        table.insert(tests, {
          test = test,
          uri = argument.URI,
        })
      end
    end
  end

  if #tests == 0 then
    vim.notify("No tests found")
    return
  end

  M.run_test(tests[1])
end

M.run_test = function(choice)
  local file_path = choice.uri
  file_path = string.sub(file_path, #"file://" + 1)
  file_path = vim.fn.fnamemodify(file_path, ":.")

  local dir = vim.fn.fnamemodify(file_path, ":h")
  local cmd = string.format("cd %s; go test -v -count=1 -run '^%s$' .", dir, choice.test)
  cmd = string.format("sh -c %s", vim.fn.shellescape(cmd))

  require("toggleterm").exec(cmd)
end

vim.keymap.set("n", "<C-A-O>", M.go_imports, { buffer = true })
vim.keymap.set("n", "<F5>", M.go_test, { buffer = true })
