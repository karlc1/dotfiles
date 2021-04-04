

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
" Plug 'Raimondi/delimitMate'
Plug 'glepnir/dashboard-nvim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'vim-test/vim-test'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'scrooloose/nerdtree'

Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'

Plug 'onsails/lspkind-nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'akinsho/nvim-bufferline.lua'

Plug 'danilamihailov/beacon.nvim'

Plug 'embark-theme/vim'

call plug#end()


" --- COLORS ---
set termguicolors
" let ayucolor="mirage"
let ayucolor="dark"
colorscheme embark
" colorscheme OceanicNext
set t_Co=256


" --- LSP SETTINGS ---

" LSP servers
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.ccls.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.graphql.setup{}
" lua require'lspconfig'.yamlls.setup{}

" LSP keybindings
nnoremap gd  <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>tab split \| lua vim.lsp.buf.definition()<cr>
nnoremap gV <cmd>vsp \| lua vim.lsp.buf.definition()<cr> 
nnoremap gS <cmd>sp \| lua vim.lsp.buf.definition()<cr>
nnoremap gi :Implementations<CR>
nnoremap gr :References<cr>

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

nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>dl :Diagnostics<CR>



" --- AUTOCOMPLETE SETTINGS ---

" trigger compe on ctrl space
inoremap <silent><expr> <C-Space> compe#complete()

" needed for compe plugin to work
set completeopt=menu,menuone,noselect

" confirm autocomplete selection on CR

" without demlimitMate
inoremap <silent><expr> <CR>  compe#confirm('<CR>')
" with delimitMate
" inoremap <silent><expr> <CR>  compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })


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


" --- EASYMOTION SETTINGS ---
nmap ss <Plug>(easymotion-overwin-f)
nmap sd <Plug>(easyoperator-line-delete)
nmap sy <Plug>(easyoperator-line-yank)
nmap sv <Plug>(easyoperator-line-select)


" --- VIMTEST SETTINGS ---
nmap <silent> <Leader> tn :TestNearest<CR>
nmap <silent> <Leader> tf :TestFile<CR>
nmap <silent> <Leader> ts :TestSuite<CR>
nmap <silent> <Leader> tl :TestLast<CR>
nmap <silent> <Leader> tv :TestVisit<CR>

" use gotest instead of go test, adds color
let test#go#runner = 'gotest'

" --- KOMMENTARY SETTINGS ---

" disable default key bindings
" vim.g.kommentary_create_default_mappings = false

" use single line comments, no indent and ignore whitespace
lua << EOF
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true,

    vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_line_default", {}),
    vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>kommentary_visual_default", {})
})
EOF




" --- MISC SETTINGS ---

" show substitute preview 
set inccommand=nosplit

" highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

set noswapfile
set ignorecase
set smartcase
set ai


" --- NETRW SETTINGS ---
"
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let netrw_altv=1

" expand current files parent directory on enter netrw 
autocmd VimEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string(expand('%:t')) . ')'
function! SearchNetrw(fname)
    if ! search('\V\^' . a:fname . '\$')
        call search('^' . substitute(a:fname, '\w\zs.*', '', '') . '.*\/\@<!$')
    endif
endfunction




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


" scroll on J and K
nnoremap J <C-e>
nnoremap K <C-y>

" set keyboard map to US on enter nvim
autocmd VimEnter * :silent exec "! setxkbmap us &"

" yank to system clipboard on leader
vnoremap <Leader>y "+y
nnoremap <Leader>y "+y

set splitbelow
set splitright
let g:netrw_banner = 0

nnoremap <silent> <ESC> :noh <ESC>
" disable automatic jump after seraching for word under cursor
nnoremap * :let @/ = '<c-r><c-w>' \| set hlsearch<cr>
" Navigate splits without w prefix
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set number



" Only line number for current line is highlited
set cursorline
highlight clear CursorLine
highlight clear CursorLineNr


" --- NEDTREE SETTINGS ---

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

if exists('g:started_by_firenvim')
  set laststatus=0
else
  set laststatus=2
  nnoremap <C-e> :NERDTreeFind <CR>
endif

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yml setlocal shiftwidth=2 softtabstop=2 expandtab

autocmd FileType graphql setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType graphqls setlocal shiftwidth=4 softtabstop=4 expandtab

" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

" organizie imports on save
lua << EOF
function lsp_organize_imports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "table", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local timeout = 1000 -- ms

  local resp = vim.lsp.buf_request_sync(0, method, params, timeout)
  if not resp then return end

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if resp[client.id] then
      local result = resp[client.id].result
      if not result or not result[1] then return end

      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end
end

vim.api.nvim_command("au BufWritePre *.go lua lsp_organize_imports()")
EOF

nnoremap <leader>t :TestNearest<CR>
let test#strategy = "neovim"
tnoremap <Esc> <C-\><C-n>


lua << EOF
require('lspkind').init({
    -- with_text = true,
    -- symbol_map = {
    --   Text = '',
    --   Method = 'ƒ',
    --   Function = '',
    --   Constructor = '',
    --   Variable = '',
    --   Class = '',
    --   Interface = 'ﰮ',
    --   Module = '',
    --   Property = '',
    --   Unit = '',
    --   Value = '',
    --   Enum = '了',
    --   Keyword = '',
    --   Snippet = '﬌',
    --   Color = '',
    --   File = '',
    --   Folder = '',
    --   EnumMember = '',
    --   Constant = '',
    --   Struct = ''
    -- },
})
EOF


nnoremap <leader>e :NvimTreeFindFile<CR>
let g:nvim_tree_follow = 1
" let g:nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
let g:nvim_tree_auto_close = 1


lua << EOF
require'bufferline'.setup{
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "thick",
    always_show_bufferline = false,
    persist_buffer_sort = false
  }
}
EOF
