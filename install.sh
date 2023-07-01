#! /bin/bash
#Arch Post Install script
#
echo
echo "Setting up config files"
echo
mkdir -v ~/.config
sudo mkdir -pv /use/local/share/fonts/ttf
sudo cp -rv ~/.dotfiles/font/* /usr/local/share/fonts/ttf
fc-cache
cp -rv ~/.dotfiles/* ~/
echo
echo "Installing XORG display server"
echo

PKGS=(
	'xorg-server'
	'xorg-xinit'
	'xf86-video-intel'
	'xf86-input-libinput'
	'make'
	'libxft'
)
for PKG in "${PKGS[@]}"; do
	echo "Installing: ${PKG}"
	sudo pacman -S "$PKG" --noconfirm --needed
done

echo 
echo "Installing Suckless utils"
echo
echo "cloning into .suckless"
git clone https://github.com/zerkxes/st.git ~/.suckless/st
git clone https://github.com/zerkxes/dwm.git ~/.suckless/dwm
git clone https://git.suckless.org/dmenu ~/.suckless/dmenu
cd ~/.suckless/dmenu/
sudo make
sudo make install
cd ~/.suckless/dwm/
sudo make
sudo make install
cd ~/.suckless/st/
sudo make
sudo make install
cd ~
echo 
echo "Installing utilities"
echo
UPKGS=(
	'neofetch'
	'htop'
	'ranger'
	'alsa-utils'
	'picom'
	'feh'
)
for PKG in "${UPKGS[@]}"; do
	echo "Installing: ${PKG}"
	sudo pacman -S "$PKG" --noconfirm --needed
done
exit
