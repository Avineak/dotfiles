let mapleader = " "
set number relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set autowrite
filetype plugin on
set incsearch
set autowriteall
set ignorecase "if dont this become case insensitive
set smartcase "if done in all small cases it will do it case insensetive way
set clipboard^=unnamed,unnamedplus
set guifont=Monospace:h11
let g:lsc_auto_map = v:true
setlocal cursorline
syntax on
nnoremap / /\v
let g:polyglot_disabled = ['go']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
set mouse=a
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
let g:indent_guides_enable_on_vim_startup = 1
"for quitting buffer
nnoremap <c-q> :q<CR>
nnoremap <A-h> :bprev<CR>
nnoremap <A-l> :bnext<CR>
nnoremap <UP> :cprev<CR>
nnoremap <DOWN> :cnext<CR>
nmap <silent> <BS> :nohlsearch<CR>

"macro

" vnoremap <c-y> "+y
" nnoremap <c-y> "+y
" nnoremap <c-p> "+p
" vnoremap <c-p> "+p
" inoremap <c-p> "+p

"for fast navigation
nmap <Tab> <c-^>  

"for window navigation
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

"netrw settings
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25

" let g:NetrwIsOpen=0

" let g:rainbow_active = 1

" function! ToggleNetrw()
"     if g:NetrwIsOpen
"         let i = bufnr("$")
"         while (i >= 1)
"             if (getbufvar(i, "&filetype") == "netrw")
"                 silent exe "bwipeout " . i 
"             endif
"             let i-=1
"         endwhile
"         let g:NetrwIsOpen=0
"     else
"         let g:NetrwIsOpen=1
"         silent Lexplore
"     endif
" endfunction

" Add your own mapping. For example:
map <leader>n :NERDTreeToggle<CR>
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

:au FocusLost * :wa

inoremap jj <Esc>
inoremap jn <Esc>o
inoremap <c-l> <Right>
inoremap <c-h> <left>

nnoremap <leader><leader>r :source ~/.vimrc<CR>
nnoremap <leader>f :q!<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>d :bd<CR>

"For moving blocks
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"for plug install
nnoremap <leader><leader>i :PlugInstall<CR>

"For prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"For ultisnip edit
nnoremap <leader><leader>s :CocCommand snippets.editSnippets<CR>

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
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
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

augroup HelpInTabs
	autocmd!
	autocmd BufEnter *.txt  call HelpInNewTab()

function HelpInNewTab ()
	if &buftype == 'help'
		execute "normal \<C-W>T"
	endif
endfunction

let g:javascript_plugin_flow = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'frazrepo/vim-rainbow'
Plug 'reisub0/hot-reload.vim'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'machakann/vim-sandwich'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/taglist.vim'
Plug 'turbio/bracey.vim'
Plug 'kien/ctrlp.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'oblitum/rainbow'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'fatih/vim-go'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'haishanh/night-owl.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-eunuch'
call plug#end()
"call FlutterMenu()
" colorscheme gruvbox
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme night-owl

" To enable the lightline theme
let g:lightline = { 'colorscheme': 'nightowl' }
