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
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
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
            root_dir = util.root_pattern(".oxfmtrc.json", ".git", "package.json"),
            single_file_support = true,
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
          -- Prefer local project oxfmt, fall back to global
          local local_cmd = vim.fs.joinpath(root_dir, "node_modules", ".bin", "oxfmt")
          if vim.fn.executable(local_cmd) == 1 then
            new_config.cmd = { local_cmd, "--lsp" }
          elseif vim.fn.executable("oxfmt") == 0 then
            -- No oxfmt available at all - use conform.nvim instead for formatting
            new_config.enabled = false
          end
          -- If global oxfmt exists, use default cmd from config
        end,
        on_attach = function(client, bufnr)
          -- Disable oxfmt LSP formatter if conform.nvim is available
          -- conform.nvim handles formatting via CLI, avoiding double-format
          local has_conform = pcall(require, "conform")
          if has_conform and client.server_capabilities then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
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
            -- Enhanced oxlint wrapper with smart tsconfig discovery
            -- Features: auto-discovers tsconfig, monorepo-aware, auto-generates fallback
            local wrapper_cmd = vim.fn.expand("~/.agents/bin/oxlint-lsp-enhanced.ts")
            local has_wrapper = vim.fn.executable(wrapper_cmd) == 1

            lspconfig.oxlint.setup {
              capabilities = lsp_defaults.capabilities,
              filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
                "astro",
                "svelte",
              },
              root_dir = util.root_pattern(
                ".oxlintrc.json",
                "oxlint.config.ts",
                ".git",
                "package.json"
              ),
              single_file_support = true,
              cmd = has_wrapper and { wrapper_cmd } or { "oxlint", "--lsp", "--type-aware" },
              on_new_config = function(new_config, root_dir)
                -- Prefer local project oxlint if available (for non-wrapped setups)
                if not has_wrapper then
                  local local_cmd = vim.fs.joinpath(root_dir, "node_modules", ".bin", "oxlint")
                  if vim.fn.executable(local_cmd) == 1 then
                    new_config.cmd = { local_cmd, "--lsp", "--type-aware" }
                  end
                end

                -- Set environment variables for the enhanced wrapper
                new_config.cmd_env = vim.tbl_extend("force", new_config.cmd_env or {}, {
                  OXLINT_GLOBAL_CONFIG = vim.fn.expand("~/.agents/.oxlintrc.json"),
                  OXLINT_CACHE_DIR = vim.fn.expand("~/.agents/cache/oxlint"),
                })
              end,
              on_attach = function(client, bufnr)
                -- Add :OxcFixAll command for applying auto-fixes
                vim.api.nvim_buf_create_user_command(bufnr, "OxcFixAll", function()
                  client:exec_cmd({
                    title = "Apply Oxlint auto-fixes",
                    command = "oxc.fixAll",
                    arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
                  })
                end, { desc = "Apply Oxlint automatic fixes" })
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

      -- TypeScript-Go: Fast native implementation of TypeScript LSP
      -- Install: npm i -g @typescript/native-preview
      -- Features: errors, hover, goto-definition (completions not yet available)
      -- Note: Auto-enabled if tsgo is found in PATH. To disable, uninstall tsgo or
      -- set OXLINT_DISABLE_TSGO=1 environment variable.
      local disable_tsgo = vim.env.OXLINT_DISABLE_TSGO == "1"
      if vim.fn.executable("tsgo") == 1 and not disable_tsgo then
        -- Custom config for tsgo since it's not in nvim-lspconfig yet
        if not configs.tsgo then
          configs.tsgo = {
            default_config = {
              cmd = { "tsgo", "lsp", "--stdio" },
              filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
              },
              root_dir = util.root_pattern(
                "tsconfig.json",
                "jsconfig.json",
                "package.json",
                "pnpm-lock.yaml",
                "package-lock.json",
                "yarn.lock",
                "bun.lockb",
                ".git"
              ),
              single_file_support = true,
            },
          }
        end

        lspconfig.tsgo.setup {
          capabilities = lsp_defaults.capabilities,
          on_attach = function(client, bufnr)
            -- Check if vtsls is already attached
            local function check_vtsls()
              for _, other_client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
                if other_client.name == "vtsls" and other_client.id ~= client.id then
                  vim.schedule(function()
                    if client:is_stopped() then return end
                    client.stop()
                    vim.notify("TypeScript-Go LSP stopped (using vtsls instead)", vim.log.levels.INFO)
                  end)
                  return true
                end
              end
              return false
            end

            -- Check immediately
            if check_vtsls() then return end

            -- Also set up an autocmd to check when other LSPs attach
            local group = vim.api.nvim_create_augroup("tsgo_vtsls_check_" .. client.id, { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
              group = group,
              buffer = bufnr,
              callback = function(args)
                local new_client = vim.lsp.get_client_by_id(args.data.client_id)
                if new_client and new_client.name == "vtsls" then
                  vim.schedule(function()
                    if client:is_stopped() then return end
                    client.stop()
                    vim.notify("TypeScript-Go LSP stopped (vtsls attached)", vim.log.levels.INFO)
                  end)
                  vim.api.nvim_del_augroup_by_id(group)
                end
              end,
            })

            -- Clean up autocmd when tsgo detaches
            vim.api.nvim_create_autocmd("LspDetach", {
              group = group,
              buffer = bufnr,
              once = true,
              callback = function()
                pcall(vim.api.nvim_del_augroup_by_id, group)
              end,
            })
          end,
        }
      end

      -- require'lspconfig'.v_analyzer.setup{}
    end,
  },
}
