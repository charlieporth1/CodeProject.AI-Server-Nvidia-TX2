#!/bin/bash
curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

# Py 3.9
cd /opt
wget https://www.python.org/ftp/python/3.9.25/Python-3.9.25.tgz
tar -xzf Python-3.9.25.tgz
cd /opt/Python-3.9.25/
./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make -j$(nproc) altinstall

curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py
curl -s https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3.9 get-pip.py

exit 0
