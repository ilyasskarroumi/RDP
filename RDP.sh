#!/bin/bash

printf "Installing RDP... " >&2

{
    sudo useradd -m ALOK
    sudo adduser ALOK sudo
    echo 'ALOK:8426' | sudo chpasswd
    sudo sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
    sudo apt-get update
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
    sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
    sudo apt install nautilus nano -y
    sudo adduser ALOK chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Complete\n" >&2 ||
printf "\nError Occurred\n" >&2

printf 'Check https://remotedesktop.google.com/headless and Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here: " CRP
su - ALOK -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n\n'

if sudo apt-get upgrade &> /dev/null; then
    printf "\nUpgrade Completed\n" >&2
else
    printf "\nError Occurred\n" >&2
fi