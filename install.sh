
# INSTALL NEEDED PACKAGES
# sudo pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort ./software/pkglist.txt))
# sudo pacman -Syu

mkdir ~/dotfile_downloads

# INSTALL dwm
curl --output ~/dotfile_downloads/dwm-6.2.tar.gz http://dl.suckless.org/dwm/dwm-6.2.tar.gz
tar -zxvf ~/dotfile_downloads/dwm-6.2.tar.gz -C ~/dotfile_downloads
cp ./software/dwm-6.2/dwm-fullscreen-6.2.diff ./software/dwm-6.2/config.h  ~/dotfile_downloads/dwm-6.2/
cd ~/dotfile_downloads/
patch -i dwm-fullscreen-6.2.diff
make clean 
sudo make install
cd -

# INSTALL st
curl --output ~/dotfile_downloads/st-0.8.4.tar.gz http://dl.suckless.org/st/st-0.8.4.tar.gz
tar -zxvf ~/dotfile_downloads/st-0.8.4.tar.gz -C ~/dotfile_downloads
cp ./software/st-0.8.4/st-scrollback-0.8.4.diff ./software/st-0.8.4/config.h  ~/dotfile_downloads/st-0.8.4/
cd ~/dotfile_downloads/st-0.8.4/
patch -i st-scrollback-0.8.4.diff
make clean
sudo make install
cd -

# INSTALL dmenu
curl --output ~/dotfile_downloads/dmenu-5.0.tar.gz http://dl.suckless.org/tools/dmenu-5.0.tar.gz
tar -zxvf ~/dotfile_downloads/dmenu-5.0.tar.gz -C ~/dotfile_downloads
cp ./software/dmenu-5.0/config.h  ~/dotfile_downloads/dmenu-5.0/
cd ~/dotfile_downloads/dmenu-5.0
make clean
sudo make install
cd -

# INSTALL slock
curl --output ~/dotfile_downloads/slock-1.4.tar.gz http://dl.suckless.org/tools/slock-1.4.tar.gz
tar -zxvf ~/dotfile_downloads/slock-1.4.tar.gz -C ~/dotfile_downloads
cp ./software/slock-1.4/config.h  ~/dotfile_downloads/slock-1.4/
cd ~/dotfile_downloads/slock-1.4/
make clean
sudo make install
cd -

# INSTALL rover file manager
git clone --depth 1 https://github.com/lecram/rover.git ~/dotfile_downloads/rover/
cd ~/dotfile_downloads/rover/
make clean
sudo make install
cd -

# INSTALL PROGRAMMING LANGUAGES

## INSTALL JAVA
curl --output ~/dotfile_downloads/jdk17.tar.gz https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
tar -zxvf ~/dotfile_downloads/jdk17.tar.gz -C ~/dotfile_downloads/
mkdir ~/Java
mv ~/dotfile_downloads/jdk-17.0.1 /Java/
echo 'export JAVA_HOME=$HOME/Java/jdk-17.0.1' >>~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >>~/.bashrc

## INSTALL Miniconda
curl --output ~/dotfile_downloads/Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh ~/dotfile_downloads/Miniconda.sh


## EDIT PS1
echo "PS1='> '" >>~/.bashrc

## INSTALL MYENV (for conda)
conda create -n myenv python=3.8 scipy numpy matplotlib pandas scikit-learn seaborn jupyter 
conda activate myenv
echo "conda activate myenv" >>~/.bashrc

## SETUP FONTS
curl --output JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
mkdir /usr/share/fonts
mkdir /usr/share/fonts/JetBrainsMono
unzip JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMono
fc-cache -f -v


## INSTALL BITWARDEN
curl --output ~/dotfile_downloads/bitwarden.zip https://github.com/bitwarden/cli/releases/download/v1.19.1/bw-linux-1.19.1.zip
unzip ~/dotfile_downloads/bitwarden.zip -d ~/dotfile_downloads/
sudo install -m 755 ~/dotfile_downloads/bw /usr/local/bin/bw


## INSTALL NEOVIM
cp -r .config/nvim ~/.config/
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync





