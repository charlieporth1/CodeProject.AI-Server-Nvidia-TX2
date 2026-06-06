#!/bin/bash
# https://gemini.google.com/app/220b370ab2f69811
# Py 3.9 pytorch install
# Set environment variables for the Jetson build
export MAX_JOBS=4
export BUILD_VERSION=0.11.1
export CUDA_HOME=/usr/local/cuda-10.2

pip install setuptools wheel build Cython
pip install --upgrade pip setuptools wheel build

apt-get install -y build-essential cmake ninja-build libopenblas-dev
apt-get install -y libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev python3.8-dev
apt-get install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1 \
        libopenblas-base

# Make sure dir exists
ls $CUDA_HOME

curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.9 1
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.9 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2


pip install setuptools wheel build Cython
pip install --upgrade pip -setuptools wheel build

# Clone the specific version matching PyTorch 1.10.0
wget https://download-r2.pytorch.org/whl/torchvision-0.12.0-cp39-cp39-manylinux2014_aarch64.whl#sha256=b93a767f44e3933cb3b01a6fe9727db54590f57b7dac09d5aaf15966c6c151dd
python3.8 -m pip install *cp38*.whl

cd ..


pip install ultralytics --ignore-installed

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
# Set environment variables for the Jetson build
