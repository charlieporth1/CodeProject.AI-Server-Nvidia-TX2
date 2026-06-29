#!/bin/bash
# Py 3.8
cd /opt
wget https://www.python.org/ftp/python/3.8.20/Python-3.8.20.tgz
tar -xzf Python-3.8.20.tgz
cd /opt/Python-3.8.20/
./configure \
        --enable-shared \
        --enable-optimizations \
        --march=native \
        --with-lto \
        --with-ensurepip=install \
        --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make -j$(nproc) altinstall

curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py
curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

exit 0
