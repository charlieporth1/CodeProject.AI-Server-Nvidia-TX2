#!/bin/bash
. /app/runtimes/bin/ubuntu/python39/venv/bin/activate

# 1. Dynamically grab Python paths from your active virtual environment
export PYTHON_BIN_PATH=$(which python3)
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"

# 2. Hardware and GPU Acceleration (Jetson TX2 specifics)
export TF_NEED_CUDA=1
export TF_CUDA_VERSION="10.2"
export TF_CUDA_COMPUTE_CAPABILITIES="6.2" # Architecture for TX2
export TF_NEED_TENSORRT=1
export TF_CUDA_CLANG=0
export TF_NEED_ROCM=0

# NOTE: Verify these two versions on your system first.
# You can check them using:
# dpkg -l | grep cudnn  AND  dpkg -l | grep tensorrt
export TF_CUDNN_VERSION="8.3"
export TF_TENSORRT_VERSION="7.1"

# 3. Compiler settings
export GCC_HOST_COMPILER_PATH="/usr/bin/gcc"
export CC_OPT_FLAGS="-Wno-sign-compare"

# 4. Disable unnecessary modules to skip their prompts
export TF_NEED_MPI=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_NEED_OPENCL_SYCL=0
export TF_DOWNLOAD_CLANG=0
export TF_NEED_IGNITE=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_NEED_S3=0
export TF_NEED_KAFKA=0


apt-get update
apt-get update
apt-get install -y openjdk-8-jdk pkg-config zip g++ zlib1g-dev unzip
apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
pip install -U pip six numpy==1.19.5 wheel setuptools mock
pip install testresources future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8
pip install gast==0.2.2 futures protobuf pybind11

wget https://github.com/bazelbuild/bazel/releases/download/3.1.0/bazel-3.1.0-linux-arm64
chmod +x bazel-3.1.0-linux-arm64
sudo mv bazel-3.1.0-linux-arm64 /usr/local/bin/bazel

git clone --depth 1 --branch v2.4.1 https://github.com/tensorflow/tensorflow.git
cd tensorflow
./configure

bazel build --config=opt \
            --config=cuda \
            --config=nonccl \
            --local_ram_resources=8192 \
            --local_cpu_resources=6 \
            //tensorflow/tools/pip_package:build_pip_package


./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
pip install /tmp/tensorflow_pkg/tensorflow*.whl
cp -rfv /tmp/tensorflow_pkg/tensorflow*.whl /app/
