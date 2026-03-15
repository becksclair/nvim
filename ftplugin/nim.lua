-- ~/.config/nvim/ftplugin/nim.lua

-- Idiomatic Neovim Lua ftplugin for Nim

-- avoid re-running the ftplugin
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = true

-- convenience locals
local bo = vim.bo
local opt = vim.opt_local

-- indentation/tab behaviour (matches original intent + modeline)
bo.expandtab = true        -- use spaces, not tabs
bo.shiftwidth = 2         -- indentation size for >>, <<, etc.
bo.softtabstop = 2        -- number of spaces a Tab counts for while editing
bo.tabstop = 4            -- width of a hard tab (keeps file-modeline behaviour)

-- comments & commentstring
-- original used `setlocal comments=:#,:##` and `commentstring=#\ %s`
opt.comments = ":#,:##"
bo.commentstring = "# %s" -- in Lua we can write the space directly

-- formatoptions adjustments: remove 't' and add 'c', 'r', 'o', 'q', 'l'
opt.formatoptions:remove("t")
opt.formatoptions:append("croql")

-- add .nim to command-line completion suffixes
-- (append, not overwrite — safer if user has other suffixes configured)
opt.suffixesadd:append(".nim")

-- (No undo_ftplugin / cpo juggling / modeline Vimscript — modern Neovim handles nocompatible by default)

-- vim.opt_local.expandtab = true
-- vim.opt_local.shiftwidth = 2
-- vim.opt_local.tabstop = 2
-- vim.opt_local.softtabstop = 2
-- vim.opt_local.autoindent = true
--
