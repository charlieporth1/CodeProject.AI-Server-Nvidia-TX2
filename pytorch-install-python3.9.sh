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


git clone --recursive --branch v1.12.0 https://github.com/pytorch/pytorch
cd pytorch

sed -i 's|third_party/breakpad|google/breakpad|g ' .gitmodules

#git submodule sync
# git submodule update --init --recursive --jobs 0
# git submodule update --init --recursive
cd /app/pytorch/third_party/ios-cmake
rm .git
rm *
git clone https://github.com/leetal/ios-cmake .
git clone https://github.com/leetal/ios-cmake .
git clone https://github.com/leetal/ios-cmake .
git checkout 8abaed637d56f1337d6e1d2c4026e25c1eade724

cd /app/pytorch/third_party/psimd
rm .git
rm *
git clone https://github.com/Maratyszcza/psimd .
git clone https://github.com/Maratyszcza/psimd .
git clone https://github.com/Maratyszcza/psimd .
git checkout 072586a71b55b7f8c584153d223e95687148a900

cd /app/pytorch/third_party/QNNPACK
rm .git
rm *
git clone https://github.com/pytorch/QNNPACK .
git clone https://github.com/pytorch/QNNPACK .
git clone https://github.com/pytorch/QNNPACK .
git checkout 7d2a4e9931a82adc3814275b6219a0af5fa345b6

cd /app/pytorch/third_party/foxi
rm .git
rm *
git clone https://github.com/houseroad/foxi .
git clone https://github.com/houseroad/foxi .
git clone https://github.com/houseroad/foxi .
git checkout c278588e34e535f0bb8f00df3880d26928038cad

touch d

cd /app/pytorch
ls third_party/pybind11

sed -i 's|"Manages CMake."|import distutils.version|g' /app/pytorch/tools/setup_helpers/cmake.py
# sed -i 's|cmake_minimum_required\(VERSION 3.1.3)|cmake_minimum_required\(VERSION 3.5)|g' third_party/protobuf/cmake/CMakeLists.txt
# sed -i 's|CMAKE_MINIMUM_REQUIRED\(VERSION 3.1|CMAKE_MINIMUM_REQUIRED\(VERSION 3.5|g' third_party/cpuinfo/deps/clog/CMakeLists.txt
# sed -i 's|CMAKE_MINIMUM_REQUIRED\(VERSION 2.8.12|CMAKE_MINIMUM_REQUIRED\(VERSION 3.5|g' third_party/FP16/CMakeLists.txt
# sed -i 's|CMAKE_MINIMUM_REQUIRED\(VERSION 2.8.12|CMAKE_MINIMUM_REQUIRED\(VERSION 3.5|g' third_party/psimd/CMakeLists.txt
# sed -i 's|cmake_minimum_required\(VERSION 2.8.12|cmake_minimum_required\(VERSION 3.5|g' third_party/googletest/CMakeLists.txt
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_minimum_required\(VERSION [0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_minimum_required\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_minimum_required\(VERSION 3.5/g' X

find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X
find . -iname CMakeLists.txt | xargs -IX sed -i -E 's/cmake_policy\(VERSION [0-9]+\.[0-9]+\.[0-9]+/cmake_policy\(VERSION 3.5/g' X

#python3.8 -c "import numpy"
#python3.8 -v setup.py --help
python3.9 setup.py clean
# python3.8 etup.py bdist_wheel
# python3.8 setup.py install bdist_wheel
python3.9 setup.py build
python3.9 setup.py install
python3.9 -m pip install dist/*.whl
python3.9 -m pip install build/*.whl



# pip install ultralytics --ignore-installed

# Py 3.9 pytorch install
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2

exit 0

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

