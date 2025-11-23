#!/bin/bash

# wrk Load Test
# Moderate load with multiple endpoints (4 threads, 50 connections, 5 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running wrk Load Test..."
echo "Target: https://jsonplaceholder.typicode.com"
echo "Configuration: 4 threads, 50 connections, 5 minutes"
echo "Script: load-test.lua (tests multiple endpoints)"
echo "=============================="

wrk -t4 -c50 -d5m --latency -s "$SCRIPT_DIR/scripts/load-test.lua" https://jsonplaceholder.typicode.com

echo ""
echo "Load test complete!"
