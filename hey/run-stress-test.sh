#!/bin/bash

# hey Stress Test
# High load (50,000 requests, 200 concurrent)

echo "Running hey Stress Test..."
echo "Configuration: 50,000 requests, 200 concurrent workers"
echo "=============================="

hey -n 50000 -c 200 -t 30 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Stress test complete!"
