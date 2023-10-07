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

  require('becks.plugins.color-schemes'),
  -- require('becks.plugins.nvim-tree'),
  require('becks.plugins.neo-tree'),

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { },
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
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- Project File navigation
  require('becks.plugins.harpoon'),

  -- Detect tabstop and shiftwidth automatically
  {'tpope/vim-sleuth'},

  -- Undo GUI
  { 'mbbill/undotree' },

  -- Git related plugins
  { 'tpope/vim-fugitive' },

  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").load_extension("lazygit")
    end,
  },

  require('becks.plugins.git-worktree'),

  -- LSP Magic
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {
        'neovim/nvim-lspconfig',
        config = function()
          require('lspconfig').v_analyzer.setup { }
        end
      },             -- Required
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
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
          text = {
            spinner = 'dots_snake'
          },
          window = {
            blend = 40
          }
        }
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      'nlsp-settings.nvim',
    },
  },
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },

  {
    "folke/zen-mode.nvim",
    opts = { }
  },

  {'mfussenegger/nvim-lint'},

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  require('becks.plugins.gitsigns'),

  -- AI Help
  require('becks.plugins.copilot-cmp'),

  -- Animations for bored people
  { 'eandrju/cellular-automaton.nvim' },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { }
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

  -- Show CSS Color previews
  require('becks.plugins.nvim-colorizer'),

  -- Hide Secrets
  { 'laytan/cloak.nvim' },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- { 'mfussenegger/nvim-dap' },
  {'ggandor/leap.nvim'},

  -- vscode pictograms
  { 'onsails/lspkind.nvim' },

  -- Database
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
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

  {"b0o/schemastore.nvim"},

  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   -- See `:help lualine.txt`
  --   requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  --   event = "VimEnter",
  -- },

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
  },

  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup treesitter
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      })

      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/personal/notes/**/*',
        org_default_notes_file = '~/personal/notes/pages/inbox.org',
      })
    end,
  },

  require('becks.plugins.sniprun'),

  {'ThePrimeagen/vim-be-good'},

  -- {'HiPhish/rainbow-delimiters.nvim'}

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

}, {})
