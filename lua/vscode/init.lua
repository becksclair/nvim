require("vscode.set")
require("vscode.remap")
require("vscode.plugins")
-- require("becks.neovide")

local augroup = vim.api.nvim_create_augroup
local BecksGroup = augroup('Becks', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

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

-- Configure blinking cursors
vim.cmd [[
    set guicursor=i-ci-a-sm:block-Cursor/Cursor-blinkwait175-blinkoff150-blinkon150
    set guicursor+=i-ci-a-sm:block-Cursor/Cursor-blinkwait175-blinkoff150-blinkon150
    set guicursor+=r-cr:hor95-Cursor/Cursor
    set guicursor+=n-v-c:block-Cursor/Cursor-blinkon0
]]

