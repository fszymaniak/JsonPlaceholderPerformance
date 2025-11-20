#!/bin/bash

# hey Soak Test
# Extended duration (30 minutes, 20 concurrent)

echo "Running hey Soak Test..."
echo "Configuration: 30 minutes duration, 20 concurrent workers"
echo "=============================="
echo "This test will run for 30 minutes. Please be patient..."
echo ""

hey -z 30m -c 20 https://jsonplaceholder.typicode.com/posts

echo ""
echo "Soak test complete!"
