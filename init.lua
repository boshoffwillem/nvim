require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
-- require "user.autopairs"
require "user.comment"
require "user.gitsigns"
-- vim.cmd "colorscheme gruvbox"
-- vim.cmd "colorscheme onedark"
-- vim.cmd "colorscheme darcula"
require "user.nvim-tree"
require "user.toggleterm"
require "user.project"
require "user.whichkey"
require "user.luasnip"

-- For dark theme
vim.g.vscode_style = "dark"
-- For light theme
-- vim.g.vscode_style = "light"
-- Enable transparent background
vim.g.vscode_transparent = 1
-- Enable italic comment
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
vim.g.vscode_disable_nvimtree_bg = true
vim.cmd([[colorscheme vscode]])
