#!/bin/bash

# Apache Bench Stress Test
# High load (50,000 requests, 200 concurrent)

echo "Running Apache Bench Stress Test..."
echo "Configuration: 50,000 requests, 200 concurrent"
echo "=============================="

ab -n 50000 -c 200 -k -r -s 30 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Stress test complete!"
