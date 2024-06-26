return {
  {
    "anshai-git/clarity.nvim",
    priority = 1000,
    dir = "~/projects/clarity.nvim",
  },
  -- { dir = "c:/dev/projects/nvim-naysayer/naysayer" },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      options = {
        -- transparent = true
      }
    }
  },
  {
    'BoHomola/vsassist.nvim',
    priority = 1000,
  },
  {
    'yorickpeterse/vim-paper',
    priority = 1000,
  },
  {
    'protesilaos/tempus-themes-vim',
    priority = 1000,
  },
  {
    'plan9-for-vimspace/acme-colors',
    priority = 1000,
  },
  {
    "blazkowolf/gruber-darker.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      bold = true,
    }
  },

  {
    'maxmx03/solarized.nvim',
    -- lazy = true,
    enabled = false,
    priority = 1000,
    opts = {
      -- theme = 'neo'
      palette = 'solarized'
    }
  },
  {
    'ishan9299/nvim-solarized-lua',
    priority = 1000,
  },

  -- {
  --   'HiPhish/resolarized.nvim',
  --   url = 'git@gitlab.com:HiPhish/resolarized.nvim.git',
  --   priority = 1000,
  -- },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    -- lazy = true,
    priority = 1000,
    opts = {
      disable_background = true,
      -- transparent = true
    },
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },

  {
    'cocopon/iceberg.vim',
    lazy = true,
  },

  {
    'Mofiqul/vscode.nvim',
    -- lazy = true,
    priority = 1000,
    -- opts = {
    --   -- Alternatively set style in setup
    --   style = 'light',
    --
    --   -- Enable transparent background
    --   -- transparent = true,
    --
    --   -- Enable italic comment
    --   italic_comments = false,
    --
    --   -- Disable nvim-tree background color
    --   disable_nvimtree_bg = true,
    --
    --   -- Override colors (see ./lua/vscode/colors.lua)
    --   color_overrides = {
    --     vscLightBlue = '#000000',
    --     vscPopupBack = '#DDDDDD',
    --     vscLineNumber = '#000000',
    --     vscSelection = '#000000',
    --     vscCursorLight = '#0000AA',
    --   },
    --
    --   -- Override highlight groups (see ./lua/vscode/theme.lua)
    --   group_overrides = {
    --       Visual = { fg='#ffffff', bg='#000000' },
    --       -- this supports the same val table as vim.api.nvim_set_hl
    --       -- use colors from this colorscheme by requiring vscode.colors!
    --       -- Cursor = { fg=c.vscCursorLight, bg='#FFFFFF', bold=true },
    --       -- Cursor = { fg='#0000AA', bg='#FFFFFF', bold=true },
    --   }
    -- },
    -- config = function()
    --   -- require('vscode').load()
    --   -- vim.opt.background = 'light'
    --   -- vim.cmd.colorscheme 'vscode'
    -- end,
  },

  -- V-Colors
  {
    dir = '~/projects/neovim/nvim-vcolors',
    -- dev = true,
    priority = 1000,
    -- config = function()
    --   vim.opt.background = 'light'
    -- end,
  },

  {
    'dim13/smyck.vim',
    lazy = true,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      compile = true,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
          return {}
      end,
      theme = "wave",              -- Load "wave" theme when 'background' option is not set
      background = {               -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
      },
    }
  },

  {
    'chiendo97/intellij.vim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd('set background=light')
      vim.cmd('colorscheme intellij')
    end
  },

  {
    "felipeagc/fleet-theme-nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd('set background=dark')
      vim.cmd('colorscheme fleet')
    end
  }
}
