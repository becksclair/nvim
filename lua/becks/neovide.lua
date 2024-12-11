if vim.g.neovide then
  vim.g.neovide_theme = 'auto'
  vim.g.neovide_floating_shadow = true

  vim.g.neovide_refresh_rate = 240
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_animation_length = 0.13
  -- vim.g.neovide_transparency = 1.0
  vim.g.neovide_transparency = 0.9
  -- vim.g.neovide_background_color = "#292522" .. alpha()
  vim.g.neovide_cursor_antialiasing = true

  vim.g.neovide_padding_top    = 5
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right  = 5
  vim.g.neovide_padding_left   = 5

  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  vim.cmd("TransparentDisable")

  vim.opt.linespace = -2


  vim.keymap.set('n', '<A-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<A-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<A-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<A-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<A-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<A-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.25) end)
  vim.keymap.set("n", "<C-->", function() change_scale_factor(1/1.25) end)

  SetMelangeDark()
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
    vim.g.neovide_refresh_rate = 240
    print("NeoLaptop: Refresh rate set to 240")
  end
end
vim.api.nvim_create_user_command('NeoLaptop', NeoLaptop, {nargs = 0})

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
vim.api.nvim_create_user_command('NeoCursor', NeoCursor, { nargs = 0 })

function NeoLineSpace(linespace)
  if not vim.g.neovide then
    print("NeoLineSpace: Neovide not running")
    return
  end

  linespace = linespace or vim.fn.input("Line space: ")
  vim.opt.linespace = tonumber(linespace)
end
vim.api.nvim_create_user_command('NeoLineSpace', NeoLineSpace, { nargs = 1 })

