sudo apt update
sudo apt install cmake libncurses5-dev libncursesw5-dev git -y

git clone https://github.com/Syllo/nvtop.git
cd nvtop

mkdir build
cd build
cmake ..
make
sudo make install
