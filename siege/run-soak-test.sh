#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running Siege Soak Test..."
echo "Configuration: 20 concurrent users, 30 minutes, 1s delay"
echo "=============================="
echo "This test will run for 30 minutes..."
echo ""

siege -c 20 -t 30M -d1 -f "$SCRIPT_DIR/urls/mixed-urls.txt"

echo ""
echo "Soak test complete!"
