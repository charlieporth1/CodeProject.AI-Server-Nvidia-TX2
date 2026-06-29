#!/bin/bash
# https://qengineering.eu/install-pytorch-on-jetson-nano.html
# https://gemini.google.com/app/220b370ab2f69811
# Py 3.9 pytorch install
# Set environment variables for the Jetson build
. /app/runtimes/bin/ubuntu/python39/venv/bin/activate
export MAX_JOBS=6
export BUILD_VERSION=0.13.0
export CMAKE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DTORCH_CUDA_ARCH_LIST=6.2"

export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Force CUDA compilation
export FORCE_CUDA=1

export OPENBLAS_CORETYPE=ARMV8
export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="6.2"
#export PYTORCH_BUILD_VERSION="1.11.0"
export PYTORCH_BUILD_NUMBER="1"
export MAX_JOBS=6  # Limits CPU cores used to prevent memory crashes
export USE_MKLDNN=0
export USE_MKL=0
export USE_NNPACK=0
export USE_QNNPACK=0

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export PIP_ROOT_USER_ACTION=ignore


#touch d
curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.9 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.9 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2

if ! command -v conda; then
	# 1. Download the ARM64 (aarch64) installer
	wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh

	# 2. Run the installation script
	yes yes | bash Miniforge3-Linux-aarch64.sh
fi

conda update -n base -c defaults conda

# Make sure dir exists
ls $CUDA_HOME


python3.9 -m pip install setuptools wheel build Cython
python3.9 -m pip install --upgrade pip -setuptools wheel build

# Clone the specific version matching PyTorch 1.10.0
#wget https://download-r2.pytorch.org/whl/torchvision-0.12.0-cp39-cp39-manylinux2014_aarch64.whl#sha256=b93a767f44e3933cb3b01a6fe9727db54590f57b7dac09d5aaf15966c6c151dd
#python3.8 -m python3.9 -m pip install *cp38*.whl

# Clone the specific version matching PyTorch 1.10.0
git clone --branch v0.13.0 https://github.com/pytorch/vision torchvision
git clone --branch v0.13.0 https://github.com/pytorch/vision torchvision
git clone --branch v0.13.0 https://github.com/pytorch/vision torchvision
git clone --branch v0.13.0 https://github.com/pytorch/vision torchvision
cd torchvision

# git checkout v0.13.0

git submodule sync
git submodule update --init --recursive --jobs 0
git submodule update --init --recursive --jobs 0
git submodule update --init --recursive
git submodule update --init --recursive

sed -i '1s/^/#include <ATen\/Dispatch.h>\n/' /app/torchvision/torchvision/csrc/ops/cpu/interpolate_aa_kernels.cpp
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_minimum_required\(VERSION [0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_minimum_required\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X

find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X

python3.8 -m pip install -r requirements.txt
python3.8 -m pip install -r ./docs/requirements.txt

#python3.9 -c "import numpy"
#python3.9 -v setup.py --help
python3.9 setup.py clean

# Build and install
python3.9 setup.py clean
python3.9 setup.py build
python3.9 setup.py bdist_wheel
python3.9 setup.py install
python3.9 setup.py install bdist_wheel
python3.9 -m pip install dist/*.whl
python3.9 -m pip install build/*.whl
cp -rfv /app/torchvision/dist/*.whl /app
cd ..

# python3.9 -m pip install ultralytics --no-deps

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3  /usr/local/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3.8 2
update-alternatives --install /usr/local/bin/pip pip pip3.8 2
# Set environment variables for the Jetson build

exit 0
