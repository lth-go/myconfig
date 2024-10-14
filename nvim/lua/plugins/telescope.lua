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
                require("telescope.builtin").find_files()
              end,
            },
            ["<Leader>fg"] = {
              function()
                require("telescope").extensions.live_grep_args.live_grep_args()
              end,
            },
            ["<Leader>fc"] = {
              function()
                require("telescope.builtin").grep_string()
              end,
            },
            ["<Leader>fm"] = {
              function()
                require("telescope.builtin").oldfiles({ only_cwd = 1 })
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
        local maps = {
          n = {
            ["<Leader>g"] = {
              function()
                require("telescope.builtin").lsp_definitions()
              end,
            },
            ["gy"] = {
              function()
                require("telescope.builtin").lsp_type_definitions()
              end,
            },
            ["gr"] = {
              function()
                require("telescope.builtin").lsp_references()
              end,
            },
            ["gi"] = {
              function()
                require("telescope.builtin").lsp_implementations()
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
      lazy = true,
      config = function(_, _)
        local astrocore = require("astrocore")
        astrocore.on_load("telescope.nvim", function()
          require("telescope").load_extension("live_grep_args")
        end)
      end,
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-J>"] = false,
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
          ["<C-J>"] = require("telescope.actions").to_fuzzy_refine,
        },
      },
    }

    require("astronvim.plugins.configs.telescope")(_, opts)
  end,
}
