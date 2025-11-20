#!/bin/bash

# hey Smoke Test
# Quick validation (100 requests, 1 concurrent worker)

echo "Running hey Smoke Test..."
echo "Configuration: 100 requests, 1 concurrent worker"
echo "=============================="

echo "Test 1: GET /posts"
hey -n 100 -c 1 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Test 2: GET /users"
hey -n 100 -c 1 https://jsonplaceholder.typicode.com/users

echo ""
echo "Smoke test complete!"
