return {
  'mfussenegger/nvim-dap',
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    { 'rcarriga/nvim-dap-ui' },
    { 'nvim-neotest/nvim-nio' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { "ldelossa/nvim-dap-projects" },
    { 'leoluz/nvim-dap-go' },
    -- {'mfussenegger/nvim-dap-python'}
  },
  config = function()
    vim.keymap.set('n', '<F5>', function()
        require('dap').continue()
      end,
      { noremap = true, silent = false, desc = 'Debug' }
    )
    -- vim.keymap.set('n', '<F8>', function()
    --     require('dap').toggle_breakpoint()
    --   end,
    --   { noremap = true, silent = false, desc = 'Continue' }
    -- )
    vim.keymap.set('n', '<F8>', function()
        require('dap').continue()
      end,
      { noremap = true, silent = false, desc = 'Toggle breakpoint' }
    )
    vim.keymap.set('n', '<F9>', function()
        require('dap').toggle_breakpoint()
      end,
      { noremap = true, silent = false, desc = 'Toggle breakpoint' }
    )
    vim.keymap.set('n', '<F10>', function()
        require('dap').step_over()
      end,
      { noremap = true, silent = false, desc = 'Step over' }
    )
    vim.keymap.set('n', '<F11>', function()
        require('dap').step_into()
      end,
      { noremap = true, silent = false, desc = 'Step into' }
    )
    vim.keymap.set('n', '<F12>', function()
        require('dap').step_out()
      end,
      { noremap = true, silent = false, desc = 'Step out' }
    )
    vim.keymap.set('n', '<Leader>dr', function()
        require('dap').repl.open()
      end,
      { noremap = true, silent = false, desc = 'Open DAP repl' }
    )
    vim.keymap.set('n', '<Leader>do', function()
        require('dapui').open()
      end,
      { noremap = true, silent = false, desc = 'Open DAP UI' }
    )
    vim.keymap.set('n', '<Leader>dc', function()
        require('dapui').close()
      end,
      { noremap = true, silent = false, desc = 'Close DAP UI' }
    )
    vim.keymap.set('n', '<Leader>dt', function()
        require('dapui').toggle()
      end,
      { noremap = true, silent = false, desc = 'Toggle DAP UI' }
    )

    require("nvim-dap-projects").search_project_config()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({})
    require('dap-go').setup()
    -- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    -- require('dap-python').test_runner = 'pytest'
  end,
}
