#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running Siege Spike Test..."
echo "Configuration: 500 concurrent users, 2 minutes, benchmark mode"
echo "=============================="

siege -c 500 -t 2M -b -f "$SCRIPT_DIR/urls/get-urls.txt"

echo ""
echo "Spike test complete!"
