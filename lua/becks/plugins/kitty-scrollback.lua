return {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    cond = vim.env.TERMINAL == "kitty",
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    opts = {
        -- global configuration
        {
            status_window = {
                autoclose = true,
            },
        },
        -- builtin configuration override
        ksb_builtin_get_text_all = {
            kitty_get_text = {
                ansi = false,
            },
        },

        -- KsbHighlights? highlight overrides
        highlight_overrides = {
            -- table? status window Normal highlight group
            KittyScrollbackNvimStatusWinNormal = {},
            -- table? status window heart icon highlight group
            KittyScrollbackNvimStatusWinHeartIcon = {},
            -- table? status window spinner icon highlight group
            KittyScrollbackNvimStatusWinSpinnerIcon = {},
            -- table? status window ready icon highlight group
            KittyScrollbackNvimStatusWinReadyIcon = {},
            -- table? status window kitty icon highlight group
            KittyScrollbackNvimStatusWinKittyIcon = {},
            -- table? status window vim icon highlight group
            KittyScrollbackNvimStatusWinNvimIcon = {},
            -- table? paste window Normal highlight group
            KittyScrollbackNvimPasteWinNormal = {},
            -- table? paste window FloatBorder highlight group
            KittyScrollbackNvimPasteWinFloatBorder = {},
            -- table? paste window FloatTitle highlight group
            KittyScrollbackNvimPasteWinFloatTitle = {},
            -- table? scrollback buffer window Visual selection highlight group
            KittyScrollbackNvimVisual = {},
            -- table? scrollback buffer window Normal highlight group
            KittyScrollbackNvimNormal = {},
        },
        -- KsbStatusWindowOpts? options for status window indicating that kitty-scrollback.nvim is ready
        status_window = {
            -- boolean If true, show status window in upper right corner of the screen
            enabled = true,
            -- boolean If true, use plaintext instead of nerd font icons
            style_simple = false,
            -- boolean If true, close the status window after kitty-scrollback.nvim is ready
            autoclose = false,
            -- boolean If true, show a timer in the status window while kitty-scrollback.nvim is loading
            show_timer = false,
            -- KsbStatusWindowIcons? Icons displayed in the status window
            icons = {
                -- string kitty status window icon
                kitty = '󰄛',
                -- string heart string heart status window icon
                heart = '󰣐', -- variants 󰣐 |  |  | ♥ |  | 󱢠 | 
                -- string nvim status window icon
                nvim = '', -- variants  |  |  | 
            },
        },

        -- KsbPasteWindowOpts? options for paste window that sends commands to Kitty
        paste_window = {
            --- BoolOrFn? If true, use Normal highlight group. If false, use NormalFloat
            highlight_as_normal_win = nil,
            -- string? The filetype of the paste window. If nil, use the shell that is configured for kitty
            filetype = nil,
            -- boolean? If true, hide mappings in the footer when the paste window is initially opened
            hide_footer = false,
            -- integer? The winblend setting of the window, see :help winblend
            winblend = 0,
            -- KsbWinOptsOverride? Paste float window overrides, see nvim_open_win() for configuration
            winopts_overrides = nil,
            -- KsbFooterWinOptsOverride? Paste footer window overrides, see nvim_open_win() for configuration
            footer_winopts_overrides = nil,
            -- string? register used during yanks to paste window, see :h registers
            yank_register = '',
            -- boolean? If true, the yank_register copies content to the paste window. If false, disable yank to paste window
            yank_register_enabled = true,
        },

        -- user defined configuration table
        myconfig = {
            kitty_get_text = {
                ansi = false,
            },
        },
        -- user defined configuration function
        -- myfnconfig = function(kitty_data)
        --     return {
        --         kitty_get_text = {
        --             extent = (kitty_data.scrolled_by > kitty_data.lines) and 'all' or 'screen',
        --         },
        --     }
        -- end,
    },
    config = function(_, opts)
        require('kitty-scrollback').setup(opts)

        if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then
            vim.keymap.set({ 'n' }, '<C-e>', '5<C-e>', {})
            vim.keymap.set({ 'n' }, '<C-y>', '5<C-y>', {})
        end
    end,
}
