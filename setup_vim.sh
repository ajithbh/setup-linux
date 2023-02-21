#!/bin/bash

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

mkdir -p ~/.vim/plugin
wget http://cscope.sourceforge.net/cscope_maps.vim -O ~/.vim/plugin/cscope_maps.vim

cat > ~/.vimrc << _EOF
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" The following are examples of different formats supported.
" Keep bundle commands between here and filetype plugin indent on.
" scripts on GitHub repos
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'wesleyche/SrcExpl'
Bundle 'WolfgangMehner/vim-plugins'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/c.vim--Zemin'
Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/CRefVim'
Bundle 'vim-scripts/autoload_cscope.vim'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-easytags'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'tpope/vim-sensible.git'
Bundle 'wincent/command-t.git'
" Bundle 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
Bundle 'L9'
Bundle 'FuzzyFinder'
" Bundle 'lh-vim-lib'
" scripts not on GitHub
" Bundle 'http://cx4a.org/repo/gccsense.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///home/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.
set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme torte
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\\"") > 0 && line("'\\"") <= line("$") |
    \   exe "normal g\`\\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis


set nobackup
set et
set ts=4
set sw=4

" Easytags opitions
let g:easytags_file = '~/.vim/tags'
set tags=./tags;
let g:easytags_dynamic_files = 1

" c.vim options
let g:WorkPathList=[
            \ join(['/home/',\$USER,'/.vim/bundle/c.vim'],""),
            \ join(['/home/',\$USER,'/.vim'],"") ]
let g:WorkPathIdx=1

" supertab options
" let g:SuperTabMappingForward = '<C-space>'

:map <C-s> :w<CR>
:imap <C-s> <ESC>:w<CR>

:map <C-e> :tabnew<CR>:e .<CR>
:imap <C-e> <ESC>:tabnew<CR>:e .<CR>
:map <C-p> :tabprev<CR>
:imap <C-p> <ESC>:tabprev<CR>
:map <C-n> :tabnext<CR>
:imap <C-n> <ESC>:tabnext<CR>

:map <F3> :q<CR>
:imap <F3> <ESC>:q<CR>
:map <F4> :qa<CR>
:imap <F4> <ESC>:qa<CR>
:map <S-F5> :tabprev<CR>
:imap <S-F5> <ESC>:tabprev<CR>
:map <F5> :tabnext<CR>
:imap <F5> <ESC>:tabnext<CR>
:map <F6> :mks!<CR>
:imap <F6> <ESC>:mks!<CR>
:map <F7> :Texplore<CR>
:imap <F7> <ESC>:Texplore<CR>

autocmd FileType gitcommit setlocal spell

_EOF

vim +BundleUpdate +qa

# Japanese manual cause problems for Vundle
rm ~/.vim/bundle/gccsense/doc/index.ja.txt
rm ~/.vim/bundle/gccsense/doc/manual.ja.txt

dos2unix ~/.vim/bundle/c.vim--Zemin/after/syntax/c.vim
dos2unix ~/.vim/bundle/c.vim--Zemin/doc/workpath.txt
dos2unix ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim
echo "Editing  ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim to conditionally set g:WorkPathList and g:WorkPathIdx"
sed -i '/^let g:WorkPathList=.*/i if empty(g:WorkPathList)' ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim
sed -i '/^let g:WorkPathIdx=.*/a endif' ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim
echo "Editing  ~/.vim/bundle/c.vim--Zemin/after/syntax/c.vim to fix tags path"
sed -i 's:\\tags:/tags:g' ~/.vim/bundle/c.vim--Zemin/after/syntax/c.vim
