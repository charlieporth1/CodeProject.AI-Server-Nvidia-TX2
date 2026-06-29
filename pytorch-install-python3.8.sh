#!/bin/bash
# https://qengineering.eu/install-pytorch-on-jetson-nano.html
. /app/runtimes/bin/ubuntu/python38/venv/bin/activate
export CMAKE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DTORCH_CUDA_ARCH_LIST=6.2"
export BUILD_CAFFE2_OPS=OFF
export USE_FBGEMM=OFF
export USE_FAKELOWP=OFF
export BUILD_TEST=OFF
export USE_MKLDNN=OFF
export USE_NNPACK=OFF
export USE_XNNPACK=OFF
export USE_QNNPACK=OFF
export USE_PYTORCH_QNNPACK=OFF
export USE_CUDA=ON
export USE_CUDNN=ON
export USE_NCCL=OFF
export USE_SYSTEM_NCCL=OFF
export USE_OPENCV=OFF
export MAX_JOBS=6
# set path to ccache
export OPENBLAS_CORETYPE=ARMV8
export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export TORCH_CUDA_ARCH_LIST="6.2"
export PYTORCH_BUILD_VERSION="1.12.0"
export PYTORCH_BUILD_NUMBER="1"
export USE_MKLDNN=0
export USE_MKL=0
export USE_NNPACK=0
export USE_QNNPACK=0

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export PIP_ROOT_USER_ACTION=ignore

# https://gemini.google.com/app/8cc1a417fac7f902
# https://gemini.google.com/app/220b370ab2f69811

curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

# Py 3.8 pytorch install
update-alternatives --install /usr/bin/python3 python3  /usr/local/bin/python3.8 10
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.8 1
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2
update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.8 2

python3.8 -m pip uninstall torch torchvision torchaudio --yes

# Install it
python3.8 -m pip install setuptools wheel build Cython
python3.8 -m pip install --upgrade pip setuptools wheel build
python3.8 -m pip install distutils
python3.8 -m pip install numpy==1.19.5 pandas Cython scikit-build ninja future --ignore-installed
python3.8 -m pip install numpy==1.19.5 --ignore-installed
python3.8 -m pip install cmake

cd /app
git clone --recursive --branch v1.12.0 https://github.com/pytorch/pytorch

cd /app/pytorch

sed -i 's|third_party/breakpad|google/breakpad|g ' .gitmodules

git submodule sync
git submodule update --init --recursive --jobs 0
git submodule update --init --recursive

cd /app/pytorch/third_party/ios-cmake
rm -rfv .git
rm -rfv *
rm -rfv .*
find . -delete
git clone https://github.com/leetal/ios-cmake .
git clone https://github.com/leetal/ios-cmake .
git clone https://github.com/leetal/ios-cmake .
git checkout 8abaed637d56f1337d6e1d2c4026e25c1eade724

cd /app/pytorch/third_party/psimd
rm -rfv .git
rm -rfv *
rm -rfv .*
find . -delete
git clone https://github.com/Maratyszcza/psimd .
git clone https://github.com/Maratyszcza/psimd .
git clone https://github.com/Maratyszcza/psimd .
git checkout 072586a71b55b7f8c584153d223e95687148a900

cd /app/pytorch/third_party/QNNPACK
rm -rfv .git
rm -rfv *
rm -rfv .*
find . -delete
git clone https://github.com/pytorch/QNNPACK .
git clone https://github.com/pytorch/QNNPACK .
git clone https://github.com/pytorch/QNNPACK .
git checkout 7d2a4e9931a82adc3814275b6219a0af5fa345b6

cd /app/pytorch/third_party/foxi
rm -rfv .git
rm -rfv *
rm -rfv .*
find . -delete
git clone https://github.com/houseroad/foxi .
git clone https://github.com/houseroad/foxi .
git clone https://github.com/houseroad/foxi .
git checkout c278588e34e535f0bb8f00df3880d26928038cad

cd /app/pytorch/third_party/python-enum
rm -rfv .git
rm -rfv *
rm -rfv .*
find . -delete
git clone https://github.com/PeachPy/enum34.git .
git clone https://github.com/PeachPy/enum34.git .
git clone https://github.com/PeachPy/enum34.git .
git checkout 4cfedc426c4e2fc52e3f5c2b4297e15ed8d6b8c7


cd /app/pytorch
ls third_party/pybind11

sed -i 's|"Manages CMake."|import distutils.version|g' /app/pytorch/tools/setup_helpers/cmake.py
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
python3.8 setup.py clean
python3.8 setup.py build
python3.8 setup.py bdist_wheel
python3.8 setup.py install bdist_wheel
python3.8 setup.py install
python3.8 -m pip install dist/*.whl
python3.8 -m pip install build/*.whl
cp -rfv /app/pytorch/dist/*.whl /app/


# Py 3.8 pytorch install
update-alternatives --install /usr/bin/python3 python3  /usr/local/bin/python3.8 10
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

