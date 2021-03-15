#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: None
#  REQUIREMENTS: git, apt-get
#          BUGS: 
#         NOTES: Scripts to setup new Ubuntu Linux installation
#        AUTHOR: Ajith Bhaskaran
#  ORGANIZATION: 
#       CREATED: 03/03/2014 16:01
#      REVISION: 1.0
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sudo apt-get -y install git-core subversion quilt tree curl

sudo apt-get -y install vim-gtk meld minicom

sudo apt-get -y install smbfs cifs-utils nfs-kernel-server tftp-hpa tftpd-hpa

sudo apt-get -y install squashfs-tools

sudo apt-get -y install tofrodos
sudo ln -s /usr/bin/fromdos /usr/bin/dos2unix
sudo ln -s /usr/bin/todos /usr/bin/unix2dos

sudo apt-get -y install zlibc zlib1g-dev

sudo apt-get -y install libdirectfb-dev libtiff4-dev

# Manpages
sudo apt-get -y install manpages-posix manpages-posix-dev

# UUID library
sudo apt-get -y install uuid uuid-dev 

# Data compression library
sudo apt-get -y install liblzo2-2 liblzo2-dev

# Develop 
sudo apt-get -y install g++ exuberant-ctags cscope indent cppcheck build-essential fakeroot

sudo apt-get -y install python-pip

sudo pip install virtualenv

# Scratchbox2
sudo apt-get -y install scratchbox2 qemu-kvm-extras

# qemu_version=`qemu-arm --version | awk ' /version/ {print $3}'`
# Scratchbox2 needs atleast version 0.13 of qemu 
# cd /tmp/
# wget http://wiki.qemu-project.org/download/qemu-0.13.0.tar.gz
# tar xvzf qemu-0.13.0.tar.gz
# cd qemu-0.13.0/
# ./configure
# make && sudo make install
# cd ~

# cd /tmp/
# wget http://stats.es.net/software/iperf-3.0.1.tar.gz
# tar xvzf iperf-3.0.1.tar.gz 
# cd iperf-3.0.1/
# ./configure
# make && sudo make install
# cd ~

cd ~/Downloads
wget http://download.savannah.gnu.org/releases/quilt/quilt-0.60.tar.gz
tar xvzf quilt-0.60.tar.gz
cd quilt-0.60
./configure
make
sudo make install
cd ~


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
" Bundle 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
Bundle 'L9'
Bundle 'FuzzyFinder'
" Bundle 'lh-vim-lib'
" scripts not on GitHub
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'http://cx4a.org/repo/gccsense.git'
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
let g:SuperTabMappingForward = '<C-space>'

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

_EOF

vim +BundleUpdate +qa

# Japanese manual cause problems for Vundle
rm ~/.vim/bundle/gccsense/doc/index.ja.txt
rm ~/.vim/bundle/gccsense/doc/manual.ja.txt

dos2unix ~/.vim/bundle/c.vim--Zemin/after/syntax/c.vim
dos2unix ~/.vim/bundle/c.vim--Zemin/doc/workpath.txt
dos2unix ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim
echo "Remember to edit  ~/.vim/bundle/c.vim--Zemin/plugin/workpath.vim  to set g:WorkPathList and g:WorkPathIdx"

echo "-i4 -nbad -bap -bbb -cdb -sc -br -ce -cdw -cli4 -cbi0 -ss -npcs -cs -bs -saf -sai -saw -nbc -npsl -bls -blf -lp -ip0 -ppi3 -il0 -bbo -nprs -nut -sob -nfca -d0 -di1 -l200" > ~/.indent.pro

