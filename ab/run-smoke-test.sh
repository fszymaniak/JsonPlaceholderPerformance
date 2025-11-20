#!/bin/bash

# Apache Bench Smoke Test
# Quick validation (100 requests, 1 concurrent)

echo "Running Apache Bench Smoke Test..."
echo "Configuration: 100 requests, 1 concurrent"
echo "=============================="

echo "Test: GET /posts"
ab -n 100 -c 1 -k https://jsonplaceholder.typicode.com/posts

echo ""
echo "Smoke test complete!"
