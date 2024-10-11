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

  -- require('rose-pine').setup({
  --     disable_background = true
  -- })

  vim.g.rose_pine_disable_background = true
  vim.cmd.colorscheme(color)

  SetMyColorHls()
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

function SetMyColorHls()
  -- Custom highlight colors
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#E66159" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#f6c177" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#f6c177" })
  -- vim.api.nvim_set_hl(0, 'lCursor', { fg = "#ffffff", bg = "#f6c177" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#E66159" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#ffffff", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })


  -- vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
  -- vim.api.nvim_set_hl(0, 'NonText', { bg = "none" })
end

function SetAcmeTheme()
  vim.o.background = "light"
  vim.cmd.colorscheme('acme')
  SetMyColorHls()

  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#000000", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#000000", bg = "#eeee9e" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#000000", bg = "#eaffff" })

end

vim.api.nvim_create_user_command('SetAcmeTheme', SetAcmeTheme, {nargs = 0})


function SetIntelliJTheme()
  vim.o.background = "light"
  vim.cmd.colorscheme('intellij')
  SetMyColorHls()

  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })

  vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#f0f2fc" }) -- Background for the cursor line
  vim.api.nvim_set_hl(0, 'CursorColumn', { bg = "#f0f2fc" }) -- Background for the cursor column
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#FFFF00", bg = "#001CAC" })

  -- Set the cursor color
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#98a3d9" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { gui = "reverse" })
  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#FFFF00", bg = "#001CAC" })
end

vim.api.nvim_create_user_command('SetIntelliJTheme', SetIntelliJTheme, {nargs = 0})

function SetTempusTheme()
  vim.o.background = "light"
  vim.cmd.colorscheme('tempus_day')
  -- SetMyColorHls()

  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  -- vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })

end
vim.api.nvim_create_user_command('SetTempusTheme', SetTempusTheme, {nargs = 0})


function SetTempusTempestTheme()
  vim.o.background = "dark"
  vim.cmd.colorscheme('tempus_tempest')

  -- SetMyColorHls()

  -- vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#0000ff" })

  vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#111111" }) -- Background for the cursor line
  vim.api.nvim_set_hl(0, 'CursorColumn', { bg = "#f0f2fc" }) -- Background for the cursor column
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#FFFF00", bg = "#001CAC" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetTempusTempestTheme', SetTempusTheme, {nargs = 0})

function SetVsAssistTheme()
  vim.o.background = "dark"
  vim.cmd.colorscheme('vsassist')
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetVsAssistTheme', SetTempusTheme, {nargs = 0})

function SetTempleTheme()
  vim.o.background = "light"
  local color = "vscode"
  vim.cmd.colorscheme(color)


  local c = require('vscode.colors').get_colors()
  require('vscode').setup({

    -- Alternatively set style in setup
    style = 'light',

    -- Enable transparent background
    -- transparent = true,

    -- Enable italic comment
    italic_comments = false,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
      vscLightBlue = '#000000',
      vscPopupBack = '#DDDDDD',
      vscLineNumber = '#000000',
      vscSelection = '#000000',
      vscCursorLight = '#0000AA',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        Visual = { fg='#ffffff', bg='#000000' },
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        -- Cursor = { fg=c.vscCursorLight, bg='#FFFFFF', bold=true },
        -- Cursor = { fg='#0000AA', bg='#FFFFFF', bold=true },
    }
  })
  require('vscode').load()

  SetMyColorHls()

  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })


  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#FFFF00", bg = "#000000" })
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

  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#2D4AA3" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#2D4AA3" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetDayFox', SetNightFox, {nargs = 0})

function SetGruberDarker()
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruber-darker")
  SetMyColorHls()
end
vim.api.nvim_create_user_command('SetGruberDarker', SetGruberDarker, {nargs = 0})

function SetNaysayer()
  vim.o.background = "dark"
  vim.cmd.colorscheme("clarity")
  -- SetMyColorHls()
  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetNaysayer', SetNaysayer, {nargs = 0})

function SetVColors()
  vim.o.background = "light"
  vim.cmd.colorscheme("vcolors")
  -- SetMyColorHls()
  --  vim.api.nvim_set_hl(0, 'Normal', { fg = "#F5F5F5", bg = "None" })

  -- vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetVColors', SetVColors, {nargs = 0})


function SetPaperTheme()
  vim.o.background = "light"
  vim.cmd.colorscheme("paper")
  -- SetMyColorHls()
   -- vim.api.nvim_set_hl(0, 'Normal', { fg = "#F5F5F5", bg = "None" })

  -- vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  -- vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })


  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#FFFF00", bg = "#000000" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#FFFF00", bg = "#000000" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetPaperTheme', SetPaperTheme, {nargs = 0})


function SetFleetTheme()
  vim.cmd.colorscheme("fleet")

  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  -- vim.api.nvim_set_hl(0, 'Cursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetFleetTheme', SetFleetTheme, {nargs = 0})

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
-- SetAcmeTheme()
-- SetTempusTheme()
-- SetPaperTheme()
-- SetTempleTheme()
-- SetTempleThemeDark()
-- SetSolarized2()
-- SetGruberDarker()
-- SetNaysayer()
-- SetVColors()
-- SetTempusTheme()
SetTempusTempestTheme()
-- SetIntelliJTheme()
-- SetVsAssistTheme()
-- SetFleetTheme()

