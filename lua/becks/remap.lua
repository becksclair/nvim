-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Leader key
vim.g.mapleader = " "
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true, desc = 'Exit insert mode' })
vim.keymap.set("n", "<leader>w", vim.cmd.w, { noremap = true, desc = 'Save buffer' })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Delete line' })
vim.keymap.set({ "n" }, "vv", "^vg_", { desc = 'Select line' })


-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Movement
vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Begining of line" })
vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "End of line" })
vim.keymap.set("v", "H", "^", { noremap = true, silent = true, desc = "Begining of file" })
vim.keymap.set("v", "L", "g_", { noremap = true, silent = true, desc = "End of file" })


-- Fix quit
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { noremap = true, desc = 'Kill window' })
vim.keymap.set("n", "<leader>Q", vim.cmd.quitall, { noremap = true, desc = 'Kill window' })

-- Save with SUDO
-- vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null %<CR>:e!<CR><CR>', { noremap = true, silent = true, desc = 'Sudo to write' })

-- w!! to save with sudo
vim.keymap.set("c", "w!!", "<esc>:lua require'becks.misc'.SudoWrite()<CR>", { silent = true, desc = 'Sudo to write' })

vim.keymap.set("n", "<leader>xb", "<cmd>bd<CR>", { desc = 'Discard buffer' })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = 'Open tmux sessionizer' })


-- -- Remap <C-p> to fzf
-- vim.keymap.set("i", "<C-p>", "<cmd>FZF<CR>")
-- vim.keymap.set({ "n", "v" }, "<C-p>", "<cmd>FZF<CR>")
--
-- -- Remap <C-n> to fzf files
-- vim.keymap.set("i", "<C-n>", "<cmd>Files<CR>")
-- vim.keymap.set({ "n", "v" }, "<C-n>", "<cmd>Files<CR>")
--

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer"})
vim.keymap.set("n", "<leader>bb", ":!bunx @biomejs/biome format --write %<CR>", { desc = "Format with biome"})
vim.keymap.set("n", "<leader>bF", ":%!prettier --stdin-filepath %<CR>", { desc = "Format with prettier" })
vim.keymap.set("n", "<C-S-f>", ":%!sqlfluff fix --force %<CR>", { desc = "Format with sqlfluff" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<C-x>", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/becks/plugins.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>,", function()
  vim.cmd("so")
end)

-- Easy buffer navigation
vim.keymap.set('', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Move cursor to window left' })
vim.keymap.set('', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Move cursor to window below' })
vim.keymap.set('', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Move cursor to window above' })
vim.keymap.set('', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Move cursor to window right' })

vim.keymap.set('', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })
vim.keymap.set('', '<leader>q', '<C-w>q', { noremap = true, silent = true, desc = 'Close window' })

-- Resize with arrows
vim.keymap.set('n', '<S-Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<F10>', '<cmd>DBUI<CR>', { noremap = true, silent = true, desc = 'Open Db UI' })

vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })


-- function IncreaseGuiFont()
--   local delta = 1
--   vim.g.gui_font_size = vim.o.gui_font_size + delta
--   vim.o.guifont = vim.o.gui_font_name .. ':' .. vim.o.gui_font_size
-- end
--
-- function DecreaseGuiFont()
--   local delta = 1
--   vim.g.gui_font_size = vim.o.gui_font_size - delta
--   vim.o.guifont = vim.o.gui_font_name .. ':' .. vim.o.gui_font_size
-- end
--
-- vim.keymap.set('n', '<M-=>', IncreaseGuiFont, { noremap = true, silent = true, desc = 'Increase Neovide font' })
-- vim.keymap.set('n', '<M-=-', DecreaseGuiFont, { noremap = true, silent = true, desc = 'Decrease Neovide font' })
--
