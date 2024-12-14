-- Get platform dependant build script
local function isWindows()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return true
  else
    return false
  end
end

vim.cmd("autocmd!")

-- vim.opt.rocks.hererocks = true

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.o.title = true

vim.opt_local.spell = false
vim.opt_local.spelllang = "en_us"

-- vim.opt.guicursor = ""

vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.splitkeep = 'cursor'

vim.opt.tabstop = 3
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
-- vim.opt.expandtab = true
-- vim.opt.noexpandtab = true
vim.opt.smartindent = true

vim.opt.hidden = true
vim.opt.ruler = true

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep sign column on by default
vim.wo.signcolumn = 'yes'

vim.o.backspace = 'indent,eol,start'
vim.o.listchars = 'tab:→ ,trail:·,extends:❯,precedes:❮,nbsp:␣,eol:¬'
vim.o.fillchars = 'eob: ,vert:│,fold:·,diff:⣿,msgsep:‾'
vim.o.showbreak = '↪ '
vim.o.breakindentopt = 'shift:0,min:20'
vim.o.linebreak = true
vim.opt.wrap = true
-- vim.opt.colorcolumn = "80"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set complete opt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false

if isWindows() then
  vim.opt.undodir = os.getenv("USERPROFILE") .. "/.vim/undodir"
else
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

-- vim.opt.updatetime = 50

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldlevel = 99

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'
-- vim.o.guifont = 'Maple Mono NF:h11:#e-subpixelantialias'


vim.filetype.add {
    filename = {
      ['build.zig.zon'] = 'zig'
    },
    extension = {
        v = 'vlang',
        slint = 'slint',
        templ = 'templ',
        re = 'reason',
        pcss = 'css',
    },
    pattern = {
        ["yabairc"] = "bash",
        ["[jt]sconfig.*.json"] = "jsonc",
        ['v.mod'] = 'vlang',
        ['.env.*'] = 'env',
        -- ['*.zig.zon'] = 'zig'
    }
}

vim.diagnostic.config({
    virtual_text = true
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  -- pattern = "v.mod",
  callback = function()
    -- Get the full path of the current file
    local filepath = vim.fn.expand('%:p')
    -- Get the full path of the current working directory
    local cwd = vim.fn.getcwd() .. "/"
    -- Check if the file is in the current working directory
    if filepath == cwd .. "v.mod" then
      vim.bo.filetype = "vlang"
    end
    -- if filepath == cwd .. "zig.zon" then
    --   vim.bo.filetype = "zig"
    -- end
  end,
})
