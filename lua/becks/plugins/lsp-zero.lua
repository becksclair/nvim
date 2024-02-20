local lsp_config = function()
    local lsp = require("lsp-zero")

    -- require('lspconfig/quick_lint_js').setup {}
    lsp.preset("recommended")

    -- Uncomment to enable debug logging
    -- vim.lsp.set_log_level('debug')

    lsp.ensure_installed({ 'rust_analyzer', 'lua_ls', 'pyright' })

    -- Fix Undefined global 'vim'
    lsp.configure('lua_ls', {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    })

    lsp.set_preferences({
        suggest_lsp_servers = false
    })

    lsp.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
    })

    lsp.on_attach(function(client, bufnr)
        local opts = {
            buffer = bufnr,
            remap = false
        }

        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        -- It doesn't require a parameter, it's optinal
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
    end)

    lsp.setup()

    -- NOTE: Configure Completions

    local cmp = require('cmp')

    local cmp_select = {
        behavior = cmp.SelectBehavior.Select
    }

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end

    local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({
            select = true
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = nil,
    })
    -- cmp_mappings['<Tab>'] = nil
    -- cmp_mappings['<S-Tab>'] = nil

    cmp.setup({
        mapping = cmp_mappings,
        sources = {
            {
                name = "nvim_lsp",
                group_index = 2
            },
            { -- Copilot Source
                name = "copilot",
                group_index = 2
            }, -- Other Sources
            {
                name = "nvim_lua",
                group_index = 2
            }, {
                name = 'orgmode'
            }, {
                name = "vim-dadbod-completion"
            }, {
                name = "buffer",
                keyword_length = 5,
                group_index = 2
            }, {
                name = "path",
                group_index = 2
            }, {
                name = "luasnip",
                group_index = 2
            }
        },
        formatting = {
            format = require('lspkind').cmp_format({
                mode = "symbol_text",
                max_width = 50,
                ellipsis_char = '…',
                symbol_map = {
                    Copilot = ""
                },
                before = function(_, vim_item)
                    return vim_item
                end
            })
        },
        window = {
            completion = cmp.config.window.bordered('rounded'),
            documentation = cmp.config.window.bordered('rounded')
        }
    })
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc
        })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>S', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {
        desc = 'Format current buffer with LSP'
    })
end

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
        event = 'BufEnter',
        branch = 'v2.x',
        dependencies = { -- LSP Support
            {
                'neovim/nvim-lspconfig',
                config = function()
                    require('lspconfig').v_analyzer.setup {}
                end
            },                             -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            {
                'williamboman/mason-lspconfig.nvim',
                opts = {
                    ensure_installed = { "tsserver", "rust_analyzer", -- "sqlls",
                        "ocamllsp", "rescriptls", "reason_ls", "lua_ls" }
                }
            }, -- Optional
            -- Autocompletion
            { 'onsails/lspkind.nvim' },
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            {
                'saadparwaiz1/cmp_luasnip',
                lazy = true
            },
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lua' }, -- Snippets
            {
                'L3MON4D3/LuaSnip',
                lazy = true
            }, -- Required
            {
                'rafamadriz/friendly-snippets',
                lazy = true
            }
        },
        config = lsp_config
    },
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = { -- Automatically install LSPs to stdpath for neovim
            {
                'williamboman/mason.nvim',
                config = true,
                cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
                build = function()
                    pcall(function()
                        require("mason-registry").refresh()
                    end)
                end,
                event = "User FileOpened",
                opts = {
                    ui = {
                        border = "rounded"
                    }
                }
            }, {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { { 'hrsh7th/nvim-cmp' } -- Required
            },
            config = function()
                require('neodev').setup()

                local servers = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            allFeatures = true,
                            overrideCommand = { 'cargo', 'clippy', '--workspace', '--message-format=json',
                                '--all-targets',
                                '--all-features' }
                        }
                    },

                    -- quick_lint_js = {
                    --   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
                    -- },

                    biome = {
                        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
                    },

                    pyright = {},

                    gopls = {},

                    svelte = {
                        filetypes = { 'svelte' }
                    },

                    v_analyzer = {
                        filetypes = { 'v', 'vv', 'vsh', 'vlang' },
                        root_pattern = { 'v.mod', '.git' }
                    },

                    slint_lsp = {
                        filetypes = { 'slint' },
                    },

                    lua_ls = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false
                            },
                            telemetry = {
                                enable = false
                            }
                        }
                    },

                    jsonls = {
                        json = {
                            schemas = require('schemastore').json.schemas(),
                            validate = {
                                enable = true
                            }
                        }
                    },

                    qmlls = {
                        filetypes = { 'qml', 'qmljs' }
                    },

                    clangd = {
                        args = {
                            "--clang-tidy"
                        }
                    },

                    tsserver = {
                    },

                    zls = {},
                }

                -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

                local mason_lspconfig = require 'mason-lspconfig'
                mason_lspconfig.setup_handlers { function(server_name)
                    -- print('Setting up ' .. server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes
                    }
                end }

                require('lspconfig').v_analyzer.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers['v_analyzer'],
                    filetypes = (servers['v_analyzer'] or {}).filetypes
                }

                -- require('lspconfig').quick_lint_js.setup {
                --     capabilities = capabilities,
                --     on_attach = on_attach,
                --     settings = servers['quick_lint_js'],
                --     filetypes = (servers['quick_lint_js'] or {}).filetypes
                -- }

                require('lspconfig').qmlls.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers['qmlls'],
                    filetypes = (servers['qmlls'] or {}).filetypes
                }
                require('lspconfig').tsserver.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers['tsserver'],
                    filetypes = (servers['tsserver'] or {}).filetypes
                }

                require('lspconfig').zls.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers['zls'],
                    filetypes = (servers['zls'] or {}).filetypes
                }
            end
        }, -- Useful status updates for LSP
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {
                    text = {
                        spinner = 'dots_snake'
                    },
                    window = {
                        blend = 40
                    }
                }
            }, -- Additional lua configuration, makes nvim stuff amazing!
            { 'folke/neodev.nvim' },
            'nlsp-settings.nvim',
            {
                "b0o/schemastore.nvim",
                lazy = true
            }
        }
    },
    {
        "tamago324/nlsp-settings.nvim",
        cmd = "LspSettings",
        lazy = true
    }
}
