strings /usr/lib/aarch64-linux-gnu/libstdc++.so.6 | grep GLIBCXX_3

yes | sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
apt-get install --only-upgrade libstdc++6

strings /usr/lib/aarch64-linux-gnu/libstdc++.so.6 | grep GLIBCXX_3.4.26
