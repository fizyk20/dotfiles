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
" Plugin 'neovim/nvim-lspconfig'
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

" nvim-lspconfig
" lua << EOF
" -- Setup language servers.
" local lspconfig = require('lspconfig')
" --lspconfig.pyright.setup {}
" --lspconfig.tsserver.setup {}
" lspconfig.rust_analyzer.setup {
  " -- Server-specific settings. See `:help lspconfig-setup`
  " settings = {
    " ['rust-analyzer'] = {},
  " },
" }
" 
" -- Global mappings.
" -- See `:help vim.diagnostic.*` for documentation on any of the below functions
" vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
" vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
" vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
" vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
" 
" -- Use LspAttach autocommand to only map the following keys
" -- after the language server attaches to the current buffer
" vim.api.nvim_create_autocmd('LspAttach', {
  " group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  " callback = function(ev)
    " -- Enable completion triggered by <c-x><c-o>
    " vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
" 
    " -- Buffer local mappings.
    " -- See `:help vim.lsp.*` for documentation on any of the below functions
    " local opts = { buffer = ev.buf }
    " vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    " vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    " vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    " vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    " vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    " vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    " vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    " vim.keymap.set('n', '<space>wl', function()
      " print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    " end, opts)
    " vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    " vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    " vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    " vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    " vim.keymap.set('n', '<space>f', function()
      " vim.lsp.buf.format { async = true }
    " end, opts)
  " end,
" })
" EOF

" autocmd! BufWritePost
" autocmd BufWritePost *.rs Neomake! rust

au FileType javascript setl sw=2 sts=2
