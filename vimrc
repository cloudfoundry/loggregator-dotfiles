"------------------------------------------------------------------------------
" GENERAL
"------------------------------------------------------------------------------
set encoding=utf-8            " Ensure encoding is UTF-8
set nocompatible              " Disable Vi compatability
set mouse=a                   " Enable mouse in all modes
set hidden                    " Allow unwritten buffers

"-----------------------------------------------------------------------------
" VUNDLE PLUGIN MANAGEMENT
"-----------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim   " Set the runtime path to include Vundle
call vundle#begin()                 " Initialize vundle
Plugin 'VundleVim/Vundle.vim'       " Let Vundle manage Vundle
Plugin 'ctrlpvim/ctrlp.vim'         " Quick file navigation
Plugin 'tpope/vim-commentary'       " Quickly comment lines out and in
Plugin 'tpope/vim-fugitive'         " Help formatting commit messages
Plugin 'tpope/vim-dispatch'         " Allow background builds
Plugin 'fatih/vim-go'               " Helpful plugin for Golang dev
Plugin 'vim-scripts/bufkill.vim'    " Kill buffers and leave windows intact
Plugin 'scrooloose/nerdtree'        " visual file hierarchy navigation
call vundle#end()                   " Complete vunde initialization

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

"-----------------------------------------------------------------------------
" VIM-GO CONFIG
"-----------------------------------------------------------------------------
let g:go_fmt_command = "goimports"

" highlight go-vim
highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
set updatetime=100 " updates :GoInfo faster

" vim-go command shortcuts
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>d :GoDeclsDir<CR>
autocmd FileType go nmap <leader>g <Plug>(go-generate)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

function! s:toggle_coverage()
    call go#coverage#BufferToggle(!g:go_jump_to_error)
    highlight ColorColumn ctermbg=235
    highlight NonText ctermfg=239
    highlight SpecialKey ctermfg=239
    highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
endfunction

autocmd FileType go nmap <leader>c :<C-u>call <SID>toggle_coverage()<CR>

"-----------------------------------------------------------------------------
" CTRL-P CONFIG
"-----------------------------------------------------------------------------
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|vagrant)|node_modules)$',
  \ 'file': '\v\.(swp|zip|exe|so|dll|a)$',
  \ }
" stop setting git repo as root path
let g:ctrlp_working_path_mode = ''

"-----------------------------------------------------------------------------
" nerd tree config
"-----------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
"------------------------------------------------------------------------------
" APPEARANCE
"------------------------------------------------------------------------------
syntax on               " enable syntax highlighting
set number              " show line numbers
set ruler               " show lines in lower right
set nowrap              " don't wrap lines eva!

colorscheme lucius      " color scheme
set cursorline          " highlight current line
set highlight=sbr       " invert and bold status line
let loaded_matchparen = 1

set t_Co=256            " set 256 color
set colorcolumn=80      " highlight col 80
highlight ColorColumn ctermbg=235
set listchars=tab:▸\ ,eol:¬,trail:· " show whitespace characters
set list                " enable display of invisible characters

" invisible character colors
highlight NonText ctermfg=239
highlight SpecialKey ctermfg=239

"------------------------------------------------------------------------------
" BEHAVIOR
"------------------------------------------------------------------------------
set backspace=indent,eol,start  " enable better backspacing
set noswapfile                  " disable swap files
set nowb                        " disable writing backup
set textwidth=78                " global text columns
set formatoptions+=l            " don't break long lines less they are new

set hlsearch                    " highlight search results
set smartcase                   " ignore case if lower, otherwise match case
set splitbelow                  " split panes on the bottom
set splitright                  " split panes to the right

set history=10000               " keep a longer history

set wildmenu                    " allow for menu suggestions

set autowrite                   " automatically write file on `:make`

autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
autocmd BufLeave * silent! wall    " save on lost focus

" tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" smaller indents for yaml
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

"------------------------------------------------------------------------------
" LEADER MAPPINGS
"------------------------------------------------------------------------------
let mapleader = ","              " set leader

" switch between files
nnoremap <leader><leader> <c-^>

" quickly Open vimrc
nmap <silent> <leader>ev :edit $MYVIMRC<cr>
" load vimrc into memory
nmap <silent> <leader>ee :source $MYVIMRC<cr>

" clear the search buffer when hitting space
nnoremap <space> :nohlsearch<cr>

" reselect when indenting
vnoremap < <gv
vnoremap > >gv

" clipboard fusion!
set clipboard^=unnamed clipboard^=unnamedplus

" turn folding on and open by default
set foldmethod=syntax
set foldlevel=99

" remove the need to hit c-w for navigating splits
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
