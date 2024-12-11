local M = {}

local task_registry = {}

function M.add_task(key, delay_ms, fn, params)
  if task_registry[key] then
    task_registry[key].params = params
    return
  end

  task_registry[key] = { fn = fn, params = params }

  vim.defer_fn(function()
    fn(unpack(task_registry[key].params))
    task_registry[key] = nil
  end, delay_ms)
end

return M
