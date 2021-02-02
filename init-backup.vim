"set number relativenumber
set number

" disable step on space
nnoremap <SPACE> <Nop>


" set \ as leader
let mapleader="\\"

" set space as leader
map <Space> <Leader>

set noswapfile
set ignorecase
set smartcase
syntax enable
"set clipboard+=unnamed
set nuw=1
set completeopt=noinsert
let g:netrw_liststyle = 3


set ts=6 sw=6"

" Make splits resize to equal width when window size changes
autocmd VimResized * wincmd =       

call plug#begin('~/.vim/plugged')

" ColorSchemes and visuals
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'jparise/vim-graphql'
Plug 'mhartington/oceanic-next'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope'

""""""""""""""""""""""
" Language integration
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'pangloss/vim-javascript'
"""""""""""""""""""""""""


Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'liuchengxu/vista.vim'
Plug 'beautify-web/js-beautify'

Plug 'voldikss/vim-floaterm'

Plug 'vim-test/vim-test'

call plug#end()

" show substitute preview
set inccommand=nosplit

" built in highlight on yank
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END



set termguicolors
let ayucolor="dark"
set t_Co=256
set background=dark
colorscheme ayu
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

let g:floaterm_position='center'

" remove search highlight on esc
nnoremap <silent> <ESC> :noh <ESC>

" disable automatic jump after seraching for word under cursor
nnoremap * :let @/ = '<c-r><c-w>' \| set hlsearch<cr>

" disable automatic jump when searching by /

nmap <silent> <Leader>gs :call CocAction('jumpDefinition', 'vsplit') <CR>
nmap <silent> <Leader>gt :call CocAction('jumpDefinition', 'tabe') <CR>

"let g:fzf_layout = { 'down':  '40%'}

" monocle mode?
"nmap <silent> <C-m> :abnew % <CR>

"nnoremap <silent> gh <cmd>lua vim.lsp.buf.declaration()<CR>
"nnoremap <silent> gn <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap gi    <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap J 3j 
nnoremap K 3k

"nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
"
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx



:highlight LineNr ctermfg=darkgrey
:highlight CursorLineNr ctermfg=yellow


if (colors_name ==# 'PaperColor' || colors_name ==# 'NeoSolarized')
	let g:clap_theme = 'material_design_dark'
endif


" Visuals
let NERDTreeMinimalUI = 1
let g:netrw_banner = 0
set splitbelow
set splitright
"set statusline +=\ %{FugitiveStatusline()}
"

""""" AIRLINE STATUS BAR 
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_x=''
let g:airline_skip_empty_sections = 1
let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tabline#enabled = 1           
let g:airline#extensions#tabline#show_close_button = 0 
let g:airline#extensions#tabline#tabs_label = ''       
let g:airline#extensions#tabline#buffers_label = ''    
let g:airline#extensions#tabline#fnamemod = ':t'       
let g:airline#extensions#tabline#show_tab_count = 0               
let g:airline#extensions#tabline#show_buffers = 0      
let g:airline#extensions#tabline#tab_min_count = 2     
let g:airline#extensions#tabline#show_splits = 0       
let g:airline#extensions#tabline#show_tab_nr = 0       
let g:airline#extensions#tabline#show_tab_type = 0     

let g:webdevicons_enable_airline_tabline = 0
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
""""""""""""""""""""""""""""

vnoremap <Leader>y "+y
nnoremap <Leader>y "+y


" Navigation
"nnoremap <Leader>g :TestNearest <CR>
" Exit insert mode in term by esc
"tnoremap <Esc> <C-\><C-n>
" Go to embedded terminal in new tab on leader-t
"map <Leader>t :tabnew <bar> :term <CR> i git status <CR>
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

" search word under cursor
noremap <Leader>a :Rg! <C-R><C-W><CR>

" let CoC handle completion
let g:go_code_completion_enabled = 0

" NERDTree toggle with current file highlighted
"nnoremap <silent> <expr> <C-e> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <expr> <C-e> "\:NERDTreeFind<CR>"

" Misc
" Auto update buffers when file change on disk, git checkout etc
"autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
"autocmd FileChangedShellPost *
  "\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:go_fmt_command = "goimports"


" CoC Settings
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=1
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
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gl <Plug>(coc-type-definition)

map <Leader>p :Files<CR>

command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))

let g:go_doc_keywordprg_enabled = 0

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:NERDTreeWinSize=20


" Adaptive width set for nerd tree on 'w'
function! s:SID()
    if ! exists('s:sid')
        let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    endif
    return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

autocmd VimEnter * call NERDTreeAddKeyMap({
    \ 'key': 'w',
    \ 'callback': s:SNR.'toggle_width',
    \ 'quickhelpText': 'Toggle window width' })

function! s:toggle_width()
    let l:max = 0
    for l:z in range(1, line('$'))
        let l:len = len(getline(l:z))
        if l:len > l:max
            let l:max = l:len
        endif
    endfor
    exe 'vertical resize '.(l:max == winwidth('.') ? g:NERDTreeWinSize : l:max)
endfunction

autocmd FileType javascript setlocal expandtab tabstop=4 shiftwidth=4 smarttab

silent! nmap <unique> J <Plug>(SmoothieDownwards)
silent! nmap <unique> K <Plug>(SmoothieUpwards)

autocmd FileType floaterm nnoremap <buffer> l :FloatermNext<CR>
autocmd FileType floaterm nnoremap <buffer> h :FloatermPrev<CR>
autocmd FileType floaterm nnoremap <buffer> n :FloatermNew<CR>
autocmd FileType floaterm nnoremap <buffer> <ESC> :FloatermHide<CR>
map <Leader>t :FloatermToggle <CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Always set keyboard layout to US in when entering vim client window
" or starting vim. Requires EWMH compiant window manager and terminal.
" For DWM, use ewmhtags patch and focusonnetactive patch to enable. 
autocmd FocusGained,VimEnter * :silent exec "! setxkbmap us &"

let $BAT_THEME='Nord'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


nnoremap <Leader>o :Vista finder coc <CR>

au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au FileType fzf tunmap <buffer> <Esc>


" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap <leader>l :tabnext<cr>
noremap <leader>h :tabprevious<cr>
noremap <leader>n :tabnew<cr>

let g:go_highlight_trailing_whitespace_error=0

nmap <silent> <Leader>dn :call CocAction('diagnosticNext')<CR>
nmap <silent> <Leader>dp :call CocAction('diagnosticPrevious')<CR>
nmap <silent> <Leader>dl :CocFzfList diagnostics<CR>

let test#go#runner = 'gotest'
let test#strategy = 'floaterm'

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go :OR
