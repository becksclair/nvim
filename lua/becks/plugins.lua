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
    -- lazy = false,
    -- priority = 1000,
    -- opts = {},
  },

  { 'cocopon/iceberg.vim' },
  -- {
  --   'Mofiqul/vscode.nvim',
  --   priority = 1000,
  --   config = function()
  --     -- vim.opt.background = 'light'
  --     -- vim.cmd.colorscheme 'vscode'
  --   end,
  -- },

  -- V-Colors
  -- {
  --   dir = '~/projects/nvim-vcolors',
  --   dev = true,
  --   priority = 1000,
  --   config = function()
  --     vim.opt.background = 'light'
  --   end,
  -- },

  { 'dim13/smyck.vim' },
  { 'rebelot/kanagawa.nvim' },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },
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
  { 'ThePrimeagen/harpoon' },

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

  {'ThePrimeagen/git-worktree.nvim'},

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
      -- current_line_blame = true,
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        vim.cmd [[
          :highlight GitGutterAdd guibg=#1e2132 ctermbg=235
          :highlight GitGutterChange guibg=#1e2132 ctermbg=235
          :highlight GitGutterChangeDelete guibg=#1e2132 ctermbg=235
          :highlight GitGutterDelete guibg=#1e2132 ctermbg=235
          " :highlight SignColumn guibg=#1e2132 ctermbg=235
          :highlight SignColumn guibg=none ctermbg=235
          :highlight GitSignsAdd guibg=NONE ctermbg=235
          :highlight GitSignsChange guibg=NONE ctermbg=235
          :highlight GitSignsDelete guibg=NONE ctermbg=235
        ]]

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
            ['*'] = true
            -- lua = true,
            -- javascript = true,
            -- javascriptreact = true,
            -- typescript = true,
            -- typescriptreact = true,
            -- yaml = true,
            -- markdown = true,
            -- help = false,
            -- gitcommit = true,
            -- gitrebase = true,
            -- hgcommit = true,
            -- svn = false,
            -- cvs = false,
            -- ["."] = false,
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

  -- { 'ChAoSUnItY/v-vim' },

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

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    event = "VimEnter",
  },

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

  { 'michaelb/sniprun', build = 'bash ./install.sh' },

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

  -- { 'michaelb/sniprun', build = 'bash ./install.sh' },

}, {})
