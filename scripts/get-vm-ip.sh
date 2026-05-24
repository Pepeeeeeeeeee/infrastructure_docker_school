#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute instances describe "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --zone="$GCLOUD_ZONE" \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)'
