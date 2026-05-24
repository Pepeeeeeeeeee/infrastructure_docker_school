#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute ssh "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --zone="$GCLOUD_ZONE" \
  --command '

sudo apt update

sudo apt install -y \
  git \
  ca-certificates \
  curl \
  gnupg

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

mkdir -p ~/infra-chat
mkdir -p ~/infra-chat/logs
mkdir -p ~/infra-chat/letsencrypt

touch ~/infra-chat/letsencrypt/acme.json

chmod 600 ~/infra-chat/letsencrypt/acme.json
'
