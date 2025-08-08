return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      "saghen/blink.compat",
      -- optional = true,
      opts = {
        -- impersonate_nvim_cmp = false
      },
    },

    {'MeanderingProgrammer/render-markdown.nvim'},

    { 'rafamadriz/friendly-snippets' },
    { 'L3MON4D3/LuaSnip',            version = 'v2.*' },

    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
  },

  -- use a release tag to download pre-built binaries
  version = 'v1.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = 'default',

      ['<C-f>'] = { 'select_and_accept' },

      ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
      ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
      ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
      ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
      ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
      ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
      ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
      ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
      ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
    },

    cmdline = {
      keymap = {
        ['<tab>'] = { 'select_next', 'fallback' },
        ['<S-tab>'] = { 'select_prev', 'fallback' },
        ['<C-f>'] = { 'select_and_accept' },
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
    },

    --- @module 'blink.cmp'
    completion = {
      accept = {
        -- experimental auto-brackets support
        -- auto_brackets = { enabled = true }
      },

      menu = {
        draw = {
          columns = {
            {
              "kind_icon",
              "kind"
            },
            { "label", "label_description", gap = 1 },
          },
          components = {
            item_idx = {
              text = function(ctx) return tostring(ctx.idx) end,
              -- highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
            }
          },

          treesitter = { "lsp" },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },


    -- experimental signature help support
    signature = { enabled = true },

    snippets = {
      expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      -- dont show LuaLS require statements when lazydev has items
      default = {
        'lsp',
        'path',
        -- 'snippets',
        -- 'luasnip',
        'buffer',
        'markdown',
        'lazydev'
      },

      providers = {
        -- dont show LuaLS require statements when lazydev has items
        -- lsp = { fallback_for = { "lazydev" } },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
          fallbacks = {
            'lsp'
          }
        },
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink'
        },
      },
    },
  },

  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },

  config = function(_, opts)
    -- check if we need to override symbol kinds
    for _, provider in pairs(opts.sources.providers or {}) do
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        ---@diagnostic disable-next-line: no-unknown
        CompletionItemKind[provider.kind] = kind_idx

        local transform_items = provider.transform_items
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
          end
          return items
        end

        -- Unset custom prop to pass blink.cmp validation
        provider.kind = nil
      end
    end

    require("blink.cmp").setup(opts)
  end
}

