local load = function(opts)
  local resession = require("resession")
  local files = require("resession.files")
  local util = require("resession.util")

  local load_settings = function(dir)
    local filename = dir .. "/.vim/settings.json"

    local data = files.load_json_file(filename)
    if data == nil then
      return nil
    end

    if data.session == nil then
      return data
    end

    if vim.tbl_isempty(data.session.projects) then
      return data
    end

    for _, project in ipairs(data.session.projects) do
      if project.path == nil then
        project.path = project.name
      end

      if string.sub(project.path, 1, 1) ~= "/" then
        local path = vim.fn.fnamemodify(dir .. "/" .. project.path, ":p")
        path = string.sub(path, 1, #path - 1)

        project.path = path
      end
    end

    return data
  end

  local get_settings = function()
    local dir = vim.fn.getcwd()

    for _ = 1, 3 do
      if dir == "/" then
        break
      end

      local data = load_settings(dir)
      if data then
        return data
      end

      dir = vim.fn.fnamemodify(dir, ":h")
    end

    return nil
  end

  local settings = get_settings()
  if settings == nil or settings.session == nil or vim.tbl_isempty(settings.session.projects) then
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
