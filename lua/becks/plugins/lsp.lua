local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    -- LSP servers and clients communicate which features they support through "capabilities".
    --  By default, Neovim supports a subset of the LSP specification.
    --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
    --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
    --
    -- This can vary by config, but in general for nvim-lspconfig:

    'neovim/nvim-lspconfig',
    lazy = false,

    dependencies = {
      'saghen/blink.cmp',
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { "b0o/schemastore.nvim", lazy = true },
    },

    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,

    -- LSP Server configurations
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('blink.cmp').get_lsp_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local buf_opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', buf_opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', buf_opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', buf_opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', buf_opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', buf_opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', buf_opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', buf_opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', buf_opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', buf_opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', buf_opts)
        end,
      })

      -- LSP Server configurations
      require('mason-lspconfig').setup({
        automatic_installation = true,

        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
        },

        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = lsp_defaults.capabilities
            })
          end,

          -- NOTE: Advanced server setup

          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                  },
                  diagnostics = {
                    globals = { 'vim' },
                    disable = { "missing-fields" },
                  },
                  workspace = {
                    library = {
                      vim.env.VIMRUNTIME
                    },
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              }
            }
          end,

          ["jsonls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.jsonls.setup {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = {
                  enable = true
                }
              }
            }
          end,

          -- ["rust_analyzer"] = function()
          -- end,
        }
      })
    end,
  },
}
