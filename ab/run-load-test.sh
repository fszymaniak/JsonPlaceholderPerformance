#!/bin/bash

# Apache Bench Load Test
# Moderate load (10,000 requests, 50 concurrent)

echo "Running Apache Bench Load Test..."
echo "Configuration: 10,000 requests, 50 concurrent"
echo "=============================="

ab -n 10000 -c 50 -k -r https://jsonplaceholder.typicode.com/posts

echo ""
echo "Load test complete!"
