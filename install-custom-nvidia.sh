#!/bin/bash

# 5. Update apt to fetch the newly added NVIDIA packages
apt-get update
apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken --reinstall opencv-licenses=4.1.1-2-gd5a58aa75 --allow-downgrades
apt install -f -y
dpkg --configure -a
apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken nvidia-opencv 
apt install -f -y
dpkg --configure -a

# mkdir -p /proc/device-tree
# echo "nvidia,tegra210" | sudo tee /proc/device-tree/compatible
# 1. Download the package without installing it
apt-get update && apt-get download nvidia-l4t-core

# 2. Unpack the raw .deb file
dpkg-deb -R nvidia-l4t-core_*.deb /tmp/l4t-core-patch

# 3. Patch the preinst script to look for a fake hardware file in /tmp
sed -i 's|/proc/device-tree/compatible|/tmp/compatible|g' /tmp/l4t-core-patch/DEBIAN/preinst

# 4. Create the fake hardware signature for a TX2 (Tegra 186)
echo "nvidia,tegra186" > /tmp/compatible

# 5. Repackage the patched .deb
dpkg-deb -b /tmp/l4t-core-patch /tmp/patched-nvidia-l4t-core.deb

# 6. Install the patched package
yes n | apt-get install -y /tmp/patched-nvidia-l4t-core.deb

apt install -f -y
dpkg --configure -a

yes n | apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken nvidia-jetpack

apt install -f -y
dpkg --configure -a


