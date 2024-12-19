local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require("mason").setup({
        PATH = "prepend", -- Ensures Mason uses the system PATH

        ui = {
          icons = {
            package_installed = "",
            package_pending = "➜",
            package_uninstalled = "✗"
          },
          border = "rounded",
        },

        pip = {
          ---@since 1.0.0
          -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
          upgrade_pip = true,
        },
      })
    end,
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
      { "b0o/schemastore.nvim",             lazy = true },
      { "folke/neoconf.nvim" },
      -- { 'tamago324/nlsp-settings.nvim', }
    },

    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,

    -- LSP Server configurations
    config = function()
      require("neoconf").setup({
        -- override any of the default settings here
        import = {
          vscode = true, -- local .vscode/settings.json
          coc = true, -- global/local coc-settings.json
          nlsp = false, -- global/local nlsp-settings.nvim json settings
        },
      })

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

          ["cssmodules_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.cssmodules_ls.setup {
              filetypes = { 'css', 'scss', 'sass' },
            }
          end,

          ["yamlls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.yamlls.setup {
              yaml = {
                customTags = {
                  "!Base64",
                  "!Cidr",
                  "!FindInMap sequence",
                  "!GetAtt",
                  "!GetAZs",
                  "!ImportValue",
                  "!Join sequence",
                  "!Ref",
                  "!Select sequence",
                  "!Split sequence",
                  "!Sub sequence",
                  "!Sub",
                  "!And sequence",
                  "!Condition",
                  "!Equals sequence",
                  "!If sequence",
                  "!Not sequence",
                  "!Or sequence",
                  -- OpenAPI
                  "$ref",
                },
              }
            }
          end,

          ["bashls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.bashls.setup {
              filetypes = { 'sh', 'bash', 'zsh', 'shell' },
              settings = {
                bashIde = {
                  globPattern = "*@(.sh|.inc|.bash|.command)"
                },
              },
            }
          end,

          ["v_analyzer"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.v_analyzer.setup {
              cmd = { '/data/data/com.termux/files/home/.config/v-analyzer/bin/v-analyzer' },
              filetypes = { 'v', 'vv', 'vsh', 'vlang' },
              root_pattern = { 'v.mod', "build.vsh", '.v-analyzer' },
              -- root_dir = function()
              --     return vim.fn.getcwd() -- or return a custom root directory path
              -- end,
            }
          end,

          -- ["rust_analyzer"] = function()
          -- end,
        }
      })

      -- require'lspconfig'.v_analyzer.setup{}
    end,
  },
}
