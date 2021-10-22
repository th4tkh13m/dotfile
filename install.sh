
# INSTALL NEEDED PACKAGES
sudo pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort ./software/pkglist.txt))

mkdir ~/dotfile_downloads

# INSTALL dwm
curl --output dwm-6.2.tar.gz http://dl.suckless.org/dwm/dwm-6.2.tar.gz
tar -zxvf dwm-6.2.tar.gz -C ~/dotfile_downloads
cp ./software/dwm-6.2/dwm-fullscreen-6.2.diff ./software/dwm-6.2/config.h  ~/dotfile_downloads/dwm-6.2/
patch --merge -i ~/dotfile_downloads/dwm-6.w/dwm-fullscreen-6.2.diff
make clean
sudo make install

# INSTALL st

