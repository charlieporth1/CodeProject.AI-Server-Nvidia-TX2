# Use NVIDIA's official L4T ML image for JetPack 4.6 (Ubuntu 18.04 + CUDA 10.2)
FROM nvcr.io/nvidia/l4t-ml:r32.7.1-py3

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV RUN_IN_DOCKER=true

# Install system dependencies for CodeProject.AI
RUN apt-get update
RUN apt  update -y

#RUN apt install -y openssl
RUN apt install -y build-essential

RUN apt-get install -y \
    curl \
    git \
    python3-pip \
    libvlc-dev

RUN apt install software-properties-common -y
RUN apt install -y gpg
RUN echo 'y' | add-apt-repository -y ppa:deadsnakes/ppa
#RUN echo -e '\n' | add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update
RUN apt update
RUN apt install -y bash
RUN apt install -y psmisc
RUN apt install -y xz-utils
RUN apt install -y unzip
RUN apt install -y jq
RUN apt install -y wget
RUN apt install -y apt-utils
RUN apt install -y python3.8
# python3.8-pip python3.8-venv python3.8-dev

RUN apt install -y build-essential checkinstall libreadline-gplv2-dev
RUN apt install -y libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev
RUN apt install -y libbz2-dev openssl libffi-dev

RUN cd /opt; wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz; tar -xzf Python-3.9.2.tgz
RUN cd /opt/Python-3.9.2/;  ./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"; make altinstall

RUN cd /opt; wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz; tar -xzf Python-3.10.2.tgz
RUN cd /opt/Python-3.10.2/;  ./configure --enable-shared --enable-optimizations --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"; make altinstall

# python3.9-pip python3.9-venv python3.9-dev
# RUN apt install -y python3.10
# python3.10-pip python3.10-venv python3.10-dev
RUN apt install -y  icu-devtools
RUN curl -sSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
RUN chmod +x dotnet-install.sh
RUN ./dotnet-install.sh --channel 9.0

ENV PATH=$PATH:/root/.dotnet
ENV DOTNET_ROOT=/root/.dotnet


# Set working directory
WORKDIR /app

# Clone CodeProject.AI Server source code
RUN git clone https://github.com/codeproject/CodeProject.AI-Server.git .


RUN apt install -y sudo

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN apt install -y python3.8-venv python3.8-dev

# Install Server dependencies
RUN pip3 install wheel setuptools
RUN pip3 install --upgrade pip
RUN pip3 install -r src/SDK/Python/requirements.txt


# VOLUME /etc/apt/:/etc/apt/
# VOLUME /opt/:/opt/
# VOLUME /usr/include/:/usr/include/
# VOLUME /usr/lib/aarch64-linux-gnu/:/usr/lib/aarch64-linux-gnu/
# VOLUME /usr/include/opencv4/:/usr/include/opencv4/
# VOLUME /usr/lib/:/usr/lib/
# VOLUME /usr/local/cuda/:/usr/local/cuda/
# 1. Install prerequisites for fetching keys and managing repositories
RUN apt-get update && apt-get install -y wget gnupg software-properties-common

# 2. Add the NVIDIA Jetson OTA public GPG key
RUN wget -qO - https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | apt-key add -

# 3. Add the L4T 'common' repository for JetPack 4.6.x
RUN echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

# 4. Add the TX2-specific ('t186') repository
RUN echo "deb https://repo.download.nvidia.com/jetson/t186 r32.7 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

COPY ./nv_boot_control.conf /etc/
COPY ./nv-oem-config.conf /etc/
COPY ./nvphsd_common.conf /etc/
COPY ./nvphsd.conf.t186  /etc/
COPY ./nv_tegra_release /etc/
COPY ./nvphsd.conf.t194 /etc/
# COPY /etc/ /etc/

# 5. Update apt to fetch the newly added NVIDIA packages
RUN apt-get update
RUN apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken --reinstall opencv-licenses=4.1.1-2-gd5a58aa75 --allow-downgrades
RUN apt install -f -y
RUN dpkg --configure -a
RUN apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken nvidia-opencv 
RUN apt install -f -y
RUN dpkg --configure -a

# RUN mkdir -p /proc/device-tree
# RUN echo "nvidia,tegra210" | sudo tee /proc/device-tree/compatible
# 1. Download the package without installing it
RUN apt-get update && apt-get download nvidia-l4t-core

# 2. Unpack the raw .deb file
RUN dpkg-deb -R nvidia-l4t-core_*.deb /tmp/l4t-core-patch

# 3. Patch the preinst script to look for a fake hardware file in /tmp
RUN sed -i 's|/proc/device-tree/compatible|/tmp/compatible|g' /tmp/l4t-core-patch/DEBIAN/preinst

# 4. Create the fake hardware signature for a TX2 (Tegra 186)
RUN echo "nvidia,tegra186" > /tmp/compatible

# 5. Repackage the patched .deb
RUN dpkg-deb -b /tmp/l4t-core-patch /tmp/patched-nvidia-l4t-core.deb

# 6. Install the patched package
RUN yes n | apt-get install -y /tmp/patched-nvidia-l4t-core.deb

RUN apt install -f -y
RUN dpkg --configure -a

RUN yes n | apt install -y -o Dpkg::Options::="--force-overwrite" --fix-broken nvidia-jetpack

RUN apt install -f -y
RUN dpkg --configure -a

# RUN python3.8 -c "import torch._C"
# RUN python3 -c "import torch; print('PyTorch Version:', torch.__version__); print('CUDA Available:', torch.cuda.is_available())"

# https://gemini.google.com/app/220b370ab2f69811

WORKDIR /app/

COPY ./start.sh .

RUN git clone --branch v1.12.0 https://github.com/pytorch/pytorch
WORKDIR /app/pytorch

# RUN sed -i 's|third_party/breakpad|google/breakpad|g ' .gitmodules

RUN git submodule sync
RUN git submodule update --init --recursive --jobs 0 || exit 0
RUN git submodule update --init --recursive || exit 0
RUN git submodule update --init --recursive --jobs 0
RUN git submodule update --init --recursive

WORKDIR /app/
RUN chmod +x *.sh

COPY ./pytorch-install-python3.8.sh .
RUN bash ./pytorch-install-python3.8.sh

COPY ./pytorch-install-python3.9.sh .
RUN chmod +x *.sh

WORKDIR /app/pytorch
RUN git checkout -b v1.12.0

RUN git submodule sync
RUN git submodule update --init --recursive --jobs 0 
RUN git submodule update --init --recursive
RUN git submodule update --init --recursive --jobs 0
RUN git submodule update --init --recursive

RUN bash ./pytorch-install-python3.9.sh

COPY pytorch-vision-build-py3.8.sh .
RUN chmod +x *.sh
RUN bash ./pytorch-vision-build-py3.8.sh

COPY pytorch-vision-build-py3.9.sh .
RUN chmod +x *.sh
RUN bash ./pytorch-vision-build-py3.9.sh

RUN pip3 install ultralytics --ignore-installed
RUN bash src/setup.sh


# Build and publish the .NET server
RUN cd /app/src/server; dotnet publish -c Release -o /app/server

WORKDIR /app/server
# Expose the default CodeProject.AI port
EXPOSE 32168
EXPOSE 5000
ENV ASPNETCORE_URLS="http://+:32168 http://+:5000"
# Start the server
# Use the official server start script as the Entrypoint
# The entrypoint launches the dotnet runtime on the server assembly
ENTRYPOINT ["dotnet", "CodeProject.AI.Server.dll"]

# Use CMD to provide default arguments that can be overridden at runtime
CMD ["--port", "32168"]
