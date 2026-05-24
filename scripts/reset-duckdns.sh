#!/bin/bash

source "$(dirname "$0")/common.sh"

curl "https://www.duckdns.org/update?domains=${DUCKDNS_DOMAINS}&token=${DUCKDNS_TOKEN}&ip=127.0.0.1"

echo
echo "DuckDNS domains reset to 127.0.0.1"
