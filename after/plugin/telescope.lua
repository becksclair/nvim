require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  defaults = {
    winblend = 10,

    layout_strategy = "vertical",
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
    file_ignore_patterns = { "node_modules", "target", ".git" },
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
})


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
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Rresume' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'Search Keymaps' })
-- vim.keymap.set('n', '<leader>sy', require('telescope.builtin').symbols { sources = {'emoji'} }, { desc = 'Search Symbols' })
vim.keymap.set('n', '<leader>sy', ':Telescope symbols<CR>', { desc = 'Search Symbols' })


-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension('git_worktree'))

