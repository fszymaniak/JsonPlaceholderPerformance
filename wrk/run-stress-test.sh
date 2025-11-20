#!/bin/bash

# wrk Stress Test
# High load testing (8 threads, 150 connections, 10 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running wrk Stress Test..."
echo "Target: https://jsonplaceholder.typicode.com"
echo "Configuration: 8 threads, 150 connections, 10 minutes"
echo "Script: stress-test.lua"
echo "=============================="

wrk -t8 -c150 -d10m --latency -s "$SCRIPT_DIR/scripts/stress-test.lua" https://jsonplaceholder.typicode.com

echo ""
echo "Stress test complete!"
