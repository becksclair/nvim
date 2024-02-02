if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_animation_length = 0.13
  -- vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_antialiasing = false

  vim.g.neovide_padding_top    = 65
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right  = 5
  vim.g.neovide_padding_left   = 5

  vim.g.neovide_input_macos_alt_is_meta = true

  -- ->
  -- vim.g.neovide_font_features = {
  --   ["Maple Mono NF"] = {
  --     "+cv02",
  --     "+calt",
  --     "+dlig",
  --     "+ss01",
  --     "+ss02",
  --     "+ss03",
  --     "+ss04",
  --     "+ss05",
  --     "+ss06",
  --     "+ss07",
  --     "+ss08",
  --   },
  -- }
  -- vim.o.guifont = 'Maple Mono NF:h11:#e-subpixelantialias'
  -- vim.o.guifont = 'Maple Mono NF,Symbols_Nerd_Font:h11'
  -- vim.o.guifont = 'Maple Mono NF:h11:#e-subpixelantialias'

  vim.opt.linespace = -2

  vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode


  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1/1.25)
  end)
end

function NeoLaptop()
  if not vim.g.neovide then
    print("NeoLaptop: Neovide not running")
    return
  end

  if vim.g.neovide_refresh_rate > 60 then
    vim.g.neovide_refresh_rate = 60
    print("NeoLaptop: Refresh rate set to 60")
  else
    vim.g.neovide_refresh_rate = 120
    print("NeoLaptop: Refresh rate set to 120")
  end
end

-- Function to make the guicursor blink and set to a specific color
-- in Neovide
function NeoCursor()
  -- if not vim.g.neovide then
  --   print("NeoCursor: Neovide not running")
  --   return
  -- end
  local color = '#4A679A' -- vim.fn.input("Color: ")
  local blinkon = '150' -- vim.fn.input("Blink on: ")
  local blinkwait = '150' -- vim.fn.input("Blink wait: ")
  vim.cmd(string.format([[
    set guicursor=n-v-c:block-iCursor
    set guicursor+=i-c:block-blinkon%s-blinkwait%s
    set guicursor+=a:block-blinkon%s
  ]], blinkon, blinkwait, blinkon))
  vim.cmd(string.format("highlight Cursor guifg=%s", color))
  vim.cmd(string.format("highlight iCursor guifg=%s", color))
end

function NeoLineSpace(linespace)
  if not vim.g.neovide then
    print("NeoLineSpace: Neovide not running")
    return
  end

  linespace = linespace or vim.fn.input("Line space: ")
  vim.opt.linespace = tonumber(linespace)
end

