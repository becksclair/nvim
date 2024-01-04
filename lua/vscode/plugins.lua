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

  -- Highlight, edit, and navigate code
  require('becks.plugins.treesitter'),

  -- { 'nvim-treesitter/playground' },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    lazy = true,
    event = "BufRead"
  },

  -- LSP Magic
  require('becks.plugins.lsp-zero'),

  {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = "BufReadPost",
    config = function()
      require('lint').linters_by_ft = {
        -- markdown = {'vale',},
        python = { 'flake8', 'pylint', },
        sql = { 'sqlfluff', },

        bash = { 'shellcheck', },
        shell = { 'shellcheck', },
        zsh = { 'shellcheck', },

        -- vlang = { 'vlang' },

        -- rust = { 'clippy' }
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })

      require('lint').linters.shellcheck.args = {
        '-s',
        'bash',
        '--format',
        'json',
        '-'
      }

      -- local function parse_vlang_check(output, bufnr)
      --
      -- end

      -- require('lint').linters.vlang = {
      --   name = 'vlang',
      --   cmd = 'v',
      --   stdin = false,
      --   args = {'-check', '.'},
      --   stream = 'both',
      --   ignore_exitcode = true,
      --   parser = require('lint.parser').from_errorformat(errorformat),
      -- }

      vim.keymap.set("n", "<leader>bl", require("lint").try_lint, { desc = "Lint file" })
    end
  },

  -- AI Help
  -- require('becks.plugins.copilot-cmp'),

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

}, {})
