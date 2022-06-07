local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Yank rest of line
-- =========================================================================================================
keymap("n", "Y", "yg$", opts)
-- =========================================================================================================

-- Move text up and down
-- =========================================================================================================
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- =========================================================================================================

-- Resize with arrows
-- =========================================================================================================
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- =========================================================================================================

-- Navigate buffers
-- =========================================================================================================
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- =========================================================================================================

-- Insert Mode
-- =========================================================================================================
-- Move text up and down
keymap("i", "<A-j>", ":m .+1<CR>==gi", opts)
keymap("i", "<A-k>", ":m .-2<CR>==gi", opts)
-- =========================================================================================================

-- Visual Mode
-- =========================================================================================================
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "p", '"_dP', opts)
-- =========================================================================================================

-- Visual Block Mode
-- =========================================================================================================
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- =========================================================================================================

-- Terminal
-- =========================================================================================================
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<C-q>", "<C-\\><C-N><C-w>q", term_opts)
-- =========================================================================================================

-- Telescope
-- =========================================================================================================
keymap("n", "<leader>bb", "<cmd>lua require'telescope.builtin'.buffers()<cr>", opts)
keymap("n", "<leader>bk", ":bdelete<CR>", opts)
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files()<cr>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<cr>", opts)
keymap("n", "<leader>fw", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>gc", ":Telescope git_commits<cr>", opts)
keymap("n", "<leader>pp", ":Telescope projects<cr>", opts)
-- =========================================================================================================

-- LSP
-- =========================================================================================================
-- code actions
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
-- diagnostics
keymap("n", "<leader>ldb", "<cmd>Telescope lsp_document_diagnostics<cr>", opts)
keymap("n", "<leader>ldw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>ldw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>ldj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>ldk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
keymap("n", "<leader>ldh", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "<leader>ldq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
-- goto
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
-- refactoring
keymap("n", "<leader>lrf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
keymap("n", "<leader>lrr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
-- searching
keymap("n", "<leader>lsb", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lsw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
-- =========================================================================================================

-- File Explorer
-- =========================================================================================================
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- =========================================================================================================
