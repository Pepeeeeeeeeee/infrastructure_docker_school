#!/bin/bash

source "$(dirname "$0")/common.sh"

cd "$ROOT_DIR"

gcloud compute scp \
    --recurse \
    app \
    scripts \
    docker-compose.yml \
    docker-compose.prod.yml \
    .env \
    "$GCLOUD_VM_NAME":~/"$REMOTE_DIR" \
    --project="$GCLOUD_PROJECT_ID" \
    --zone="$GCLOUD_ZONE"
