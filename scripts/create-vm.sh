#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute instances create "$GCLOUD_VM_NAME" \
  --project="$GCLOUD_PROJECT_ID" \
  --machine-type="$GCLOUD_MACHINE_TYPE" \
  --image-family="$GCLOUD_IMAGE_FAMILY" \
  --image-project="$GCLOUD_IMAGE_PROJECT" \
  --zone="$GCLOUD_ZONE"
