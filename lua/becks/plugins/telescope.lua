return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
      -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
      'nvim-telescope/telescope-symbols.nvim',
      event = "VeryLazy"
    },
  },
  event = "VimEnter",

  opts = {
    extensions = {
      aerial = {
        -- Set the width of the first two columns (the second
        -- is relevant only when show_columns is set to 'both')
        col1_width = 4,
        col2_width = 30,
        -- How to format the symbols
        format_symbol = function(symbol_path, filetype)
          if filetype == "json" or filetype == "yaml" then
            return table.concat(symbol_path, ".")
          else
            return symbol_path[#symbol_path]
          end
        end,
        -- Available modes: symbols, lines, both
        show_columns = "both",
      },
    },
    defaults = {
      winblend = 10,

      layout_strategy = "horizontal",
      layout_config = {
        -- preview_width = 0.65,
        vertical = {
          size = {
            width = "95%",
            height = "95%",
          },
          mirror = true,
          preview_cutoff = 0,
        },
      },
      selection_caret = "󰁕 ",
      prompt_prefix = "󰭎  ",
      -- path_display = { "smart" },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        colorscheme = {
          enable_preview = true
        },
      },
      file_ignore_patterns = {
        "node_modules",
        "target",
        -- ".git"
      },
      mappings = {
        n = {
          -- ['<c-d>'] = require('telescope.actions').delete_buffer
          -- ["<leader>f"] = require('telescope.builtin').find_files,
          -- ["<C-p>"]     = require('telescope.builtin').git_files
        },
        i = {
          ["<C-h>"] = "which_key",
          -- ['<c-d>'] = require('telescope.actions').delete_buffer
        }
      }
    },

    -- End Opts
  },

  config = function(_, opts)
    require('telescope').setup(opts)

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>f', builtin.find_files, { noremap = true, silent = true, desc = 'Find [F]iles' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { noremap = true, silent = true, desc = 'Find Git files' })
    vim.keymap.set('n', '<leader>ss', builtin.live_grep, { noremap = true, silent = true, desc = 'Search Live Grep' })

    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { noremap = true, silent = true, desc = 'Help Tags' })

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>sq', require('telescope.builtin').colorscheme, { desc = 'Find color schemes' })

    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })

    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = true,
      })
    end, { desc = 'Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })

    vim.keymap.set('n', '<leader>sgs', require('telescope.builtin').git_status, { desc = 'Search Git Changed' })
    vim.keymap.set('n', '<leader>sgc', require('telescope.builtin').git_commits, { desc = 'Search Git Commits' })
    vim.keymap.set('n', '<leader>sgb', require('telescope.builtin').git_branches, { desc = 'Search Git Branches' })

    vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>sy', require('telescope.builtin').symbols, { desc = 'Search Symbols' })
    -- vim.keymap.set('n', '<leader>sy', ':Telescope symbols<CR>', { desc = 'Search Symbols' })

    vim.keymap.set('n', '<leader>sa', require("telescope").extensions.aerial.aerial, { desc = 'Search Aerial Symbols' })
    vim.keymap.set('n', '<leader>slr', require("telescope.builtin").lsp_references, { desc = 'Search LSP References' })
    vim.keymap.set('n', '<leader>sld', require('telescope.builtin').lsp_definitions, { desc = 'Search LSP definitions' })
    vim.keymap.set('n', '<leader>sli', require('telescope.builtin').lsp_implementations,
      { desc = 'Search LSP definitions' })
    vim.keymap.set('n', '<leader>s8', require("telescope.builtin").highlights, { desc = 'Search Highlight Groups' })
    vim.keymap.set('n', '<leader>sp', require("telescope.builtin").spell_suggest, { desc = 'Search spelling suggestions' })


    -- Enable telescope fzf native, if installed
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('git_worktree')
    require("telescope").load_extension("aerial")
  end,
}
