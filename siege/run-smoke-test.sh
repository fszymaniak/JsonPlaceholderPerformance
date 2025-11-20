#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running Siege Smoke Test..."
echo "Configuration: 1 concurrent user, 30 seconds"
echo "=============================="

siege -c 1 -t 30S -f "$SCRIPT_DIR/urls/get-urls.txt"

echo ""
echo "Smoke test complete!"
