
# INSTALL NEEDED PACKAGES
sudo pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort ./software/pkglist.txt))
sudo pacman -Syu

mkdir ~/dotfile_downloads

# INSTALL dwm
curl --output ~/dotfile_downloads/dwm-6.2.tar.gz http://dl.suckless.org/dwm/dwm-6.2.tar.gz
tar -zxvf ~/dotfile_downloads/dwm-6.2.tar.gz -C ~/dotfile_downloads
cp ./software/dwm-6.2/dwm-fullscreen-6.2.diff ./software/dwm-6.2/config.h  ~/dotfile_downloads/dwm-6.2/
patch --merge -i ~/dotfile_downloads/dwm-6.2/dwm-fullscreen-6.2.diff
make clean -C ~/dotfile_downloads/dwm-6.2
sudo make install -C ~/dotfile_downloads/dwm-6.2

# INSTALL st
curl --output ~/dotfile_downloads/st-0.8.4.tar.gz http://dl.suckless.org/st/st-0.8.4.tar.gz
tar -zxvf ~/dotfile_downloads/st-0.8.4.tar.gz -C ~/dotfile_downloads
cp ./software/st-0.8.4/st-scrollback-0.8.4.diff ./software/st-0.8.4/config.h  ~/dotfile_downloads/st-0.8.4/
patch --merge -i ~/dotfile_downloads/st-0.8.4/st-scrollback-0.8.4.diff
make clean -C ~/dotfile_downloads/st-0.8.4
sudo make install -C ~/dotfile_downloads/st-0.8.4

# INSTALL dmenu
curl --output ~/dotfile_downloads/dmenu-5.0.tar.gz http://dl.suckless.org/tools/dmenu-5.0.tar.gz
tar -zxvf ~/dotfile_downloads/dmenu-5.0.tar.gz -C ~/dotfile_downloads
cp ./software/dmenu-5.0/config.h  ~/dotfile_downloads/dmenu-5.0/
make clean -C ~/dotfile_downloads/dmenu-5.0
sudo make install -C ~/dotfile_downloads/dmenu-5.0

# INSTALL slock
curl --output ~/dotfile_downloads/slock-1.4.tar.gz http://dl.suckless.org/tools/slock-1.4.tar.gz
tar -zxvf ~/dotfile_downloads/slock-1.4.tar.gz -C ~/dotfile_downloads
cp ./software/slock-1.4/config.h  ~/dotfile_downloads/slock-1.4/
make clean -C ~/dotfile_downloads/slock-1.4
sudo make install -C ~/dotfile_downloads/slock-1.4




