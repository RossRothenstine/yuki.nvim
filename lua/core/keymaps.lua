
-- Helper function for mapping keys
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to the left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to the bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to the top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to the right window" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Stay in indent mode when changing indentation
map("v", "<", "<gv", { desc = "Decrease indent and stay in visual mode" })
map("v", ">", ">gv", { desc = "Increase indent and stay in visual mode" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down in visual mode" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up in visual mode" })

-- Better navigation in insert mode
map("i", "<C-h>", "<Left>", { desc = "Move cursor left in insert mode" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right in insert mode" })

-- Clear highlights
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current buffer" })

-- Save file
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Exit insert mode and save file" })

-- Quit
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force quit" })

-- Better paste - doesn't overwrite register when pasting over text in visual mode
map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Center cursor when moving half-page up/down
map("n", "<C-d>", "<C-d>zz", { desc = "Move half-page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move half-page up and center" })

-- Center cursor when searching
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Toggle line wrapping
map("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Split window
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width & height" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })
