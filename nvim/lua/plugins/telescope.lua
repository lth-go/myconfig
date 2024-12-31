local parse_prompt = function(prompt_parts)
  if prompt_parts == nil or #prompt_parts == 0 then
    return nil
  end

  local args = {
    keyword = nil,
    flags = {},
    dir = nil,
  }

  local to_args = function()
    local result = {}

    if args.keyword == nil then
      return result
    end

    table.insert(result, args.keyword)

    for k, v in pairs(args.flags) do
      table.insert(result, k)
      table.insert(result, v)
    end

    if args.dir ~= nil and args.dir ~= "" then
      table.insert(result, "-g")
      table.insert(result, args.dir .. "*")

      if not vim.endswith(args.dir, "/") then
        table.insert(result, "-g")
        table.insert(result, args.dir .. "*/**")
      else
        table.insert(result, "-g")
        table.insert(result, args.dir .. "**")
      end
    end

    return result
  end

  local pos = 1
  local valid_flags = { "-g", "-t" }

  while pos <= #prompt_parts do
    local part = prompt_parts[pos]

    if #part == 0 then
      break
    end

    if vim.startswith(part, "-") then
      if not vim.tbl_contains(valid_flags, part) then
        break
      end

      if pos == #prompt_parts then
        break
      end

      args.flags[prompt_parts[pos]] = prompt_parts[pos + 1]

      pos = pos + 2
    else
      if args.keyword == nil then
        args.keyword = part
      elseif args.dir == nil then
        args.dir = part
      else
        break
      end

      pos = pos + 1
    end
  end

  return to_args()
end

return {
  "nvim-telescope/telescope.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = {
          n = {
            ["<Leader>ff"] = {
              function()
                require("telescope.builtin").find_files({
                  temp__scrolling_limit = 36,
                  debounce = 100,
                })
              end,
            },
            ["<Leader>fg"] = {
              function()
                require("telescope").extensions.live_grep_args.live_grep_args({
                  temp__scrolling_limit = 36,
                  only_sort_text = true,
                  debounce = 200,
                  vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--sort=path",
                  },
                })
              end,
            },
            ["<Leader>fc"] = {
              function()
                require("telescope.builtin").grep_string({
                  only_sort_text = true,
                })
              end,
            },
            ["<Leader>fm"] = {
              function()
                require("telescope").extensions.mru.mru({})
              end,
            },
          },
          v = {
            ["<Leader>fc"] = {
              function()
                local lines = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })

                if #lines ~= 1 then
                  vim.api.nvim_input("<Esc>")
                  return
                end

                local word = lines[1]

                if not word or word == "" then
                  vim.api.nvim_input("<Esc>")
                  return
                end

                require("telescope.builtin").grep_string({ search = word })
              end,
            },
          },
        }

        opts.mappings = require("astrocore").extend_tbl(opts.mappings, maps)
      end,
    },
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local path_display = function(_, filename)
          local utils = require("telescope.utils")

          filename = require("pkg.settings").path_display(filename)
          filename = utils.transform_path({}, filename)

          local display, hl_group, icon = utils.transform_devicons(filename, filename, false)
          if hl_group then
            return display, { { { 0, #icon + 1 }, hl_group } }
          end

          return display, {}
        end

        local maps = {
          n = {
            ["<Leader>g"] = {
              function()
                require("telescope.builtin").lsp_definitions({
                  path_display = path_display,
                  show_line = false,
                })
              end,
            },
            ["gy"] = {
              function()
                require("telescope.builtin").lsp_type_definitions({
                  path_display = path_display,
                  show_line = false,
                })
              end,
            },
            ["gr"] = {
              function()
                require("telescope.builtin").lsp_references({
                  include_declaration = false,
                  include_current_line = true,
                  jump_type = "never",
                  path_display = path_display,
                  show_line = false,
                })
              end,
            },
            ["gi"] = {
              function()
                require("telescope.builtin").lsp_implementations({
                  path_display = path_display,
                  show_line = false,
                })
              end,
            },
          },
        }

        opts.mappings = require("astrocore").extend_tbl(opts.mappings, maps)
      end,
    },
  },
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      config = function(_, _)
        local astrocore = require("astrocore")
        astrocore.on_load("telescope.nvim", function()
          require("telescope").load_extension("mru")
          require("telescope").load_extension("live_grep_args")

          --
          --
          --

          local prompt_parser = require("telescope-live-grep-args.prompt_parser")

          local old_parse = prompt_parser.parse

          prompt_parser.parse = function(prompt, autoquote)
            local prompt_parts = old_parse(prompt, autoquote)

            return parse_prompt(prompt_parts)
          end
        end)
      end,
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-J>"] = require("telescope.actions").to_fuzzy_refine,
          ["<C-K>"] = false,
        },
        n = {
          ["<C-N>"] = require("telescope.actions").move_selection_next,
          ["<C-P>"] = require("telescope.actions").move_selection_previous,
        },
      },
      file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]", "vendor/.*" },
    },
    extensions = {},
  },
  config = function(_, opts)
    opts.extensions.live_grep_args = {
      mappings = {
        i = {
          ["<C-K>"] = require("telescope-live-grep-args.actions").quote_prompt(),
        },
      },
    }

    require("astronvim.plugins.configs.telescope")(_, opts)
  end,
}
