#!/bin/bash

# Apache Bench Spike Test
# Sudden traffic (20,000 requests, 500 concurrent)

echo "Running Apache Bench Spike Test..."
echo "Configuration: 20,000 requests, 500 concurrent"
echo "=============================="

ab -n 20000 -c 500 -k -r -s 30 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Spike test complete!"
