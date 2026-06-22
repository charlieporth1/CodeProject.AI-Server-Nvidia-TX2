#!/bin/bash
# Py 3.9
cd /opt
wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
tar -xzf Python-3.9.2.tgz
cd /opt/Python-3.9.2/
./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make altinstall

# Py 3.10
cd /opt
wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz; tar -xzf Python-3.10.2.tgz
cd /opt/Python-3.10.2/
./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make altinstall
