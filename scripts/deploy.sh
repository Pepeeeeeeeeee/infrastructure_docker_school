#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/common.sh"

MODE="${1:-$DEPLOY_MODE}"

echo "Deployment mode: $MODE"

echo "Creating VM..."
"$SCRIPT_DIR/create-vm.sh"

echo "Ensuring firewall rules exist..."
"$SCRIPT_DIR/create-firewall.sh"

echo "Waiting for VM provisioning..."
sleep 30

echo "Updating DuckDNS..."
"$SCRIPT_DIR/update-duckdns.sh"

echo "Waiting for DNS propagation..."
"$SCRIPT_DIR/wait-for-dns.sh"

echo "Setting up VM..."
"$SCRIPT_DIR/setup-vm.sh"

case "$MODE" in

    git)
        echo "Deploying via Git..."
        "$SCRIPT_DIR/deploy-git.sh"
        ;;

    scp)
        echo "Deploying via SCP..."
        "$SCRIPT_DIR/deploy-scp.sh"
        ;;

    *)
        echo "Unknown deploy mode: $MODE"
        echo "Valid values: git | scp"
        exit 1
        ;;
esac

echo "Starting application..."
"$SCRIPT_DIR/start-app.sh"

echo
echo "Deployment complete!"
