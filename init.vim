set number relativenumber
set cursorline
" hi CursorLine term=bold cterm=bold guibg=Grey40<Paste>
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set statusline +=\ %{FugitiveStatusline()}

let mapleader="\\"

" transparent background
" au ColorScheme * hi Normal ctermbg=none guibg=none
" au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ayu-theme/ayu-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sebdah/vim-delve'
Plug 'cocopon/iceberg.vim'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox' 
Plug 'junegunn/seoul256.vim'
Plug 'mtdl9/vim-log-highlighting'
Plug 'nightsense/carbonized'
Plug 'tpope/vim-fugitive'
Plug 'croaker/mustang-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

set termguicolors
let ayucolor="mirage"
colorscheme ayu

let g:highlightedyank_highlight_duration = 250

" Auto update buffers when file change on disk, git checkout etc
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" NERDTree toggle with current file highlighted
nnoremap <silent> <expr> <C-e> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
" Stop nerdtree from opening automatically
let g:NERDTreeHijackNetrw=0

" Close nerd tree if it is the onl open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

let g:netrw_banner = 0
let g:netrw_liststyle = 3

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:delve_breakpoint_sign_highlight = ""


:set ignorecase
:set smartcase


cnoreabbrev Ack Ack! --smart-case
cnoreabbrev ack Ack! --smart-case
nnoremap <Leader>a :Ack!<Space>

:nnoremap <A-Left> <C-O>
:nnoremap <A-Right> <C-I>


let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" Navigate splits without w prefix
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Exit insert mode in term by esc
tnoremap <Esc> <C-\><C-n>

set splitbelow
set splitright
map <A-t>t :bot sp <bar> :resize 13<bar> :term <CR>
map <A-t>l :resize 40 <CR> 
map <A-t>s :resize 13 <CR> 

map <A-o> :CtrlPBufTag <CR>
map <Leader>\ :CtrlPBufTag <CR>
map <Leader>p :CtrlP <CR>


map <F9> :DlvToggleBreakpoint <CR>
map <F1> :CocList diagnostics <CR>
map <F2> :CocRestart <CR>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0



" set foldcolumn=0
" set signcolumn=no
highlight clear SignColumn
