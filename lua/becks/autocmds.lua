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
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = ".env*",
  callback = function()
    vim.bo.filetype = "sh"
  end,
  group = env_filetype_group,
})

