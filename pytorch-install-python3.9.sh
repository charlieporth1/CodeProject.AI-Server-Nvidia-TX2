#!/bin/bash
export CMAKE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DTORCH_CUDA_ARCH_LIST=6.2"

export OPENBLAS_CORETYPE=ARMV8
export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="6.2"
export PYTORCH_BUILD_VERSION="1.11.0"
export PYTORCH_BUILD_NUMBER="1"
export MAX_JOBS=6  # Limits CPU cores used to prevent memory crashes
export USE_MKLDNN=0
export USE_MKL=0
export USE_NNPACK=0
export USE_QNNPACK=0

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export PIP_ROOT_USER_ACTION=ignore


# https://gemini.google.com/app/8cc1a417fac7f902
# https://gemini.google.com/app/220b370ab2f69811

curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.9 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2

apt install -y software-properties-common lsb-release wget ca-certificates gnupg
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kitware.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null

apt update
apt install -y cmake gcc g++
apt install -y build-essential ninja-build libopenblas-dev
apt install -y libjpeg-dev zlib1g-dev libavcodec-dev libavformat-dev libswscale-dev libopenblas-base
apt install -y libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev zlib1g-dev libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1

python3.9 -m pip uninstall torch torchvision torchaudio --yes

# Install it
python3.9 -m pip install setuptools wheel build Cython
python3.9 -m pip install --upgrade pip setuptools wheel build
python3.9 -m pip install distutils
python3.9 -m pip install numpy==1.19.5 pandas Cython scikit-build ninja future --ignore-installed
python3.9 -m pip install numpy==1.19.5 --ignore-installed
# python3.9 -m pip install cmake


wget https://download-r2.pytorch.org/whl/torch-1.11.0-cp39-cp39-manylinux2014_aarch64.whl#sha256=831cf588f01dda9409e75576741d2823453990dee2983d670f2584b37a01adf7

python3.9 -m pip install *39*.whl


# pip install ultralytics --ignore-installed

# Py 3.9 pytorch install
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

