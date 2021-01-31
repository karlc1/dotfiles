

call plug#begin()

Plug 'anott03/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'mhartington/oceanic-next'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'cocopon/iceberg.vim'
Plug 'Raimondi/delimitMate'
Plug 'glepnir/dashboard-nvim'

call plug#end()


" --- COLORS ---
set termguicolors
colorscheme OceanicNext
set t_Co=256


" --- LSP SETTINGS ---

" LSP servers
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.ccls.setup{}

" LSP keybindings
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>

" Misc LSP settings

" remove highlighted trailing whitespace in go
let g:go_highlight_trailing_whitespace_error=0
" auto foramt on save
autocmd BufWritePre * silent! lua vim.lsp.buf.formatting_sync()


" auto import on save in Go
let g:go_fmt_command = "goimports"

" LSPSaga settings
lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
nnoremap <silent> gR <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> gh <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gH <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent> gD :LspSagaFinder<CR>

nnoremap <silent> <leader>dd :LspSagaShowLineDiags<CR>
nnoremap <silent> <leader>dp :LspSagaDiagJumpPrev<CR>
nnoremap <silent> <leader>dn :LspSagaDiagJumpNext<CR>
nnoremap <silent> <leader>df :LspSagaCodeAction<CR>



" --- AUTOCOMPLETE SETTINGS ---

" needed for compe plugin to work
set completeopt=menu,menuone,noselect

" confirm autocomplete selection on CR
inoremap <silent><expr> <CR>  compe#confirm('<CR>')

" close autocomplete menu on ESC if it's open
inoremap <silent><expr> <ESC> pumvisible() ? compe#close('<C-e>') : "<ESC>"

" Open autocomplete on TAB, navigate results on TAB and s-TAB
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ compe#complete()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" compe settings
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = false;
  debug = false;
  min_length = 2;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
  };
}
EOF

" --- TELESCOPE SETTINGS --- 

nnoremap <silent><Leader>p :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>
" nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files({width=80})<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>

highlight TelescopeSelection      guifg=#D79921 gui=bold " selected item
highlight TelescopeSelectionCaret guifg=#CC241D " selection caret
highlight TelescopeMultiSelection guifg=#928374 " multisections

highlight TelescopeNormal         guibg=#00000  " floating windows created by telescope.
highlight TelescopePreviewNormal  guibg=#242933  " floating windows created by telescope.

" Border highlight groups.
highlight TelescopeBorder         guifg=#00ff00
highlight TelescopePromptBorder   guifg=#D79921 gui=bold
highlight TelescopeResultsBorder  guifg=#ffffff gui=bold
highlight TelescopePreviewBorder  guifg=#ffffff

" Used for highlighting characters that you match.
highlight TelescopeMatching       guifg=orange

" Used for the prompt prefix
highlight TelescopePromptPrefix   guifg=red


" --- TREESITTER SETTINGS ---
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      node_decremental = "gnm",
    },
  },

}
EOF


" --- MISC SETTINGS ---

" show substitute preview 
set inccommand=nosplit

" highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

set noswapfile
set ignorecase
set smartcase

let g:netrw_liststyle = 3


let mapleader="\\"
nnoremap <SPACE> <Nop>
map <Space> <Leader>

" Make splits resize to equal width when window size changes
autocmd VimResized * wincmd =

let $BAT_THEME='Nord'

let g:dashboard_default_executive = 'telescope'


let g:dashboard_custom_header = [
    \'',
    \'   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
    \'    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    \'          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
    \'           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    \'          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    \'   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    \'  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    \' ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    \' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
    \'      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    \'       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
    \'     ⢰⣶  ⣶ ⢶⣆⢀⣶⠂⣶⡶⠶⣦⡄⢰⣶⠶⢶⣦  ⣴⣶     ',
    \'     ⢸⣿⠶⠶⣿ ⠈⢻⣿⠁ ⣿⡇ ⢸⣿⢸⣿⢶⣾⠏ ⣸⣟⣹⣧    ',
    \'     ⠸⠿  ⠿  ⠸⠿  ⠿⠷⠶⠿⠃⠸⠿⠄⠙⠷⠤⠿⠉⠉⠿⠆   ',
    \'',
    \]
