#!/bin/bash

source "$(dirname "$0")/common.sh"

gcloud compute firewall-rules create allow-http \
  --project="$GCLOUD_PROJECT_ID" \
  --allow=tcp:80 \
  --quiet || true

gcloud compute firewall-rules create allow-https \
  --project="$GCLOUD_PROJECT_ID" \
  --allow=tcp:443 \
  --quiet || true
