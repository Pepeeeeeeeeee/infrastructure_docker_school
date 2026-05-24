#!/bin/bash

source "$(dirname "$0")/common.sh"

IP=$("$(dirname "$0")/get-vm-ip.sh")

curl "https://www.duckdns.org/update?domains=${DUCKDNS_DOMAINS}&token=${DUCKDNS_TOKEN}&ip=${IP}"

echo
echo "DuckDNS domains updated to: $IP"
