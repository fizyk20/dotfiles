set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'rust-lang/rust.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'Valloric/YouCompleteMe'

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

let g:ycm_rust_src_path="/home/bartek/programy/rust/rust/src"

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" CTRL-t to toggle tree view
nmap <silent> <C-t> :NERDTreeToggle<CR>
" Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>
