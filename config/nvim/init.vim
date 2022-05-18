" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'dag/vim-fish'

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Important configuration

" Set mapleader
let mapleader = ","
" Use ' as beginning of command (e.g. 'q = :q)
map ' :
" Set clipboard to the one used by all other applications
set clipboard+=unnamedplus
" Enable mouse support
set mouse:a
" Enable spell warnings
set spell spelllang=en_gb,sv
" Disable leader key timeout
set notimeout
set ttimeout
set relativenumber
set number
" Ignore case in search
set ignorecase
set smartcase
" Indent the next line at the same level as the current on <enter>
set autoindent
" Tabs are viewed as 4 spaces
set tabstop=4
" Indent 4 spaces
set shiftwidth=4
" always uses spaces instead of tab characters
set expandtab
" Makes typing tabs more consistent
set smarttab
" Format on capital F
nmap F :Format<CR>
" Open spelling suggestions on capital S
nmap S z=
" Enables plugins based on filetypes, such as syntax highlighting
filetype plugin on
" Add filetype-dependent indetation
filetype plugin indent on
" Adds folding by syntax
set fdm=syntax
" Highlight symbol under cursor on CursorHold
autocmd VimEnter * if exists(":CocAction") | autocmd CursorHold * silent call CocActionAsync('highlight')

" Set CursorHold time to 0.5 seconds
set updatetime=300
" Set color scheme to gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark="medium"
set background=dark

" Navigate windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Go to start/end of line in insert mode.
imap <S-Left> <C-o>0
imap <S-Right> <C-o>$
imap <C-a> <C-o>0
imap <C-e> <C-o>$

" Expand Rust macro
nmap <C-x> :CocCommand rust-analyzer.expandMacro<CR>
" Open official web docs in Rust
nmap <C-d> :CocCommand rust-analyzer.openDocs<CR>

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Toggle ignorecase
nmap <F8> :set ignorecase! ignorecase?<CR>

" Close current window
nmap <C-q> :clo<CR>

" Go to next/prev git changes
nmap [f :GitGutterPrevHunk<CR>
nmap ]f :GitGutterNextHunk<CR>

" Stage/revert hunk
" I know this is ugly (g is usually the 'go to', but now it's Git!)
nmap gs :GitGutterStageHunk<CR>
nmap gu :GitGutterUndoHunk<CR>

" Remap for rename current word
map <F9> <plug>(coc-rename)

" Remap to go to definition
map <F12> <plug>(coc-definition)

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" NERDCommenter
let g:NETDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
map <A-a> <plug>NERDCommenterToggle
nmap <S-A-a> <plug>NERDCommenterAltDelims

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Download coc extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-pairs',
  \ 'coc-html',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
  \ 'coc-json',
  \ 'coc-css',
  \ ]

" Copied from COC readme

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
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
map <C-a> <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
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
