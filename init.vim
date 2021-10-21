set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=80

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

call plug#begin(stdpath('data') . '/plugged')
Plug 'kyazdani/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'
call plug#end()

colorscheme gruvbox

let mapleader = " "
" nnoremap <leader>ff <cmd>Telescope find_files<cr
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup WB
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Install treesitter languages
" :TSInstall <language_to_install>

" LSP setup
"

set completeopt=menuone,noinsert,noselect

nnoremap <leader>vd :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<cr>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<cr>
nnoremap <leader>va :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>va :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>va :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>va :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>va :lua vim.lsp.buf.definition()<cr>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
