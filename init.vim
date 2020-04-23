set number relativenumber
let mapleader="\\"
set noswapfile
set ignorecase
set smartcase

syntax enable

set nuw=1

set completeopt=noinsert

let g:netrw_liststyle = 3

" transparent background
au ColorScheme * hi Normal ctermbg=none guibg=none ctermfg=none ctermbg=none
" transparent number row
au ColorScheme * hi LineNr ctermbg=none guibg=none ctermfg=none ctermbg=none
" transparent current line number background
au ColorScheme * hi CursorLineNr ctermbg=none guibg=none ctermfg=none ctermbg=none
" transparent sign column
au ColorScheme * hi SignColumn ctermbg=none guibg=none ctermfg=none ctermbg=none



"au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
"
set ts=6 sw=6"



call plug#begin('~/.vim/plugged')

" ColorSchemes and visuals
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox' 
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'NLKNguyen/papercolor-theme'
Plug 'iCyMind/NeoSolarized'
Plug 'jparise/vim-graphql'

" Testing
Plug 'janko/vim-test'
"let test#strategy = "neovim"

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
"Plug 'kshenoy/vim-signature'
Plug 'unblevable/quick-scope'

" Language integration
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'liuchengxu/vista.vim'

Plug 'voldikss/vim-floaterm'

call plug#end()

set termguicolors
set t_Co=256
set background=light
let ayucolor="mirage"

let g:floaterm_position='center'


map t :FloatermToggle <CR>

nnoremap <leader>x *``cgn



" let colors = ['gruvbox', 'ayu', 'nord']
" let rand_color = colors[localtime() % len(colors)]
" execute 'colorscheme' fnameescape(rand_color)
"colorscheme NeoSolarized
colorscheme nord



if (colors_name ==# 'PaperColor' || colors_name ==# 'NeoSolarized')
	let g:clap_theme = 'material_design_dark'
endif


" Visuals
let NERDTreeMinimalUI = 1
let g:netrw_banner = 0
set splitbelow
set splitright
set statusline +=\ %{FugitiveStatusline()}
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#tab_min_count = 2

" Navigation
nnoremap <Leader>g :GoTestFunc <CR>
nnoremap J 5j
nnoremap K 5k
" Exit insert mode in term by esc
tnoremap <Esc> <C-\><C-n>
" Go to embedded terminal in new tab on leader-t
map <Leader>t :tabnew <bar> :term <CR> i git status <CR>
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_smartcase = 1
" Stop nerdtree from opening automatically
let g:NERDTreeHijackNetrw=0
" Close nerd tree if it is the onl open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Navigate splits without w prefix
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Ack 
"cnoreabbrev Ack Ack! --smart-case
cnoreabbrev ack Ack! --smart-case
"nnoremap <Leader>a :Ack! --smart-case<Space>
noremap <Leader>a :Ack! <cword><cr>

" let CoC handle completion
let g:go_code_completion_enabled = 0

" NERDTree toggle with current file highlighted
"nnoremap <silent> <expr> <C-e> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <expr> <C-e> "\:NERDTreeFind<CR>"

" Misc
" Auto update buffers when file change on disk, git checkout etc
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:go_fmt_command = "goimports"


" CoC Settings
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=600
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=auto

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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gD :vsplit <CR> gd <CR>
nmap <silent> gDS :vsplit <CR> gd <CR>
nmap <silent> gDT :tab split <CR> gd <CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <Leader>o :Clap tags <CR>
"map <Leader>o :CtrlPBufTag <CR>
map <Leader>p :Clap files<CR>
"map <Leader>p :CtrlP<CR>
"
"
"
"

 ":vnew
 ":vnew
 ":wincmd R

"augroup Apan
"au! VimEnter * nested vnew 
"augroup end

"augroup Bapan
"au! VimEnter * nested vnew
"augroup end

"augroup Capan
"au! VimEnter * :40vnew | :40vnew | wincmd r | wincmd l | echo 'apan'
"augroup end

"let g:go_version_warning = 0
"let g:go_code_completion_enabled = 0
"let g:go_auto_type_info = 0
"let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0


map <Leader> q :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


let g:qs_highlight_on_keys = ['f', 'F']

let g:NERDTreeWinSize=30
