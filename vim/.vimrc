set showmatch
set nocompatible              " be iMproved, required
filetype off                  " required

" execute pathogen#infect()
syntax on
filetype plugin indent on

" yaml file editing
autocmd FileType yaml setlocal ts=2 sw=2 et
autocmd FileType yml setlocal ts=2 sw=2 et

" easy buffer switching https://vi.stackexchange.com/a/9159
nnoremap <leader>b :buffers<CR>:buffer<space>

" tabing around the buffers
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class,*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignorecase
set wildmode=list:full

" Learning mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
