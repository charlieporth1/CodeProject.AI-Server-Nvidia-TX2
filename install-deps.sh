#!/bin/bash

#!/bin/bash

# Ensure script exits if any command fails
set -e
curl http://ports.ubuntu.com/ubuntu-ports

# 1. Initial Update
apt update
apt update

# 2. Prerequisites for adding custom repositories
apt install -y apt-utils
apt install -y ca-certificates
apt install -y curl
apt install -y gnupg
apt install -y gpg
apt install -y lsb-release
apt install -y software-properties-common
apt install -y wget

# 3. Add Custom Repositories
# DeadSnakes PPA
echo 'y' | add-apt-repository -y ppa:deadsnakes/ppa

# Kitware Repo
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kitware.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null

curl http://ports.ubuntu.com/ubuntu-ports
# 4. Update after adding custom repositories
apt update
apt update

# 5. Separate package installations
apt install -y bash
apt install -y build-essential
apt install -y bzip2
apt install -y checkinstall
apt install -y cmake
apt install -y ffmpeg
apt install -y g++
apt install -y gcc
apt install -y git
apt install -y icu-devtools
apt install -y jq
apt install -y libc6-dev
apt install -y libffi-dev
apt install -y libgdbm-dev
apt install -y libglib2.0-0
apt install -y libgomp1
apt install -y libjpeg-dev
apt install -y libncursesw5-dev
apt install -y libomp-dev
apt install -y libopenblas-base
apt install -y libopenblas-dev
apt install -y libopenmpi-dev
apt install -y libpng-dev
apt install -y libpng-tools
apt install -y libpython3-dev
apt install -y libreadline-gplv2-dev
apt install -y libsm6
apt install -y libsqlite3-dev
apt install -y libssl-dev
apt install -y libvlc-dev
apt install -y libxext6
apt install -y libxrender-dev
apt install -y ninja-build
apt install -y openssl
apt install -y psmisc
apt install -y python3-pip
apt install -y python3.8
apt install -y python3.8-dev
apt install -y python3.8-venv
apt install -y sudo
apt install -y tk-dev
apt install -y unzip
apt install -y xz-utils
apt install -y zlib1g-dev
apt install -y libavcodec-dev
apt install -y libavformat-dev
apt install -y libavutil-dev
apt install -y libswscale-dev
apt install -y libbz2-dev
