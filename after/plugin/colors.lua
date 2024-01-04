function ColorMyPencils(color)
  vim.o.background = "dark"
  -- vim.o.background = "light"
  color = color or "rose-pine"
  -- color = color or "vcolors"
  -- color = color or "iceberg"
  -- color = color or "vscode"
  -- color = color or "visual_studio_code"
  -- color = color or "tokyonight-night"
  -- color = color or "smyck"
  -- color = color or "kanagawa-wave"

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
  SetMyColorHls()
end

function SetMyColorHls()
  -- Custom highlight colors
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#E66159" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#f6c177" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#f6c177" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#ffffff", bg = "#f6c177" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#E66159" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#ffffff", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })


  -- vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
  -- vim.api.nvim_set_hl(0, 'NonText', { bg = "none" })
end

function SetTempleTheme()
  vim.o.background = "light"
  local color = "vscode"
  vim.cmd.colorscheme(color)
  SetMyColorHls()

  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })

end

function SetTempleThemeDark()
  vim.o.background = "dark"
  require("kanagawa").load("wave")
  -- vim.cmd.colorscheme(color)
  SetMyColorHls()
end

vim.api.nvim_create_user_command('SetTempleTheme', SetTempleTheme, {nargs = 0})
vim.api.nvim_create_user_command('SetTempleThemeDark', SetTempleThemeDark, {nargs = 0})

function SetSolarized()
  vim.o.background = "dark"
  -- vim.g.neosolarized_contrast = "low"
  -- vim.g.neosolarized_visibility = "normal"
  -- vim.g.neosolarized_termBoldAsBright = false
  vim.cmd.colorscheme("solarized")
  -- SetMyColorHls()
end
vim.api.nvim_create_user_command('SetSolarized', SetSolarized, {nargs = 0})

function SetSolarized2()
  vim.o.background = "dark"
  -- vim.g.neosolarized_contrast = "low"
  -- vim.g.neosolarized_visibility = "normal"
  -- vim.g.neosolarized_termBoldAsBright = false
  vim.cmd.colorscheme("solarized-dark")
  -- SetMyColorHls()
end
vim.api.nvim_create_user_command('SetSolarized2', SetSolarized2, {nargs = 0})



function SetNightFox()
  vim.o.background = "dark"
  vim.cmd.colorscheme("nightfox")
  SetMyColorHls()
end
vim.api.nvim_create_user_command('SetNightFox', SetNightFox, {nargs = 0})

function SetDayFox()
  vim.o.background = "light"
  vim.cmd.colorscheme("dayfox")
  SetMyColorHls()
end
vim.api.nvim_create_user_command('SetDayFox', SetNightFox, {nargs = 0})

function SetGruberDarker()
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruber-darker")
  SetMyColorHls()
end
vim.api.nvim_create_user_command('SetGruberDarker', SetNightFox, {nargs = 0})

function SetNaysayer()
  vim.o.background = "dark"
  vim.cmd.colorscheme("clarity")
  -- SetMyColorHls()
  -- vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetNaysayer', SetNightFox, {nargs = 0})



-- function ToggleBg()
--   if vim.o.background == "light" then
--     vim.o.background = "dark"
--     print("ToggleBg: Background set to dark")
--   else
--     vim.o.background = "light"
--     print("ToggleBg: Background set to light")
--   end
-- end
--
-- function Transparent()
--   if not vim.g.neovide then
--     print("Transparent: Neovide not running")
--     return
--   end
--
--   if vim.g.neovide_transparency < 1.0 then
--     vim.g.neovide_transparency = 1.0
--     print("Transparent: Transparency set to 1.0")
--   else
--     vim.g.neovide_transparency = 0.9
--     print("Transparent: Transparency set to 0.9")
--   end
-- end

-- ColorMyPencils()
-- SetNightFox()
-- SetDayFox()
-- SetTempleTheme()
-- SetTempleThemeDark()
-- SetSolarized2()
-- SetGruberDarker()
SetNaysayer()

