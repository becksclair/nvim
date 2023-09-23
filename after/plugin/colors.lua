if not vim.g.neovide then
  require('rose-pine').setup({
    disable_background = true
  })
  require('tokyonight').setup({
    transparent = true
  })
end

-- local c = require('vscode.colors').get_colors()
-- require('vscode').setup({
--     -- Alternatively set style in setup
--     style = 'light',
--
--     -- Enable transparent background
--     -- transparent = true,
--
--     -- Enable italic comment
--     italic_comments = false,
--
--     -- Disable nvim-tree background color
--     disable_nvimtree_bg = true,
--
--     -- Override colors (see ./lua/vscode/colors.lua)
--     color_overrides = {
--       vscLightBlue = '#000000',
--       vscPopupBack = '#DDDDDD',
--       vscLineNumber = '#000000',
--       vscSelection = '#000000',
--       vscCursorLight = '#0000AA',
--     },
--
--     -- Override highlight groups (see ./lua/vscode/theme.lua)
--     group_overrides = {
--         Visual = { fg='#ffffff', bg='#000000' },
--         -- this supports the same val table as vim.api.nvim_set_hl
--         -- use colors from this colorscheme by requiring vscode.colors!
--         -- Cursor = { fg=c.vscCursorLight, bg='#FFFFFF', bold=true },
--         -- Cursor = { fg='#0000AA', bg='#FFFFFF', bold=true },
--     }
-- })
-- require('vscode').load()
-- require("visual_studio_code").setup({
--   mode = 'light'
-- })

function ColorMyPencils(color)
  vim.o.background = "dark"
  -- vim.o.background = "light"
  color = color or "rose-pine"
  -- color = color or "vcolors"
  -- color = color or "iceberg"
  -- color = color or "vscode"
  -- color = color or "visual_studio_code"
  -- color = color or "tokyonight-night"


  vim.cmd.colorscheme(color)

  -- if not vim.g.neovide then
  --   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  -- end

  -- if vim.g.neovide then
  --   vim.o.background = "light"
  --   color = color or "vscode"
  --   vim.cmd.colorscheme(color)
  -- end
end

function ToggleBg()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    print("ToggleBg: Background set to dark")
  else
    vim.o.background = "light"
    print("ToggleBg: Background set to light")
  end
end

function Transparent()
  if not vim.g.neovide then
    print("Transparent: Neovide not running")
    return
  end

  if vim.g.neovide_transparency < 1.0 then
    vim.g.neovide_transparency = 1.0
    print("Transparent: Transparency set to 1.0")
  else
    vim.g.neovide_transparency = 0.9
    print("Transparent: Transparency set to 0.9")
  end
end

ColorMyPencils()
