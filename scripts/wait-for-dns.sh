#!/bin/bash

set -e

source "$(dirname "$0")/common.sh"

EXPECTED_IP=$("$(dirname "$0")/get-vm-ip.sh")

TIMEOUT=300
INTERVAL=10
ELAPSED=0

DOMAINS=(
    "$CHAT_DOMAIN"
    "$KUMA_DOMAIN"
)

echo "Waiting for DNS propagation..."
echo "Expected IP: $EXPECTED_IP"

while true
do

    ALL_OK=true

    for DOMAIN in "${DOMAINS[@]}"
    do

        CURRENT_IP=$(dig +short "$DOMAIN" | tail -n1)

        echo "$DOMAIN -> ${CURRENT_IP:-<none>}"

        if [ "$CURRENT_IP" != "$EXPECTED_IP" ]; then
            ALL_OK=false
        fi

    done

    if [ "$ALL_OK" = true ]; then
        echo "DNS propagation complete."
        exit 0
    fi

    if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
        echo "DNS propagation timeout."
        exit 1
    fi

    sleep "$INTERVAL"

    ELAPSED=$((ELAPSED + INTERVAL))

done
