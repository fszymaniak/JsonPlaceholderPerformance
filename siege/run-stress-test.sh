#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running Siege Stress Test..."
echo "Configuration: 200 concurrent users, 10 minutes, benchmark mode"
echo "=============================="

siege -c 200 -t 10M -b -f "$SCRIPT_DIR/urls/get-urls.txt"

echo ""
echo "Stress test complete!"
