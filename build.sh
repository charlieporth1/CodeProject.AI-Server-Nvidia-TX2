#!/bin/bash
sudo chmod +x *.sh
cp -rfv /etc/nv* ~/
sudo rm /etc/resolv.conf
sudo ln -s  /run/resolvconf/resolv.conf  /etc/resolv.conf 

sudo ifmetric eth0 100
sudo ifmetric eth0 100

sudo mount /dev/disk/by-id/usb-MZ7LH480_HBHQ0D3_20211019-0\:0-part2 /mnt/USB
sudo systemctl start docker docker.socket
#sudo systemctl status docker

sudo ln -s  /mnt/USB/docker /var/lib/

sudo docker build -t   codeproject-ai-tx2 . 
