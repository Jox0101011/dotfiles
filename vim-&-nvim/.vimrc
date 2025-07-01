"===================== 
"|VIM Plugins Hackzer|
"===================== 

call plug#begin("~/.vim/plugged")   

Plug 'preservim/nerdtree' 

Plug 'tpope/vim-fugitive' 

Plug 'tpope/vim-surround'

Plug 'tomasiser/vim-code-dark'

Plug 'jiangmiao/auto-pairs'  

Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'airblade/vim-gitgutter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline-themes'

Plug 'mhinz/vim-signify'

Plug 'mhinz/vim-startify'

call plug#end()               

"==----------------==
"|VIM .vimrc Hackzer|
"==----------------==

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
colorscheme codedark

"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"|VIM Atalhos/configs Hackzer|
"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

nmap <C-n> :NERDTreeToggle<CR>

nmap <leader>gs :G<CR>
 
noremap <space> :nohlsearch<CR>

let g:airline_powerline_fonts = 1

set updatetime=100
let g:gitgutter_enabled = 1
