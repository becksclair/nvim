-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- NOTE: Install package manager https://github.com/folke/lazy.nvim
--`:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
  spec = {
    -- import your plugins
    { import = "becks.plugins" },
  },

  git = {
    timeout = 600, -- seconds (10 minutes)
    -- optional: rate-limit network ops if needed
    throttle = {
      enabled = true,
      rate = 4,         -- max 2 ops
      duration = 5 * 1000, -- per 5000 ms
    },
  },

  concurrency = 10,

  -- automatically check for plugin updates
  checker = { enabled = false },

  defaults = { lazy = true },

  install = {
    -- colorscheme = { "tempus_tempest" }
    colorscheme = { "catppuccin" }
  },

  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

})
