set nocompatible
set ts=4
set sw=4
set expandtab
filetype off
set rtp+=~/.vim/bundle/Vundle.Vim

call vundle#begin()

Plugin 'VundleVim/Vundle.Vim'
Plugin 'preservim/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'autozimu/LanguageClient-neovim'
Plugin 'Shougo/deoplete.nvim'
" Plugin 'neomake/neomake'
Plugin 'mhartington/oceanic-next'
Plugin 'vim-airline/vim-airline'
Plugin 'joshdick/onedark.vim'
Plugin 'thinca/vim-localrc'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'cespare/vim-toml'

call vundle#end()

filetype plugin indent on
syntax on

" backups and other junky files
set backupdir=~/.vim/backup     " get backups outta here
set directory=~/.vim/swap       " get swapfiles outta here
set writebackup                 " temp backup during write
set undodir=~/.vim/undo         " persistent undo storage
set undofile                    " persistent undo on

set number
set showcmd
set laststatus=2
set lazyredraw
set ruler
set showmatch
set colorcolumn=100

set t_Co=256
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustfmt"

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" CTRL-t to toggle tree view
nmap <silent> <C-t> :NERDTreeToggle<CR>
" Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

nmap <silent> <C-l> :set relativenumber!<CR>

" LanguageClient config
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \}
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingFile = '/tmp/lc.log'

let g:deoplete#enable_at_startup = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>

" autocmd! BufWritePost
" autocmd BufWritePost *.rs Neomake! rust

au FileType javascript setl sw=2 sts=2
