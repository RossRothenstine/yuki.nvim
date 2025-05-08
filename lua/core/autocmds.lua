
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General Settings
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Highlight text on yank",
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits on window resize",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location when opening a buffer",
})

-- Close certain windows with q
autocmd("FileType", {
  group = general,
  pattern = {
    "help",
    "qf",
    "lspinfo",
    "man",
    "notify",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain windows with q",
})

-- Auto-create directory when saving a file
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Create directory when saving a file, if it doesn't exist",
})

-- File type specific settings
local filetype_settings = augroup("FileTypeSettings", { clear = true })

-- Set indentation for specific file types
autocmd("FileType", {
  group = filetype_settings,
  pattern = { "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "Set indentation to 2 spaces for Lua files",
})

autocmd("FileType", {
  group = filetype_settings,
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
  desc = "Set indentation to 4 spaces for Python files",
})

-- Enable wrap and spell check for text files
autocmd("FileType", {
  group = filetype_settings,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell check for text files",
})

-- Auto-format on save (commented out by default)
-- Uncomment this if you want to auto-format files on save
local format_on_save = augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = format_on_save,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format on save",
})
