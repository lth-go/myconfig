return {
  "nvim-neo-tree/neo-tree.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<F1>"] = { "<Cmd>Neotree show reveal reveal_force_cwd<CR>", desc = "Toggle Explorer" }
        maps.n["<C-\\>"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd("p")
            else
              vim.cmd("Neotree focus reveal reveal_force_cwd")
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
      },
      window = {
        mappings = {
          ["/"] = false,
          ["H"] = false,
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
