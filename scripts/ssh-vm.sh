#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute ssh "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --zone="$GCLOUD_ZONE"
