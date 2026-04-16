return {
  'catgoose/nvim-colorizer.lua',
  event = "BufEnter",
  opts = {
    filetypes = { "*" },
    buftypes = {},
    user_commands = true,
    options = {
      parsers = {
        -- Enable named colors (Blue, red, etc.)
        names = {
          enable = true,
          lowercase = true,
          camelcase = true,
        },
        -- Hex color formats (#RGB, #RRGGBB, etc.)
        hex = {
          default = true,
          rgb = true,
          rgba = true,
          rrggbb = true,
          rrggbbaa = false,
          aarrggbb = false,
        },
        -- CSS functions: rgb(), rgba(), hsl(), hsla()
        rgb = { enable = true },
        hsl = { enable = true },
        -- Enable all CSS features preset
        css = true,
        css_fn = true,
        -- Tailwind colors
        tailwind = {
          enable = true,
          lsp = false,
        },
        -- Sass variables
        sass = {
          enable = true,
          parsers = { css = true },
        },
      },
      display = {
        mode = "background",
        virtualtext = {
          char = "■",
          position = "after",
          hl_mode = "foreground",
        },
      },
      always_update = true,
    },
  },
}
