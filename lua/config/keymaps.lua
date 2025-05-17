-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Cmd mode shorcut
map("n", ";", ":")

-- Keymaps Jukit
map("n", "<leader>jo", ":call jukit#cells#create_below(0)<CR>", opts) -- Create code cell below
map("n", "<leader>jO", ":call jukit#cells#create_above(0)<CR>", opts) -- Create code cell above
map("n", "<leader>jt", ":call jukit#cells#create_below(1)<CR>", opts) -- Create markdown cell below
map("n", "<leader>jT", ":call jukit#cells#create_above(1)<CR>", opts) -- Create markdown cell above
map("n", "<leader>jdd", ":call jukit#cells#delete()<CR>", opts) -- Delete current cell
map("n", "<leader>jhj", ":call jukit#splits#out_hist_scroll(1)<CR>", opts) -- out_hist_scroll_down
map("n", "<leader>jhk", ":call jukit#splits#out_hist_scroll(0)<CR>", opts) -- out_hist_scroll_up

-- (Optional) remap other ones too:
map("n", "<leader>js", ":call jukit#cells#split()<CR>", opts)
map("n", "<leader>jM", ":call jukit#cells#merge_above()<CR>", opts)
map("n", "<leader>jm", ":call jukit#cells#merge_below()<CR>", opts)
map("n", "<leader>jk", ":call jukit#cells#move_up()<CR>", opts)
map("n", "<leader>jj", ":call jukit#cells#move_down()<CR>", opts)
map("n", "<A-[>", ":call jukit#cells#jump_to_next_cell()<CR>", opts)
map("n", "<A-]>", ":call jukit#cells#jump_to_previous_cell()<CR>", opts)
map("n", "<leader>jdo", ":call jukit#cells#delete_outputs(0)<CR>", opts)
map("n", "<leader>jda", ":call jukit#cells#delete_outputs(1)<CR>", opts)

-- Keymaps for Jupynium
map("n", "<leader>ja", ":JupyniumStartAndAttachToServer<CR>", opts)
map("n", "<leader>jS", ":JupyniumStartSync ", { noremap = true, silent = false })
map("n", "<leader>jq", ":JupyniumStopSync<CR>", opts)
map("n", "<leader>jr", ":JupyniumExecuteSelectedCells<CR>", opts)
map("n", "<leader>jk", ":JupyniumKernelSelect<CR>", opts)

-- Keymaps for molten jupyter like env
map("n", "<Leader>mr", ":MoltenEvaluateCell<CR>", opts)
map("n", "<leader>mR", ":MoltenReevaluateCell<CR>", opts)
map("n", "<Leader>mn", ":MoltenEvaluateNextCell<CR>", opts)
map("n", "<Leader>mi", ":MoltenInit<CR>", opts)
map("n", "<leader>me", ":MoltenEvaluateOperator<CR>", opts)
map("n", "<leader>ml", ":MoltenEvaluateLine<CR>", opts)
map("x", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", opts)
map("n", "<leader>md", ":MoltenDelete<CR>", opts)
map("n", "<leader>mo", ":MoltenShowOutput<CR>", opts)
map("n", "<leader>mh", ":MoltenHideOutput<CR>", opts)

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
