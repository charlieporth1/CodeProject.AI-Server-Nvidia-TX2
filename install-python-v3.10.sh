#!/bin/bash
curl -s https://bootstrap.pypa.io/pip/3.8/get-pip.py -o get-pip.py
python3.8 get-pip.py

# Py 3.10
cd /opt
wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz; tar -xzf Python-3.10.2.tgz
cd /opt/Python-3.10.2/
./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make altinstall

curl -s https://bootstrap.pypa.io/pip/3.10/get-pip.py -o get-pip.py
python3.10 get-pip.py
