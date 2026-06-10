sudo apt-get update
sudo apt-get upgrade
# the dependencies
sudo apt-get install ninja-build git cmake
sudo apt-get install libjpeg-dev libopenmpi-dev libomp-dev ccache
sudo apt-get install libopenblas-dev libblas-dev libeigen3-dev
sudo pip3 install -U --user wheel mock pillow
sudo -H pip3 install testresources
# above 58.3.0 you get version issues
sudo -H pip3 install setuptools==58.3.0
sudo -H pip3 install scikit-build
# download PyTorch 1.10.0 with all its libraries
git clone -b v1.10.0 --depth=1 --recursive https://github.com/pytorch/pytorch.git
cd pytorch
# one command to install several dependencies in one go
# installs future, numpy, pyyaml, requests
# setuptools, six, typing_extensions, dataclasses
sudo pip3 install -r requirements.txt
