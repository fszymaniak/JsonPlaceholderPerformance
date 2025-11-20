#!/bin/bash

# wrk Soak Test
# Extended duration test (4 threads, 20 connections, 30 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running wrk Soak Test..."
echo "Target: https://jsonplaceholder.typicode.com"
echo "Configuration: 4 threads, 20 connections, 30 minutes"
echo "Script: soak-test.lua"
echo "=============================="
echo "This test will run for 30 minutes. Please be patient..."
echo ""

wrk -t4 -c20 -d30m --latency -s "$SCRIPT_DIR/scripts/soak-test.lua" https://jsonplaceholder.typicode.com

echo ""
echo "Soak test complete!"
