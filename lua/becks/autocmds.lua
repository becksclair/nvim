-- vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = vim.lsp.buf.format })

local custom_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = custom_format })


-- Create an autocommand group to ensure we can cleanly define our autocommands
local env_filetype_group = vim.api.nvim_create_augroup("EnvFiletype", { clear = true })

-- Define the autocommand to set the filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = ".env*",
    callback = function()
        vim.bo.filetype = "sh"
    end,
    group = env_filetype_group,
})


local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- GROUPS:
local disable_node_modules_eslint_group = ag("DisableNodeModulesEslint", { clear = true })

-- AUTO-COMMANDS:
au({ "BufNewFile", "BufRead" }, {
    pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
    callback = function()
        vim.diagnostic.enable(false)
    end,
    group = disable_node_modules_eslint_group,
})

-- local M = {}
-- function M.lsp_filter(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--     -- if vim.b.lsp_enabled == false then
--     --     return
--     -- end
--
--     if client ~= nil and client.name ~= "eslint" then
--         return
--     end
--
--     local buf_clients = vim.lsp.get_clients()
--     if #buf_clients == 0 then
--         return ""
--     end
--
--     local eslint_active = false
--     local biome_active = false
--     for _, cli in pairs(buf_clients) do
--         if cli.name == "eslint" then
--             eslint_active = true
--         end
--         if cli.name == "biome" then
--             biome_active = true
--         end
--     end
--
--     if client ~= nil and eslint_active and biome_active then
--         vim.lsp.stop_client(client.id)
--     end
-- end
-- vim.api.nvim_create_user_command('FilterLsp', M.lsp_filter, { nargs = 0 })
--
--
-- local disable_dup_lsp_group = ag("DisableDupLsp", { clear = true })
-- au({ "LspAttach" }, {
--     pattern = { "*.ts", "*.js", "*.jsx", "*.tsx" },
--     callback = M.lsp_filter,
--     group = disable_dup_lsp_group
-- })


-- vim.api.nvim_create_augroup("KittyCursor", { clear = true })
-- vim.api.nvim_create_autocmd("VimEnter", {
--     group = "KittyCursor",
--     callback = function()
--         vim.fn["kitty#cursor#update"]()
--     end,
-- })
