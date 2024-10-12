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
  spec = {
    -- import your plugins
    { import = "becks.plugins" },
  },

  -- automatically check for plugin updates
  checker = { enabled = false },

  defaults = { lazy = true },

  install = {
    colorscheme = { "tempus_tempest" }
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
