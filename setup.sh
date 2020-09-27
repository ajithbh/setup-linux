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

sudo apt-get -y install libdirectfb-dev libtiff5-dev

# Manpages
sudo apt-get -y install manpages-posix manpages-posix-dev

# UUID library
sudo apt-get -y install uuid uuid-dev 

# Data compression library
sudo apt-get -y install liblzo2-2 liblzo2-dev

# Develop 
sudo apt-get -y install build-essential libncurses-dev bison flex libssl-dev libelf-dev

sudo apt-get -y install g++ exuberant-ctags cscope indent cppcheck fakeroot

sudo apt-get -y install python-pip

sudo pip install virtualenv

# Scratchbox2
sudo apt-get -y install scratchbox2 qemu-kvm-extras

sudo apt-get -y install apt-file
sudo apt-file update

sudo apt-get -y install tmux

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

# cd /tmp/
# wget http://stats.es.net/software/iperf-3.0.1.tar.gz
# tar xvzf iperf-3.0.1.tar.gz 
# cd iperf-3.0.1/
# ./configure
# make && sudo make install
# cd ~

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

sudo apt-get -y install zsh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

