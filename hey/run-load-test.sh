#!/bin/bash

# hey Load Test
# Moderate load (10,000 requests, 50 concurrent)

echo "Running hey Load Test..."
echo "Configuration: 10,000 requests, 50 concurrent workers"
echo "=============================="

echo "Test: GET /posts"
hey -n 10000 -c 50 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Load test complete!"
