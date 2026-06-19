#!/bin/bash
. /app/runtimes/bin/ubuntu/python38/venv/bin/activate
python3 -c "import torch; print('PyTorch Version:', torch.__version__); print('CUDA Available:', torch.cuda.is_available())"
python3 -c "import torchvision; print('Torchvision Version:', torchvision.__version__); print('CUDA ops successfully loaded!')"
