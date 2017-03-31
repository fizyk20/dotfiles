set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'rust-lang/rust.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'neomake/neomake'
Bundle 'mhartington/oceanic-next'
Bundle 'vim-airline/vim-airline'
Bundle 'joshdick/onedark.vim'
Bundle 'thinca/vim-localrc'

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

set t_Co=256
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" let g:ycm_rust_src_path="/home/bartek/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src"
let g:rustfmt_autosave = 1
let g:neomake_verbose = 2

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" CTRL-t to toggle tree view
nmap <silent> <C-t> :NERDTreeToggle<CR>
" Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

let g:neomake_rust_maker = {
    \ 'exe': 'cargo',
    \ 'args': ['rustc', '--', '-Zno-trans', '--test', '-Zincremental=target/incremental'],
    \ 'errorformat': neomake#makers#ft#rust#rustc()['errorformat'],
    \}
let g:neomake_rust_enabled_makers = []
autocmd! BufWritePost
autocmd BufWritePost *.rs Neomake! rust
