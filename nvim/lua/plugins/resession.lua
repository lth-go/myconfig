local get_projects = function()
  local settings = require("pkg.settings").load()

  local projects = settings:get("session.projects")
  if projects == nil or vim.tbl_isempty(projects) then
    return nil
  end

  for _, project in ipairs(projects) do
    if project.path == nil then
      project.path = project.name
    end

    if not vim.startswith(project.path, "/") then
      local path = vim.fn.fnamemodify(vim.fs.joinpath(settings.meta.dir, project.path), ":p")
      path = string.sub(path, 1, #path - 1)

      project.path = path
    end
  end

  return projects
end

local save = function()
  local buf_utils = require("astrocore.buffer")

  if not buf_utils.is_valid_session() then
    return
  end

  local cwd = vim.fn.getcwd()
  local projects = get_projects()
  if projects == nil then
    return
  end

  for _, project in ipairs(projects) do
    if vim.startswith(project.path, cwd) then
      require("resession").save(project.path, { dir = "dirsession", notify = false })
      return
    end
  end
end

local load = function()
  local opts = { dir = "dirsession" }

  local files = require("resession.files")
  local resession = require("resession")
  local util = require("resession.util")

  local projects = get_projects()
  if projects == nil then
    vim.notify("No saved sessions", vim.log.levels.WARN)
    return
  end

  local select_opts = {
    kind = "resession_load",
    prompt = "Load session",
    format_item = function(project)
      return project.name
    end,
  }

  local on_choice = function(selected)
    if selected then
      save()

      local filename = util.get_session_file(selected.path, opts.dir)

      local data = files.load_json_file(filename)
      if not data then
        vim.notify(string.format("Could not find session %s", selected.path), vim.log.levels.WARN)

        vim.api.nvim_set_current_dir(selected.path)

        require("snacks").picker.files({})
        return
      end

      resession.load(selected.path, opts)
    end
  end

  vim.ui.select(projects, select_opts, on_choice)
end

return {
  "stevearc/resession.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>ss"] = { save, desc = "Save this dirsession" }
        maps.n["<Leader>sl"] = { load, desc = "Load a dirsession" }

        opts.autocmds.resession_auto_save = {
          {
            event = "VimLeavePre",
            desc = "Save session on close",
            callback = save,
          },
        }
      end,
    },
  },
  opts = function(_, opts)
    opts.buf_filter = function(bufnr)
      return require("resession.extensions.astrocore").buf_filter(bufnr)
    end
  end,
}
