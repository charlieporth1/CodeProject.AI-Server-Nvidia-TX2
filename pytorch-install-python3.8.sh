#!/bin/bash
curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

export OPENBLAS_CORETYPE=ARMV8
export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="6.2"
export PYTORCH_BUILD_VERSION="1.11.0"
export PYTORCH_BUILD_NUMBER="1"
export MAX_JOBS=4  # Limits CPU cores used to prevent memory crashes
export USE_MKLDNN=0
export USE_MKL=0
export USE_NNPACK=0
export USE_QNNPACK=0

# https://gemini.google.com/app/8cc1a417fac7f902
# https://gemini.google.com/app/220b370ab2f69811

apt install -y python3.8-venv python3.8-dev


apt-get install -y build-essential cmake ninja-build libopenblas-dev
apt-get install -y libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev python3.8-dev
apt-get install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1 \
        libopenblas-base
apt install -y cmake

curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2

pip install distutils
pip install cmake
pip install setuptools wheel build Cython
pip install --upgrade pip setuptools wheel build

pip install numpy==1.19.5 pandas Cython scikit-build ninja --ignore-installed
pip install numpy==1.19.5 --ignore-installed
# pip install torch==1.8.0 torchvision==0.10.2 torchaudio==0.10.2 --find-links https://download.pytorch.org/whl/cu102/stable.html

# Download the wheel for Python 3.8
wget https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl -O torch-1.10.0-cp38-cp38-linux_aarch64.whl

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export PIP_ROOT_USER_ACTION=ignore

# Install it
pip uninstall torch torchvision torchaudio --yes
pip install torch-1.10.0-cp38-cp38-linux_aarch64.whl --ignore-installed

pip install ultralytics --ignore-installed

update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
# pip.6
# Download the wheel
# wget https://developer.nvidia.com/w/compute/redist/jp/v461/pytorch/torch-1.11.0a0+17540c5+nv22.01-cp36-cp36m-linux_aarch64.whl
# Install it
# pip install torch-1.11.0a0+17540c5+nv22.01-cp36-cp36m-linux_aarch64.whl

# Download the wheel
# wget https://developer.download.nvidia.com/compute/redist/jp/v46/pytorch/torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# Install it
# pip install torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# pip.6
# Download the wheel
# wget https://developer.download.nvidia.com/compute/redist/jp/v46/pytorch/torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# Install it
# pip install torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# pip.6
# Download the wheel
# wget https://developer.download.nvidia.com/compute/redist/jp/v46/pytorch/torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# Install it
# pip install torch-1.10.0-cp36-cp36m-linux_aarch64.whl

