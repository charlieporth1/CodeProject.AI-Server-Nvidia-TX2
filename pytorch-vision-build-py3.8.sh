#!/bin/bash
# https://gemini.google.com/app/220b370ab2f69811
# Set environment variables for the Jetson build
export MAX_JOBS=4
export BUILD_VERSION=0.11.1
export CUDA_HOME=/usr/local/cuda-10.2

curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2

pip install setuptools wheel build Cython
pip install --upgrade pip setuptools wheel build

apt-get install -y build-essential cmake ninja-build libopenblas-dev
apt-get install -y libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev python3.8-dev
apt-get install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1 \
        libopenblas-base

wget https://download-r2.pytorch.org/whl/torchvision-0.12.0-cp38-cp38-manylinux2014_aarch64.whl#sha256=0744902f2265d4c3e83c44a06b567df312e4a9faf8c92620016c7bed7056b5a7
python3.8 -m pip install *cp38*.whl
# Make sure dir exists
ls $CUDA_HOME

# Build and install
python3 setup.py install
cd ..

pip install ultralytics --ignore-installed

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
# Set environment variables for the Jetson build
