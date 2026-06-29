#!/bin/bash
export EXTRA_CFLAGS="-O3 -march=armv8-a+crypto -mcpu=cortex-a57 -mtune=cortex-a57"
# Py 3.10
cd /opt
wget https://www.python.org/ftp/python/3.10.20/Python-3.10.20.tgz; tar -xzf Python-3.10.20.tgz
cd /opt/Python-3.10.20/
./configure \
	--enable-shared \
	--enable-optimizations \
	--enable-shared \
        --with-system-ffi \
	--with-lto \
	--with-ensurepip=install \
	--prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"
make -j$(nproc) altinstall

curl -s https://bootstrap.pypa.io/pip/3.10/get-pip.py -o get-pip.py
python3.10 get-pip.py
curl -s https://bootstrap.pypa.io/pip/3.10/get-pip.py -o get-pip.py
python3.10 get-pip.py

exit 0
