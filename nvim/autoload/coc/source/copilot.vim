function! coc#source#copilot#init() abort
  return {
    \ 'priority': 0,
    \ 'shortcut': 'Copilot',
    \ 'triggerCharacters': ['']
   \ }
endfunction

function! coc#source#copilot#complete(opt, cb) abort
  call v:lua.copilot_completion_custom()
  call a:cb(get(g:, 'lth_copilot_completion', v:false))
endfunction

lua << EOF

local timer = vim.loop.new_timer()

function _G.copilot_completion_custom()
  timer:stop()
  timer:start(0, 200, vim.schedule_wrap(function()
    local ready = true
    ready = ready and vim.g._copilot_completion
    ready = ready and vim.g._copilot_last_completion
    ready = ready and vim.g._copilot_completion.id == vim.g._copilot_last_completion.id
    ready = ready and vim.tbl_contains({ 'success', 'error' }, vim.g._copilot_last_completion.status)
    ready = ready and vim.g._copilot_last_completion.result
    ready = ready and vim.g._copilot_last_completion.result.completions
    ready = ready and #vim.g._copilot_last_completion.result.completions > 0

    if not ready then
      return
    end

    timer:stop()

    if vim.g._copilot_last_completion.status == 'error' then
      return
    end

    local deindent = function(text)
      local indent = string.match(text, '^%s*')
      if not indent then
        return text
      end
      return string.gsub(string.gsub(text, '^' .. indent, ''), '\n' .. indent, '\n')
    end

    vim.g.lth_copilot_completion = vim.tbl_map(
      function(item)
        return {
          word = deindent(item.text),
          abbr = item.displayText,
          menu = "",
          info = "",
          kind = "",
      }
      end,
      vim.g._copilot_last_completion.result.completions
    )
  end))
end

EOF
