#!/bin/bash

# wrk Smoke Test
# Quick validation with minimal load (1 thread, 2 connections, 30s)

echo "Running wrk Smoke Test..."
echo "Target: https://jsonplaceholder.typicode.com/posts"
echo "Configuration: 1 thread, 2 connections, 30 seconds"
echo "=============================="

wrk -t1 -c2 -d30s --latency https://jsonplaceholder.typicode.com/posts

echo ""
echo "Smoke test complete!"
