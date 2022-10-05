#!/bin/bash

#################################################################################################
#########    Colorize and add text parameters       #############################################
#################################################################################################

blk=$(tput setaf 0) # black
red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
ylw=$(tput setaf 3) # yellow			${ylw}
blu=$(tput setaf 4) # blue
mga=$(tput setaf 5) # magenta
cya=$(tput setaf 6) # cyan
wht=$(tput setaf 7) # white
#
txtbld=$(tput bold) # Bold
bldblk=${txtbld}$(tput setaf 0) # black
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldylw=${txtbld}$(tput setaf 3) # yellow
bldblu=${txtbld}$(tput setaf 4) # blue
bldmga=${txtbld}$(tput setaf 5) # magenta
bldcya=${txtbld}$(tput setaf 6) # cyan
bldwht=${txtbld}$(tput setaf 7) # white
txtrst=$(tput sgr0) # Reset					${txtrst}
# new alert text
ALERT=${BWhite}${On_Red} # Bold White on red background
#
#
#
#
echo
echo ${ylw}"#################################################################################################" ${txtrst}
echo ${ylw}"######### ${bldwht}    adding Chotic-AUR      ${txtrst} ${ylw} ##########################################################" ${txtrst}
echo ${ylw}"#################################################################################################" ${txtrst}
echo

sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sleep 1
sudo pacman-key --lsign-key FBA220DFC880C036
sleep 1
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sleep 1

sudo cat << EOF >> /etc/pacman.conf
#########   chaotic-aur   #############################
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
sleep 1

sudo pacman -Sy & pacman -Syu
sleep 1

echo
echo ${ylw}"#################################################################################################" ${txtrst}
echo ${ylw}"######### ${bldwht}    install labwc   ${txtrst} ${ylw} ##########################################################" ${txtrst}
echo ${ylw}"#################################################################################################" ${txtrst}
echo
sudo pacman -S --needed --noconfirm geany geany-plugins tilix gmrun ufw tint2 networkmanager network-manager-applet kanshi pamac-aur caja mako swayidle
sudo pacman -S git wget meson labwc-git yambar
sleep 1

git clone https://github.com/labwc/labwc-tweaks.git
cd labwc-tweaks
meson build
ninja -C build
sudo ninja -C build install
cd ..
sleep 1

git clone https://github.com/labwc/labwc-menu-generator.git
cd labwc-menu-generator
make 
sudo cp labwc-menu-generator /usr/bin/
cd ..
sleep 1

mkdir -p ~/.config/labwc
cp .config/labwc/*  ~/.config/labwc/

git clone https://github.com/addy-dclxvi/openbox-theme-collections.git
cp -r openbox-theme-collections/* ~/.local/
