"===================== 
"|VIM Plugins Hackzer|
"===================== 

call plug#begin("~/.vim/plugged")   

Plug 'preservim/nerdtree' 

Plug 'tpope/vim-fugitive' 

Plug 'junegunn/goyo.vim'

Plug 'vimwiki/vimwiki'

Plug 'tpope/vim-surround'

Plug 'terroo/vim-auto-markdown'

Plug 'tomasiser/vim-code-dark'

Plug 'jiangmiao/auto-pairs'  

Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

Plug 'airblade/vim-gitgutter'

Plug 'ryanoasis/vim-devicons'

Plug 'mhinz/vim-signify'

Plug 'mhinz/vim-startify'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-tree/nvim-web-devicons'

Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'mengelbrecht/lightline-bufferline'

Plug 'yorickpeterse/happy_hacking.vim'

Plug 'kien/rainbow_parentheses.vim'

Plug 'w0rp/ale'

Plug 'ervandew/supertab'

call plug#end()               

"==----------------==
"|VIM .vimrc Hackzer|
"==----------------==
"
set foldmethod=marker
set foldlevelstart=0
set title
set termguicolors
set t_Co=256
set ttyfast
set lazyredraw
set redrawtime=50
set nocompatible
set number
set relativenumber
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent
set wrap
set mouse=a
syntax on
set clipboard=unnamedplus
set hlsearch
set incsearch
set ignorecase
set smartcase
colorscheme happy_hacking
set laststatus=2
set cursorline
set showcmd
set wildmenu
set showtabline=2
set confirm 
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified'  ] ],
            \
            \ 'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileenconding', 'filetype' ] ]
            \ }, 
            \ 'tabline': {
            \   'left': [ ['buffers'] ],
            \   'right': [ ['close'] ]
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ }
            \ }
let g:lightline.component = {
            \ 'lineinfo': '%3l:%-2v',
            \ 'percent': '%3p%%',
            \ 'fileformat': '%{&fileformat}',
            \ 'fileencoding': '%{&fileencoding}',
            \ 'filetype': '%{&filetype}',
            \ 'mode': '%{toupper(mode())}'
            \ }
let g:lightline.component_function = {
            \ 'gitbranch': "FugitiveHead"
            \}
let g:lightline.active.right = [ [ 'lineinfo' ], [ 'percent' ], [ 'gitbranch', 'fileformat', 'fileencoding', 'filetype' ] ]
let g:lightline.component_expand = {
            \ 'readonly': 'lightline#devicons#readonly',
            \ 'fileformat': 'lightline#devicons#fileformat',
            \ 'filetype': 'lightline#devicons#filetype'
            \ }
let g:lightline.component_type = {
            \ 'readonlyy': 'error',
            \ 'fileformat': 'right',
            \ 'filetype': 'right',
            \ }
"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"|VIM Atalhos/configs Hackzer|
"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

nmap <C-n> :NERDTreeToggle<CR>
nmap <C-k> :bprevious<CR>
nmap <C-l> :bnext<CR>
nmap <C-b> :Buffers<CR>
nmap <C-t> :terminal<CR>

nmap <leader>gs :G<CR>
 
noremap <space> :nohlsearch<CR>

set updatetime=100
let g:gitgutter_enabled = 1

"\==============================/
" | Commands Custom and Macros |
"/==============================\

command! MemHelp :vsplit ~/.vim/docs/memlsp.vimdoc
command! LibcHelp :vsplit ~/.vim/docs/libc.vimdoc
