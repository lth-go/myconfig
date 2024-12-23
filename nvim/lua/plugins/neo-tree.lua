local get_reveal_dir = function(reveal_file)
  local file = require("pkg.utils.file")

  local original_dir = vim.fn.fnamemodify(reveal_file, ":h")

  local dir = original_dir

  for _ = 1, 5 do
    if dir == "/" then
      break
    end

    local gomod = file.join(dir, "go.mod")
    if file.exists(gomod) then
      return dir
    end

    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return original_dir
end

local get_args = function(action)
  local strings = require("pkg.utils.strings")

  local args = {
    action = action,
    reveal = true,
    reveal_force_cwd = true,
  }

  local reveal_file = vim.fn.expand("%:p")
  local cwd = vim.fn.getcwd()

  if reveal_file == "" then
    args.dir = cwd

    return args
  end

  if strings.has_prefix(reveal_file, cwd) then
    args.dir = cwd
  else
    args.reveal_file = reveal_file
    args.dir = get_reveal_dir(reveal_file)
  end

  return setmetatable({}, {
    __index = args,
    __newindex = function(_, k, v)
      if k == "dir" then
        return
      end

      args[k] = v
    end,
  })
end

local toggle_explorer = function(action)
  require("neo-tree.command").execute(get_args(action))
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<F1>"] = {
          function()
            toggle_explorer("show")
          end,
          desc = "Toggle Explorer",
        }

        maps.n["<C-\\>"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd("p")
            else
              toggle_explorer("focus")
            end
          end,
          desc = "Toggle Explorer Focus",
        }
      end,
    },
  },
  opts = function(_, opts)
    local neotree_components = require("neo-tree.sources.filesystem.components")
    local old_name = neotree_components.name

    neotree_components.name = function(config, node, state)
      local entry = old_name(config, node, state)
      if node:get_depth() == 1 and node.type == "directory" then
        entry["text"] = vim.fn.fnamemodify(node.path, ":t")
      end

      return entry
    end

    return require("astrocore").extend_tbl(opts, {
      default_component_configs = {
        name = {
          use_git_status_colors = false,
        },
      },
      sources = { "filesystem", "git_status" },
      commands = {
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if node:has_children() and node:is_expanded() then
            state.commands.toggle_node(state)
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node:has_children() then
            if not node:is_expanded() then
              state.commands.toggle_node(state)
            else
              if node.type == "file" then
                state.commands.open(state)
              end
            end
          else
            state.commands.open(state)
          end
        end,
        find_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()

          require("telescope.builtin").live_grep({ cwd = path })
        end,
      },
      window = {
        mappings = {
          ["/"] = false,
          ["H"] = false,
          ["F"] = "find_in_dir",
        },
      },
      filesystem = {
        filtered_items = {
          show_hidden_count = false,
        },
        follow_current_file = {
          enabled = false,
        },
        bind_to_cwd = false,
      },
    })
  end,
}