#!/bin/bash
# https://qengineering.eu/install-pytorch-on-jetson-nano.html
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

sudo apt update
sudo apt install -y software-properties-common lsb-release wget ca-certificates gnupg
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kitware.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
sudo apt update
sudo apt install -y cmake

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
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2

pip install distutils
pip install cmake
pip install setuptools wheel build Cython
pip install --upgrade pip setuptools wheel build

pip install numpy==1.19.5 pandas Cython scikit-build ninja --ignore-installed
# pip install torch==1.8.0 torchvision==0.10.2 torchaudio==0.10.2 --find-links https://download.pytorch.org/whl/cu102/stable.html

# Download the wheel for Python 3.8
wget https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl -O torch-1.10.0-cp38-cp38-linux_aarch64.whl

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export PIP_ROOT_USER_ACTION=ignore
# Install it
pip uninstall torch torchvision torchaudio --yes
pip install torch-1.10.0-cp38-cp38-linux_aarch64.whl --ignore-installed


curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py
# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2

python3.9 -m pip install distutils
python3.9 -m pip install setuptools wheel build Cython
python3.9 -m pip install --upgrade pip setuptools wheel build
python3.9 -m pip install cmake cmake3

python3.9 -m pip install numpy==1.19.5 pyyaml setuptools cffi typing_extensions future

git clone --recursive --branch v1.12.0 https://github.com/pytorch/pytorch
cd pytorch
sed -i 's|third_party/breakpad|google/breakpad|g ' .gitmodules
ls third_party/pybind11

git submodule sync
git submodule update --init --recursive --jobs 0
git submodule update --init --recursive --jobs 0
git submodule update --init --recursive
git submodule update --init --recursive

ls third_party/pybind11

#python3.9 setup.py clean
python3.9 setup.py bdist_wheel
python3.9 setup.py install bdist_wheel
python3.9 setup.py install
python3.9 -m pip install dist/*.whl



# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 1
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

