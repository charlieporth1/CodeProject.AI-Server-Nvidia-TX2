# CodeProject.AI-Server optimized for Nvidia TX2s
This project is to run [CodeProject.AI-Server](https://github.com/codeproject/CodeProject.AI-Server) on TX2 powerful GPU rather than the CPU
Since CodeProject.AI-Server doesn't support CUDA 10.2 the default CodeProject.AI-Server code only runs on the CPU
Running on the CPU has an latency for the avg AI request to run anywhere between 60,000ms to 120,000ms
Running on CUDA 10.2 and on the GPU allows for a ~750% reduction in processing time at anywhere from 25ms to 210ms. On unoptimized version of python in my POC
Running on the GPU also reduces the CPU load massively. With a CPU image the CPU is in almost constant 100% usage with the GPU image the CPU is at 25% usage
This also reduces your engery usage massively

This project compiles
pytorch
pytorchvision
python3.8
python3.9
python3.10

to run optmized versions on the TX2

This project will recive further updates from me with plans to make more optimized versions

Planned updates.
Optimized python3.8 versions
Tensorflow
Other AI modules



## RUN
`sudo docker pull otihoith/codeproject-ai-tx2:v0.1`

## Image URL
[codeproject-ai-tx2](https://hub.docker.com/r/otihoith/codeproject-ai-tx2)
