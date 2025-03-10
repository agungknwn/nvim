-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Cmd mode shorcut
map("n", ";", ":")

-- Keymaps for Jupynium
map("n", "<leader>ja", ":JupyniumStartAndAttachToServer<CR>", opts)
map("n", "<leader>jS", ":JupyniumStartSync ", { noremap = true, silent = false })
map("n", "<leader>jq", ":JupyniumStopSync<CR>", opts)
map("n", "<leader>jr", ":JupyniumExecuteSelectedCells<CR>", opts)
map("n", "<leader>jk", ":JupyniumKernelSelect<CR>", opts)

-- Keymaps for molten jupyter like env
map("n", "<Leader>mr", ":MoltenEvaluateCell<CR>", opts)
map("n", "<Leader>mn", ":MoltenEvaluateNextCell<CR>", opts)
map("n", "<Leader>mi", ":MoltenInit<CR>", opts)
map("n", "<leader>r", ":MoltenEvaluateOperator<CR>", opts)
map("n", "<leader>rr", ":MoltenEvaluateLine<CR>", opts)
map("x", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>", opts)
map("n", "<leader>rc", ":MoltenReevaluateCell<CR>", opts)
map("n", "<leader>rd", ":MoltenDelete<CR>", opts)
map("n", "<leader>ro", ":MoltenShowOutput<CR>", opts)
map("n", "<leader>rh", ":MoltenHideOutput<CR>", opts)

-- collective rename
map("n", "<leader>cN", ":%s/<C-r><C-w>//g<left><left>", { desc = "valIncRename" })

-- Increment/Decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Delete a word backwards
map("n", "dw", "vb_d")

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Jumplist
map("n", "<C-m>", "<C-i>", opts)
map("n", ")", "$")

-- New Tab
map("n", "te", ":tabedit", opts)
map("n", "<tab>", ":tabnext<Return>", opts)
map("n", "<s-tab>", ":tabprev<Return>", opts)

-- Close Window
map("n", "<A-q>", ":q<CR>", opts)
-- Split Window
map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

-- Move Window
map("n", "<A-h>", "<C-w>h")
map("n", "<A-l>", "<C-w>l")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-e>", ":Neotree focus<CR>", opts)

-- Resize Window
map("n", "<C-h>", "<C-w>>")
map("n", "<C-l>", "<C-w><")
map("n", "<C-k>", "<C-w>+")
map("n", "<C-j>", "<C-w>-")

-- Diagnostic
map("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
