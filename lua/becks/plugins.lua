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


-- NOTE: Lazy plugins

require('lazy').setup({
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'cocopon/iceberg.vim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'iceberg'
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
    build = ':TSUpdate',
  },
  { 'nvim-treesitter/playground' },

  -- Project File navigation
  { 'ThePrimeagen/harpoon' },


  -- Code Refactoring
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("refactoring").setup()
  --   end,
  -- },

  -- Detect tabstop and shiftwidth automatically
  {'tpope/vim-sleuth'},

  -- Undo GUI
  { 'mbbill/undotree' },

  -- Git related plugins
  { 'tpope/vim-fugitive' },

  -- Ediditiing context
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- LSP Magic
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' },
    }
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = true,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = function()
          pcall(function()
            require("mason-registry").refresh()
          end)
        end,
        event = "User FileOpened",
      },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      'nlsp-settings.nvim',
    },
  },
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',         opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  -- AI Help
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          panel = {
            enabled = true,
            auto_refresh = true,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<M-CR>"
            },
            layout = {
              position = "bottom", -- | top | left | right
              ratio = 0.4
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = false,
            debounce = 75,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          },
          filetypes = {
            lua = true,
            javascript = true,
            javascriptreact = true,
            typescript = true,
            typescriptreact = true,
            yaml = true,
            markdown = true,
            help = false,
            gitcommit = true,
            gitrebase = true,
            hgcommit = true,
            svn = false,
            cvs = false,
            ["."] = false,
          },
          copilot_node_command = 'node', -- Node.js version must be > 16.x
          server_opts_overrides = {},
        })
        require("copilot_cmp").setup()
      end, 100)
    end,
  },

  -- Animations for bored people
  { 'eandrju/cellular-automaton.nvim' },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = "User FileOpened",
  },

  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },

  { 'ChAoSUnItY/v-vim' },

  -- Show CSS Color previews
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- Hide Secrets
  { 'laytan/cloak.nvim' },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    -- config = function()
      -- require("chatgpt").setup()
    -- end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- { 'mfussenegger/nvim-dap' },
  {'ggandor/leap.nvim'},

  -- open github urls
  -- 'tpope/vim-rhubarb',

  -- vscode pictograms
  -- { 'onsails/lspkind.nvim' },






  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.

  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   cmd = { "LspInstall", "LspUninstall" },
  --   event = "User FileOpened",
  --   dependencies = "mason.nvim",
  -- },

  -- {
  --   -- LSP Configuration & Plugins
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     -- Automatically install LSPs to stdpath for neovim
  --     {
  --       'williamboman/mason.nvim',
  --       config = true,
  --       cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  --       build = function()
  --         pcall(function()
  --           require("mason-registry").refresh()
  --         end)
  --       end,
  --       event = "User FileOpened",
  --     },
  --     'williamboman/mason-lspconfig.nvim',

  --     -- Useful status updates for LSP
  --     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  --     { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

  --     -- Additional lua configuration, makes nvim stuff amazing!
  --     'folke/neodev.nvim',

  --     'nlsp-settings.nvim',
  --   },
  -- },

  --
  -- { "Tastyep/structlog.nvim",       lazy = true },

  --   "hrsh7th/cmp-cmdline",
  --   lazy = true,
  --   enabled = true,
  -- },

  -- {
  --   -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '|' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --     on_attach = function(bufnr)
  --       vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
  --         { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
  --       vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
  --       vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
  --     end,
  --   },
  -- },

  -- {
  --   'oahlen/iceberg.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'iceberg'
  --   end,
  -- },

  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       icons_enabled = true,
  --       theme = 'auto',
  --       section_separators = { left = '', right = '' },
  --       component_separators = { left = '→', right = '←' },
  --     },
  --     sections = {
  --       lualine_a = { 'mode' },
  --       lualine_b = { 'branch', 'diff', 'diagnostics' },
  --       lualine_c = { 'filename' },
  --       lualine_x = { 'fileformat', 'filetype' },
  --       lualine_y = { 'progress' },
  --       lualine_z = { 'location' }
  --     },
  --     inactive_sections = {
  --       lualine_a = {},
  --       lualine_b = {},
  --       lualine_c = { 'filename' },
  --       lualine_x = { 'encoding', 'location' },
  --       lualine_y = {},
  --       lualine_z = {}
  --     },
  --     extensions = {
  --       'quickfix',
  --       'fugitive',
  --       'symbols-outline',
  --       'nvim-tree',
  --       'toggleterm'
  --     },
  --   },
  --   event = "VimEnter",
  -- },
  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     char = '┊',
  --     show_trailing_blankline_indent = true,
  --   },
  -- },

  -- {
  --   "tamago324/lir.nvim",
  --   config = function()
  --     -- require("lvim.core.lir").setup()
  --   end,
  --   enabled = true,
  --   event = "User DirOpened",
  -- },

  -- { "gcmt/wildfire.vim" },

  -- { "rafcamlet/nvim-whid" },
  -- { 'michaelb/sniprun',            build = 'bash ./install.sh' },

  -- {
  --   'phaazon/hop.nvim',
  --   branch = 'v2', -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  --   end
  -- },

  -- {
  --   "rmagatti/goto-preview",
  --   config = function()
  --     require('goto-preview').setup {
  --       width = 120,              -- Width of the floating window
  --       height = 25,              -- Height of the floating window
  --       default_mappings = false, -- Bind default mappings
  --       debug = false,            -- Print debug information
  --       opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
  --       post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
  --       -- You can use "default_mappings = true" setup option
  --       -- Or explicitly set keybindings
  --       -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
  --       -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
  --       -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
  --     }
  --   end
  -- },

  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
