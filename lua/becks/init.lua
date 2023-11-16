require("becks.set")
require("becks.remap")
require("becks.plugins")
-- require("becks.neovide")

local augroup = vim.api.nvim_create_augroup
local BecksGroup = augroup('Becks', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40
        })
    end
})

autocmd({"BufWritePre"}, {
    group = BecksGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Configure blinking cursors
vim.cmd [[
    :highlight Cursor gui=reverse guifg=NONE guibg=NONE
    :highlight Cursor gui=NONE guifg=bg guibg=fg
    set guicursor=i-ci-a-sm:block-Cursor/Cursor-blinkwait175-blinkoff150-blinkon150
    set guicursor+=i-ci-a-sm:block-Cursor/Cursor-blinkwait175-blinkoff150-blinkon150
    set guicursor+=r-cr:hor95-Cursor/Cursor
    set guicursor+=n-v-c:block-Cursor/Cursor-blinkon0
]]

