local load = function(opts)
  local files = require("resession.files")
  local resession = require("resession")
  local util = require("resession.util")
  local strings = require("pkg.utils.strings")

  local settings = require("pkg.settings").load()
  if settings == nil or settings.session == nil or vim.tbl_isempty(settings.session.projects) then
    vim.notify("No saved sessions", vim.log.levels.WARN)
    return
  end

  for _, project in ipairs(settings.session.projects) do
    if project.path == nil then
      project.path = project.name
    end

    if not strings.has_prefix(project.path, "/") then
      local path = vim.fn.fnamemodify(files.join(settings.__meta__.dir, project.path), ":p")
      path = string.sub(path, 1, #path - 1)

      project.path = path
    end
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
      local filename = util.get_session_file(selected.path, opts.dir)

      local data = files.load_json_file(filename)
      if not data then
        vim.notify(string.format("Could not find session %s", selected.path), vim.log.levels.WARN)

        vim.api.nvim_set_current_dir(selected.path)

        require("telescope.builtin").find_files({})
        return
      end

      resession.load(selected.path, opts)
    end
  end

  vim.ui.select(settings.session.projects, select_opts, on_choice)
end

return {
  "stevearc/resession.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>ss"] = {
          function()
            require("resession").save(vim.fn.getcwd(), { dir = "dirsession" })
          end,
          desc = "Save this dirsession",
        }
        maps.n["<Leader>sl"] = {
          function()
            load({ dir = "dirsession" })
          end,
          desc = "Load a dirsession",
        }
      end,
    },
  },
}
