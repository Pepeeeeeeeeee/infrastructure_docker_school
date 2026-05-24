#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Resetting DuckDNS..."
"$SCRIPT_DIR/reset-duckdns.sh"

echo "Deleting VM..."
"$SCRIPT_DIR/delete-vm.sh"

echo
echo "Infrastructure destroyed!"
