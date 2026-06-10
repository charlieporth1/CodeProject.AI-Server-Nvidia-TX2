cd pytorch
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
export TORCH_CUDA_ARCH_LIST="6.2"
export USE_NCCL=OFF
export USE_SYSTEM_NCCL=OFF
export USE_OPENCV=OFF
export MAX_JOBS=4
# set path to ccache
export PATH=/usr/lib/ccache:$PATH
# set clang compiler
#export CC=clang
#export CXX=clang++
# set cuda compiler
#export CUDACXX=/usr/local/cuda/bin/nvcc
# create symlink to cublas
sudo ln -s /usr/lib/aarch64-linux-gnu/libcublas.so /usr/local/cuda/lib64/libcublas.so
# clean up the previous build, if necessary
python3 setup.py clean
# start the build
#python3 setup.py bdist_wheel
python3 setup.py instsll
