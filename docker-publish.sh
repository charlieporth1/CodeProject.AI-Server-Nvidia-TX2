#!/bin/bash
sudo mount /dev/disk/by-id/usb-MZ7LH480_HBHQ0D3_20211019-0\:0-part2 /mnt/USB
sudo swapon -a
sudo swapon /mnt/USB/swapfile
sudo systemctl start docker docker.socket
bash /home/ubuntu/private/discord_build_alert.sh "AI Docker Publish on started"
# docker login
tag=${1:-v0.1}
docker tag codeproject-ai-tx2 otihoith/codeproject-ai-tx2:$tag
docker push otihoith/codeproject-ai-tx2:$tag

bash /home/ubuntu/private/discord_build_alert.sh "AI Docker Publish finshed; ec $?"
