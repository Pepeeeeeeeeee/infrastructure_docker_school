#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute instances delete "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --zone="$GCLOUD_ZONE" \
  --quiet
