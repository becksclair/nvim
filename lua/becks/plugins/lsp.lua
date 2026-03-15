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

        ensure_installed = { "markdownlint-cli2", "markdown-toc" },
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

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local configs = require("lspconfig.configs")

      if not configs.oxfmt then
        configs.oxfmt = {
          default_config = {
            cmd = { "oxfmt", "--lsp" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "json",
              "jsonc",
              "json5",
              "yaml",
              "toml",
              "html",
              "css",
              "scss",
              "less",
              "markdown",
              "markdown.mdx",
              "vue",
            },
            root_dir = util.root_pattern(".oxfmtrc.json"),
            single_file_support = false,
          },
        }
      end

      if not configs.nushell then
        configs.nushell = {
          default_config = {
            cmd = { "nu", "--lsp" },
            filetypes = { "nu" },
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1] or fname)
            end,
            single_file_support = true,
          },
        }
      end

      lspconfig.oxfmt.setup({
        capabilities = lsp_defaults.capabilities,
        on_new_config = function(new_config, root_dir)
          local local_cmd = util.path.join(root_dir, "node_modules", ".bin", "oxfmt")
          if vim.fn.executable(local_cmd) == 1 then
            new_config.cmd = { local_cmd, "--lsp" }
          end
        end,
      })

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
          vim.keymap.set({ 'n', 'x' }, '<F3>', function()
            require("conform").format({ async = true })
          end, buf_opts)
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
            lspconfig.jsonls.setup {
              filetypes = { "json", "jsonc", "json5" },
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = {
                  enable = true
                }
              }
            }
          end,

          ["oxlint"] = function()
            lspconfig.oxlint.setup {
              capabilities = lsp_defaults.capabilities,
              root_dir = util.root_pattern(".oxlintrc.json"),
              single_file_support = false,
              on_new_config = function(new_config, root_dir)
                local local_cmd = util.path.join(root_dir, "node_modules", ".bin", "oxc_language_server")
                if vim.fn.executable(local_cmd) == 1 then
                  new_config.cmd = { local_cmd }
                end
              end,
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
        }
      })

      if vim.fn.executable("nu") == 1 then
        lspconfig.nushell.setup {
          capabilities = lsp_defaults.capabilities,
          cmd = { "nu", "--lsp" },
          filetypes = { "nu" },
        }
      end

      -- require'lspconfig'.v_analyzer.setup{}
    end,
  },
}
