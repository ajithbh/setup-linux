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
#  REQUIREMENTS: apt-get
#          BUGS:
#         NOTES: Scripts to setup new Ubuntu Linux installation
#        AUTHOR: Ajith Bhaskaran
#  ORGANIZATION:
#       CREATED: 03/03/2014 16:01
#      REVISION: 2.0
#===============================================================================

set -o nounset                              # Treat unset variables as an error

NORM='\e[39m'
RED='\e[91m'
GREEN='\e[32m'
YELLOW='\e[93m'

pkg_install()
{
    echo -e "${YELLOW}[Installing $@ ]${NORM}"
    sudo apt-get -y install $@
    [ $? = 0 ] && echo -e "${GREEN}[Done]${NORM}" || echo -e "${RED}[Fail]${NORM}"
}

PKGS=(
# Develop
build-essential
libncurses-dev
bison
flex
libssl-dev
libelf-dev
g++
exuberant-ctags
cscope
meld
indent
cppcheck
fakeroot
python-pip
virtualenv
# Version control
git-core
subversion
# patch management
quilt
# Editor
vim-gtk
# Network tools
curl
cifs-utils
nfs-kernel-server
tftp-hpa
tftpd-hpa
# Communication
minicom
# FS tools
squashfs-tools
# Utilities
apt-file
aptitude
tree
tofrodos
zlibc
zlib1g-dev
uuid
uuid-dev
libdirectfb-dev
libtiff5-dev
scratchbox2
iperf3
tmux
tofrodos
# Shells
zsh
# VM
qemu-kvm-extras
# Data compression library
liblzo2-2
liblzo2-dev
# Man pages
manpages-posix
)

for pkg in ${PKGS[*]}; do
    pkg_install $pkg
done

# Setup links for tofrodos
[ ! -e /usr/bin/fromdos ] && sudo ln -s /usr/bin/fromdos /usr/bin/dos2unix
[ ! -e /usr/bin/todos ] && sudo ln -s /usr/bin/todos /usr/bin/unix2dos

# Update apt-file database
sudo apt-file update

# Download tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Configure tmux
cat > ~/.tmux.conf << _EOF
set -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix

set -g base-index 1

set -g default-shell /bin/zsh

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
_EOF


# qemu_version=`qemu-arm --version | awk ' /version/ {print $3}'`
# Scratchbox2 needs atleast version 0.13 of qemu
# cd /tmp/
# wget http://wiki.qemu-project.org/download/qemu-0.13.0.tar.gz
# tar xvzf qemu-0.13.0.tar.gz
# cd qemu-0.13.0/
# ./configure
# make && sudo make install
# cd ~

if [ ! -e /usr/bin/iperf3 ]; then
    cd /tmp/
    wget http://stats.es.net/software/iperf-3.0.1.tar.gz
    tar xvzf iperf-3.0.1.tar.gz
    cd iperf-3.0.1/
    ./configure
    make && sudo make install
    cd ~
fi

if [ ! -e /usr/bin/quilt ]; then
    cd ~/Downloads
    wget http://download.savannah.gnu.org/releases/quilt/quilt-0.60.tar.gz
    tar xvzf quilt-0.60.tar.gz
    cd quilt-0.60
    ./configure
    make
    sudo make install
    cd ~
fi

./setup_vim.sh

echo "-i4 -nbad -bap -bbb -cdb -sc -br -ce -cdw -cli4 -cbi0 -ss -npcs -cs -bs -saf -sai -saw -nbc -npsl -brs -blf -lp -ip0 -ppi1 -il0 -bbo -nprs -nut -sob -nfca -d0 -di1 -l200" > ~/.indent.pro

# Set default shell as zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

