sudo apt-get update
sudo apt-get install curl
curl -fsSL https://get.docker.com | sh && sudo systemctl --now enable docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
sudo docker run --name gpurunner-recsys-project --restart always -d --gpus all -e RUNNER_LABELS=cml,gpu -e RUNNER_REPO="https://github.com/sirius-tinkoff-recsys-team/recsys-project" -e repo_token="$REPO_TOKEN" dvcorg/cml-py3
