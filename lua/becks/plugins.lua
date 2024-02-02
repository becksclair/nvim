-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- NOTE: Install package manager https://github.com/folke/lazy.nvim
--`:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Get platform dependant build script
local function tabnine_build_path()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "pwsh.exe -file .\\dl_binaries.ps1"
  else
    return "./dl_binaries.sh"
  end
end


-- NOTE: Lazy plugins

require('lazy').setup({
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  require('becks.plugins.color-schemes'),
  -- require('becks.plugins.nvim-tree'),
  require('becks.plugins.neo-tree'),
  require('becks.plugins.trouble'),

  -- Highlight, edit, and navigate code
  require('becks.plugins.treesitter'),

  -- { 'nvim-treesitter/playground' },

  -- Project File navigation
  require('becks.plugins.harpoon'),

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    lazy = true,
    event = "BufRead"
  },

  -- Undo GUI
  {
    'mbbill/undotree',
    lazy = true,
    event = "VeryLazy",
    cmd = {
      "UndotreeToggle"
    },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle", desc = "Open undo tree" }
    }
  },

  -- Git related plugins
  -- {
  --   'tpope/vim-fugitive',
  --   lazy = true,
  --   event = "VeryLazy",
  -- },

  -- {
  --   "kdheepak/lazygit.nvim",
  --   lazy = true,
  --   keys = {
  --     { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  --   },
  --   cmd = { "LazyGit", "LazyGitConfig" },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   -- init = function ()
  --   -- end,
  --   config = function()
  --     vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
  --     vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
  --     vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
  --     vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
  --     vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
  --
  --     vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
  --     vim.g.lazygit_config_file_path = '' -- custom config file path
  --
  --     require("telescope").load_extension("lazygit")
  --   end,
  -- },

  require('becks.plugins.git-worktree'),

  -- LSP Magic
  require('becks.plugins.lsp-zero'),

  -- require('becks.plugins.quick-lint-js'),


  {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {
      window = {
        width = 90,
        options = {}
      },
    }
  },

  {
    'mfussenegger/nvim-lint',
    lazy = true,
    -- event = "BufReadPost",
  },

  {
    'Tetralux/odin.vim'
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    lazy = true,
    event = "VeryLazy",
    opts = {}
  },

  require('becks.plugins.gitsigns'),

  -- AI Help
  require('becks.plugins.copilot-cmp'),

  -- Animations for bored people
  {
    'eandrju/cellular-automaton.nvim',
    lazy = true,
    enabled = false,
  },

  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    enabled = true,
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    lazy = true,
    opts = {
      ignore = nil,

      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        line = '\\',
        block = '|',
      },

      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = '\\',
        block = '|',
      },

      extra = {
        above = '<leader>Oc',
        below = '<leader>oc',
        eol = '<leader>Ac',
      },
    },
    event = "BufEnter",
  },

  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },

  -- Show CSS Color previews
  require('becks.plugins.nvim-colorizer'),

  -- Hide Secrets
  {
    'laytan/cloak.nvim',
    lazy = true,
    enabled = false,
    opts = {
      enabled = true,
      cloak_character = "*",
      -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
      highlight_group = "Comment",
      patterns = {
        {
          -- Match any file starting with ".env".
          -- This can be a table to match multiple file patterns.
          file_pattern = {
            ".env*",
            "wrangler.toml",
            ".dev.vars",
          },
          -- Match an equals sign and any character after it.
          -- This can also be a table of patterns to cloak,
          -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
          cloak_pattern = "=.+"
        },
      },
    }
  },

  require('becks.plugins.chatgpt'),

  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    event = "VeryLazy",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      -- shade_terminals = true,
      start_in_insert = true,
      direction = 'float',
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'rounded',
        -- like `size`, width and height can be a number or function which is passed the current terminal
        -- winblend = 3,
        -- zindex = <value>,
      },
    },
    config = true
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {'rcarriga/nvim-dap-ui'},
      {'theHamsta/nvim-dap-virtual-text'},
      {"ldelossa/nvim-dap-projects"},
      {'leoluz/nvim-dap-go'},
      {'mfussenegger/nvim-dap-python'}
    },
    config = function()

      vim.keymap.set('n', '<F5>', function()
          require('dap').continue()
        end,
        { noremap = true, silent = false, desc = 'Debug' }
      )
      -- vim.keymap.set('n', '<F8>', function()
      --     require('dap').toggle_breakpoint()
      --   end,
      --   { noremap = true, silent = false, desc = 'Continue' }
      -- )
      vim.keymap.set('n', '<F8>', function()
          require('dap').continue()
        end,
        { noremap = true, silent = false, desc = 'Toggle breakpoint' }
      )
      vim.keymap.set('n', '<F9>', function()
          require('dap').toggle_breakpoint()
        end,
        { noremap = true, silent = false, desc = 'Toggle breakpoint' }
      )
      vim.keymap.set('n', '<F10>', function()
          require('dap').step_over()
        end,
        { noremap = true, silent = false, desc = 'Step over' }
      )
      vim.keymap.set('n', '<F11>', function()
          require('dap').step_into()
        end,
        { noremap = true, silent = false, desc = 'Step into' }
      )
      vim.keymap.set('n', '<F12>', function()
          require('dap').step_out()
        end,
        { noremap = true, silent = false, desc = 'Step out' }
      )
      vim.keymap.set('n', '<Leader>dr', function ()
          require('dap').repl.open()
        end,
        { noremap = true, silent = false, desc = 'Open DAP repl' }
      )
      vim.keymap.set('n', '<Leader>do', function ()
          require('dapui').open()
        end,
        { noremap = true, silent = false, desc = 'Open DAP UI' }
      )
      vim.keymap.set('n', '<Leader>dc', function ()
          require('dapui').close()
        end,
        { noremap = true, silent = false, desc = 'Close DAP UI' }
      )
      vim.keymap.set('n', '<Leader>dt', function ()
          require('dapui').toggle()
        end,
        { noremap = true, silent = false, desc = 'Toggle DAP UI' }
      )

      require("nvim-dap-projects").search_project_config()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup({})
      require('dap-go').setup()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
      require('dap-python').test_runner = 'pytest'
    end,
  },

  {
    'ggandor/leap.nvim',
    lazy = true,
    event = "BufEnter",
    config = function()
      require('leap').add_default_mappings()
    end
  },

  -- Database
  {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = {
          -- 'sql',
          -- 'mysql',
          'plsql'
        },
        lazy = true
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = 'right'
      vim.g.db_ui_minwidth = 60
    end,
  },

  require("becks.plugins.lualine"),

  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand("~") .. "/HeliasMind/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/HeliasMind/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- optional dependencies
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      dir = "~/personal/HeliasMind", -- no need to call 'vim.fn.expand' here

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "Inbox",

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Day Planners",
        -- Optional, if you want to change the date format for the ID of daily notes.
        -- date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        -- alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = 'Daily.md',
      },

      -- Optional, completion.
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",

        -- Whether to add the output of the node_id_func to new notes in autocompletion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        prepend_note_id = true
      },

      -- Optional, key mappings.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        -- ["ga"] = require("obsidian.mapping").gf_passthrough(),
      },

      -- Optional, for templates (see below).
      templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {}
      },

      -- Optional, customize the backlinks interface.
      backlinks = {
        -- The default height of the backlinks pane.
        height = 10,
        -- Whether or not to wrap lines.
        wrap = true,
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = false,

      -- Optional, determines whether to open notes in a horizontal split, a vertical split,
      -- or replacing the current buffer (default)
      -- Accepted values are "current", "hsplit" and "vsplit"
      open_notes_in = "current"
    }
  },

  {
    'nvim-orgmode/orgmode',
    lazy = true,
    enabled = false,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/personal/notes/**/*',
        org_default_notes_file = '~/personal/notes/pages/inbox.org',
      })
    end,
  },

  require('becks.plugins.sniprun'),

  require('becks.plugins.package-info'),

  {
    'ThePrimeagen/vim-be-good',
    lazy = true,
    enabled = false,
  },

  require('becks.plugins.rainbow-delimiters'),

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
    event = "BufRead",
    enabled = false,
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = true,
    },

  },


  {
    'slint-ui/vim-slint',
    lazy = true,
  },

  require('becks.plugins.leetcode'),

  { 'codota/tabnine-nvim', build = tabnine_build_path()},

  {
    'alaviss/nim.nvim'
  },

}, {})
