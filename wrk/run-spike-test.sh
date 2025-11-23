#!/bin/bash

# wrk Spike Test
# Sudden traffic surge (12 threads, 200 connections, 2 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running wrk Spike Test..."
echo "Target: https://jsonplaceholder.typicode.com"
echo "Configuration: 12 threads, 200 connections, 2 minutes"
echo "Script: spike-test.lua"
echo "=============================="

wrk -t12 -c200 -d2m --latency -s "$SCRIPT_DIR/scripts/spike-test.lua" https://jsonplaceholder.typicode.com

echo ""
echo "Spike test complete!"
