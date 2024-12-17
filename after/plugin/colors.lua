function ColorMyPencils(color)
  vim.o.background = "dark"
  color = color or "melange"
  vim.cmd.colorscheme(color)

  SetMyColorHls()
end

function SetMyColorHls()
  -- Custom highlight colors
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#E66159" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#ffffff", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  if vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#E66159" })
    vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#000000", bg = "#cdd6f4" })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#000000", bg = "#cdd6f4" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#2D4AA3" })
  else
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#A1C1EB", bg = "#263242" })
    vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#263242", bg = "#A1C1EB" })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#222222", bg = "#A1C1EB" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#ECE1D7" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#EBC06D" })
  end
end

vim.api.nvim_create_user_command('SetMyColorHls', SetMyColorHls, {nargs = 0})

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
end
vim.api.nvim_create_user_command('SetTempusTheme', SetTempusTheme, {nargs = 0})

function SetTempusTempestTheme()
  vim.o.background = "dark"
  vim.cmd.colorscheme('tempus_tempest')

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
  vim.cmd.colorscheme("solarized")
end
vim.api.nvim_create_user_command('SetSolarized', SetSolarized, {nargs = 0})

function SetSolarized2()
  vim.o.background = "dark"
  vim.cmd.colorscheme("solarized-dark")
end
vim.api.nvim_create_user_command('SetSolarized2', SetSolarized2, {nargs = 0})

function SetTokyoNight()
  vim.o.background = "dark"
  vim.cmd.colorscheme("tokyonight-night")
  -- SetMyColorHls()
end
vim.api.nvim_create_user_command('SetTokyoNight', SetTokyoNight, {nargs = 0})

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
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#2D4AA3" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetDayFox', SetNightFox, {nargs = 0})


function SetMelange()
  vim.o.background = "light"
  vim.g.melange_enable_font_variants = { italic = false }
  vim.cmd.colorscheme("melange")
  SetMyColorHls()

  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#ffffff", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#ffffff", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#ffffff", bg = "#2D4AA3" })
  vim.api.nvim_set_hl(0, 'Visual', { fg = "#000000", bg = "#cdd6f4" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#000000", bg = "#cdd6f4" })
end
vim.api.nvim_create_user_command('SetMelange', SetMelange, {nargs = 0})

function SetMelangeDark()
  vim.o.background = "dark"
  vim.g.melange_enable_font_variants = { italic = false }
  vim.cmd.colorscheme("melange")
  SetMyColorHls()

  vim.api.nvim_set_hl(0, 'Cursor', { fg = "#263242", bg = "#A1C1EB" })
  vim.api.nvim_set_hl(0, 'TermCursor', { fg = "#263242", bg = "#A1C1EB" })
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#292522", bg = "#ffffff" })

  vim.api.nvim_set_hl(0, 'Visual', { fg = "#263242", bg = "#7F91B2" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#263242", bg = "#7F91B2" })
  vim.api.nvim_set_hl(0, 'LspTextReference', { fg = "#263242", bg = "#7F91B2" })
end
vim.api.nvim_create_user_command('SetMelangeDark', SetMelangeDark, {nargs = 0})

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
  vim.api.nvim_set_hl(0, 'lCursor', { fg = "#062329", bg = "#8cde94" })

  vim.api.nvim_set_hl(0, 'Visual', { fg = "#ffffff", bg = "#0000ff" })
  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetNaysayer', SetNaysayer, {nargs = 0})

function SetVColors()
  vim.o.background = "light"
  vim.cmd.colorscheme("vcolors")

  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetVColors', SetVColors, {nargs = 0})


function SetVColorsDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("vcolors")

  vim.api.nvim_set_hl(0, 'IncSearch', { fg = "#613315", bg = "#E66159" })
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
vim.api.nvim_create_user_command('SetVColorsDark', SetVColorsDark, {nargs = 0})

function SetPaperTheme()
  vim.o.background = "light"
  vim.cmd.colorscheme("paper")

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
-- SetTokyoNight()
-- SetNightFox()
-- SetDayFox()

function SetTheme()
  local env_var = vim.env.TERM_DARK_MODE
  if env_var == "1" then
    SetMelangeDark()
  else
    SetMelange()
  end
end
vim.api.nvim_create_user_command('SetTheme', SetTheme, {nargs = 0})

local utils = require('becks.misc')
if not utils.RunningOnVConsole() then
  SetTheme()
end


-- SetMelange()
-- SetMelangeDark()

-- SetAcmeTheme()
-- SetTempusTheme()
-- SetPaperTheme()
-- SetTempleTheme()
-- SetTempleThemeDark()
-- SetSolarized2()
-- SetGruberDarker()
-- SetNaysayer()
-- SetVColors()
-- SetVColorsDark()
-- SetTempusTheme()
-- SetTempusTempestTheme()
-- SetIntelliJTheme()
-- SetVsAssistTheme()
-- SetFleetTheme()

