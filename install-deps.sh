#!/bin/bash

# update
apt update
apt update

# Setup
apt install -y build-essential

apt install software-properties-common -y
apt install -y gpg

# Custom repos
echo 'y' | add-apt-repository -y ppa:deadsnakes/ppa

apt install -y software-properties-common lsb-release wget ca-certificates gnupg
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kitware.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null

# update after custom
apt-get update
apt update

apt-get install -y \
    curl \
    git \
    python3-pip \
    libvlc-dev

apt install -y bash
apt install -y psmisc
apt install -y xz-utils
apt install -y unzip
apt install -y jq
apt install -y wget
apt install -y apt-utils
apt install -y python3.8

apt install -y cmake gcc g++
apt install -y build-essential ninja-build libopenblas-dev
apt install -y libjpeg-dev zlib1g-dev libavcodec-dev libavformat-dev libswscale-dev libopenblas-base
apt install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1

apt-get install -y build-essential cmake ninja-build libopenblas-dev
apt-get install -y libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev python3.8-dev
apt-get install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1 \
        libopenblas-base

apt install -y ffmpeg libpng-dev libpng-tools
apt install curl bzip2 -y
