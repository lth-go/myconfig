local transform_path = function(opts, filename)
  local strings = require("pkg.utils.strings")
  local utils = require("telescope.utils")

  local settings = require("pkg.settings").load()
  if settings ~= nil and settings.telescope ~= nil and settings.telescope.path_replace ~= nil then
    for _, item in ipairs(settings.telescope.path_replace) do
      if strings.has_prefix(filename, item.prefix) then
        filename = string.gsub(filename, item.prefix, item.replace)
        break
      end
    end
  end

  return utils.transform_path(opts, filename)
end

local parse_prompt = function(prompt_parts)
  local strings = require("pkg.utils.strings")

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

      if not strings.has_suffix(args.dir, "/") then
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

    if strings.has_prefix(part, "-") then
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
                require("telescope.builtin").find_files({ temp__scrolling_limit = 36, debounce = 100 })
              end,
            },
            ["<Leader>fg"] = {
              function()
                require("telescope").extensions.live_grep_args.live_grep_args({ only_sort_text = true, debounce = 200 })
              end,
            },
            ["<Leader>fc"] = {
              function()
                require("telescope.builtin").grep_string()
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
        local utils = require("telescope.utils")

        local gen_from_quickfix = function()
          local make_display = function(entry)
            local hl_group, icon
            local display, path_style = transform_path({}, entry.filename)
            local display_string = string.format("%s:%d:%d", display, entry.lnum, entry.col)

            display, hl_group, icon = utils.transform_devicons(entry.filename, display_string, false)

            if hl_group then
              local style = { { { 0, #icon + 1 }, hl_group } }
              style = utils.merge_styles(style, path_style, #icon + 1)
              return display, style
            end

            return display, path_style
          end

          return function(entry)
            return {
              value = entry,
              ordinal = entry.filename .. " " .. entry.text,
              display = make_display,
              bufnr = entry.bufnr,
              filename = entry.filename,
              lnum = entry.lnum,
              col = entry.col,
              text = entry.text,
              start = entry.start,
              finish = entry.finish,
            }
          end
        end

        local maps = {
          n = {
            ["<Leader>g"] = {
              function()
                require("telescope.builtin").lsp_definitions({ entry_maker = gen_from_quickfix() })
              end,
            },
            ["gy"] = {
              function()
                require("telescope.builtin").lsp_type_definitions({ entry_maker = gen_from_quickfix() })
              end,
            },
            ["gr"] = {
              function()
                require("telescope.builtin").lsp_references({ include_declaration = false, include_current_line = true, jump_type = "never", entry_maker = gen_from_quickfix() })
              end,
            },
            ["gi"] = {
              function()
                require("telescope.builtin").lsp_implementations({ entry_maker = gen_from_quickfix() })
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
