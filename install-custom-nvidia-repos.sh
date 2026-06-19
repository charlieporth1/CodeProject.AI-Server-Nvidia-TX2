#!/bin/bash

# 1. Install prerequisites for fetching keys and managing repositories
apt-get update && apt-get install -y wget gnupg software-properties-common

# 2. Add the NVIDIA Jetson OTA public GPG key
wget -qO - https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | apt-key add -

# 3. Add the L4T 'common' repository for JetPack 4.6.x
echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

# 4. Add the TX2-specific ('t186') repository
echo "deb https://repo.download.nvidia.com/jetson/t186 r32.7 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

# COPY ./nv_boot_control.conf /etc/
# COPY ./nv-oem-config.conf /etc/
# COPY ./nvphsd_common.conf /etc/
# COPY ./nvphsd.conf.t186  /etc/
# COPY ./nv_tegra_release /etc/
# COPY ./nvphsd.conf.t194 /etc/
# COPY /etc/ /etc/
