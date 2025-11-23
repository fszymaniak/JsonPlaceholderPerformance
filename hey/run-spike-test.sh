#!/bin/bash

# hey Spike Test
# Sudden traffic (20,000 requests, 500 concurrent)

echo "Running hey Spike Test..."
echo "Configuration: 20,000 requests, 500 concurrent workers"
echo "=============================="

hey -n 20000 -c 500 -t 30 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Spike test complete!"
