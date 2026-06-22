#!/binn/bash
# docker login
tag=${1:-v0.1}
docker tag codeproject-ai-tx2 otihoith/codeproject-ai-tx2:$tag
docker push otihoith/codeproject-ai-tx2:$tag
