#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute ssh "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --zone="$GCLOUD_ZONE" \
  --command "

if [ ! -d ~/infra-chat/.git ]; then
    git clone --branch $GIT_BRANCH $GIT_REPO ~/infra-chat
else
    cd ~/infra-chat
    git fetch origin
    git checkout $GIT_BRANCH
    git pull origin $GIT_BRANCH
fi
"
