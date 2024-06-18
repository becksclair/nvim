local conditions = require('becks.conditions')
local icons = require('becks.icons')

local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local components = {
  treesitter = {
    function()
      return icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = conditions.hide_in_width,
  },
  copilot = {
    function()
      local buf_clients = vim.lsp.get_clients()
      if #buf_clients == 0 then
        return ""
      end

      -- local buf_ft = vim.bo.filetype
      local copilot_active = false

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name == "copilot" then
          copilot_active = true
        end
      end

      local language_servers = ""
      if copilot_active then
        language_servers = '' .. icons.git.Octoface .. ' '
      end
      return language_servers
    end,
    color = { fg = '#6CC644', gui = "bold" },
    cond = conditions.hide_in_width,
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.get_clients { bufnr = 0 }
      if #buf_clients == 0 then
        return "LSP Inactive"
      end

      -- local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      -- local copilot_active = false

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end

        -- if client.name == "copilot" then
        --   copilot_active = true
        -- end
      end

      -- -- add formatter
      -- local formatters = require "lvim.lsp.null-ls.formatters"
      -- local supported_formatters = formatters.list_registered(buf_ft)
      -- vim.list_extend(buf_client_names, supported_formatters)
      --
      -- -- add linter
      -- local linters = require "lvim.lsp.null-ls.linters"
      -- local supported_linters = linters.list_registered(buf_ft)
      -- vim.list_extend(buf_client_names, supported_linters)
      --
      local unique_client_names = vim.fn.uniq(buf_client_names)
      local language_servers = "" .. #unique_client_names .. " 🧠 "

      -- if copilot_active then
      --   -- language_servers = language_servers .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
      --   language_servers = language_servers .. " " .. icons.git.Octoface .. " "
      -- end

      return language_servers
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
}

return {
  'nvim-lualine/lualine.nvim',
  lazy = true,
  enabled = true,
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  event = "VimEnter",
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      -- theme = 'gruvbox',
      -- theme = 'solarized',
      -- disabled_filetypes = {
      --   'NvimTree',
      -- },
      -- theme = 'nightfox',
      -- theme = 'dayfox',
      -- theme = 'nightfly',
      -- theme = 'onelight',
      section_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
      -- component_separators = { left = '', right = '' },
      component_separators = { left = '→', right = '←' },
    },
    sections = {
      lualine_a = { 'mode' },
      -- lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_b = { 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'fileformat', components.treesitter, components.lsp, components.copilot, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {
        -- {treesitter},
        -- {components.treesitter.text(), color = components.treesitter.color, cond = components.treesitter.cond},
        -- {components.lsp.text(), color = components.lsp.color, cond = components.lsp.cond},
        'encoding',
        'location'
      },
      lualine_y = {},
      lualine_z = {}
    },
    extensions = {
      'quickfix',
      -- 'fugitive',
      -- 'symbols-outline',
      -- 'nvim-tree',
      'toggleterm',
    },
  }
}
