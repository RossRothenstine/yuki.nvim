-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 1
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true

-- Split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Behavior
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Mouse
vim.opt.mouse = 'a'

-- System clipboard
vim.opt.clipboard = 'unnamedplus'
