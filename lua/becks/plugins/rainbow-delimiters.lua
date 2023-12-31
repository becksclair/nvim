return {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = true,
    event = "BufRead",
    enabled = false,
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.cmd [[
        highlight RainbowDelimiterBlue guifg=#80a7fb ctermfg=White
        highlight RainbowDelimiterCyan guifg=#9ccfd8 ctermfg=White
        highlight RainbowDelimiterGreen guifg=#31748f ctermfg=White
        highlight RainbowDelimiterOrange guifg=#d65d0e ctermfg=White
        highlight RainbowDelimiterRed guifg=#E66159 ctermfg=White
        highlight RainbowDelimiterViolet guifg=#ebbcba ctermfg=White
        highlight RainbowDelimiterYellow guifg=#f6c177 ctermfg=White
      ]]


      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterViolet',
          'RainbowDelimiterBlue',
          'RainbowDelimiterCyan',
          'RainbowDelimiterGreen',
          'RainbowDelimiterOrange',
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
        },
        blacklist = { 'c', 'cpp' },
      }
    end
  }
