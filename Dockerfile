# Use NVIDIA's official L4T ML image for JetPack 4.6 (Ubuntu 18.04 + CUDA 10.2)
FROM nvcr.io/nvidia/l4t-ml:r32.7.1-py3 as builder

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV RUN_IN_DOCKER=true
ENV OPENBLAS_CORETYPE=ARMV8
ENV PATH=$PATH:/root/.dotnet
ENV DOTNET_ROOT=/root/.dotnet
ENV ASPNETCORE_URLS="http://+:32168 http://+:5000"


# Set working directory
WORKDIR /app/

RUN apt update
RUN apt update

COPY install-deps.sh .
RUN bash ./install-deps.sh 

RUN apt update
RUN apt update
# python3.8-pip python3.8-venv python3.8-dev

COPY install-python-v3.8.sh .
RUN bash ./install-python-v3.8.sh 

COPY install-python-v3.9.sh .
RUN bash ./install-python-v3.9.sh 

COPY install-python-v3.10.sh .
RUN bash ./install-python-v3.10.sh 

# python3.9-pip python3.9-venv python3.9-dev
# RUN apt install -y python3.10
# python3.10-pip python3.10-venv python3.10-dev
RUN curl -sSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
RUN chmod +x dotnet-install.sh
RUN ./dotnet-install.sh --channel 9.0

# RUN mkdir -p code-project-ai-server
# Clone CodeProject.AI Server source code
RUN git clone https://github.com/codeproject/CodeProject.AI-Server.git code-project-ai-server
RUN cp -rfv code-project-ai-server/* .
RUN cp -rfv code-project-ai-server/.* . || exit 0


RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.8 10
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install Server dependencies
RUN python3.8 -m pip install wheel setuptools
RUN python3.8 -m pip install --upgrade pip
RUN python3.8 -m pip install --upgrade wheel setuptools
RUN python3.8 -m pip install -r src/SDK/Python/requirements.txt

RUN python3.9 -m pip install wheel setuptools
RUN python3.9 -m pip install --upgrade pip
RUN python3.9 -m pip install --upgrade wheel setuptools
RUN python3.9 -m pip install -r src/SDK/Python/requirements.txt


COPY ./nv_boot_control.conf /etc/
COPY ./nv-oem-config.conf /etc/
COPY ./nvphsd_common.conf /etc/
COPY ./nvphsd.conf.t186  /etc/
COPY ./nv_tegra_release /etc/
COPY ./nvphsd.conf.t194 /etc/
# COPY /etc/ /etc/

COPY install-custom-nvidia-repos.sh .
RUN bash ./install-custom-nvidia-repos.sh 

# 5. Update apt to fetch the newly added NVIDIA packages
COPY install-custom-nvidia.sh .
RUN bash ./install-custom-nvidia.sh 
RUN bash ./install-custom-nvidia.sh 

RUN git clone  --branch v1.12.0 https://github.com/pytorch/pytorch
WORKDIR /app/pytorch

RUN git submodule sync
RUN git submodule update --init --recursive --jobs 0 || exit 0
RUN git submodule update --init --recursive || exit 0
RUN git submodule update --init --recursive --jobs 0
RUN git submodule update --init --recursive

WORKDIR /app/

RUN python3.8 -m pip install codeproject_ai_sdk
RUN python3.9 -m pip install codeproject_ai_sdk

RUN bash src/setup.sh || exit 0

COPY ./pytorch-install-python3.8.sh .
RUN bash ./pytorch-install-python3.8.sh

COPY ./pytorch-install-python3.9.sh .
RUN bash ./pytorch-install-python3.9.sh

COPY pytorch-vision-build-py3.8.sh .
RUN bash ./pytorch-vision-build-py3.8.sh

COPY pytorch-vision-build-py3.9.sh .
RUN bash ./pytorch-vision-build-py3.9.sh

COPY install-ultralytics.sh .
RUN bash ./install-ultralytics.sh

COPY reinstall-numpy.sh .
RUN bash ./reinstall-numpy.sh

COPY install-extra-pip.sh .
RUN bash ./install-extra-pip.sh

RUN bash src/setup.sh
RUN bash src/setup.sh --modules FaceProcessing || exit 0
RUN bash src/setup.sh --modules LlamaChat || exit 0
RUN bash src/setup.sh --modules SceneClassifier || exit 0
RUN bash src/setup.sh --modules SuperResolution || exit 0
RUN bash src/setup.sh --modules BackgroundRemover || exit 0
# RUN bash src/setup.sh --modules  || exit 0

# Build and publish the .NET server
RUN cd /app/src/server; dotnet publish -c Release -o /app/server

COPY cuda-test.sh .
COPY numpy-test.sh .
COPY ./start.sh .

WORKDIR /app/server
# Expose the default CodeProject.AI port
EXPOSE 32168
EXPOSE 5000
# Start the server
# Use the official server start script as the Entrypoint
# The entrypoint launches the dotnet runtime on the server assembly
ENTRYPOINT ["bash", "/app/start.sh"]
# ENTRYPOINT ["dotnet", "CodeProject.AI.Server.dll"]

# Use CMD to provide default arguments that can be overridden at runtime
# CMD ["--port", "32168"]
