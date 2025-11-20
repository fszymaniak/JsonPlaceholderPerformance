#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running Siege Load Test..."
echo "Configuration: 50 concurrent users, 5 minutes, internet mode"
echo "=============================="

siege -c 50 -t 5M -i -f "$SCRIPT_DIR/urls/mixed-urls.txt"

echo ""
echo "Load test complete!"
