#!/bin/bash

# Apache Bench Soak Test
# Extended duration (30 minutes with continuous testing)

echo "Running Apache Bench Soak Test..."
echo "Configuration: 30 minutes, 20 concurrent, continuous"
echo "=============================="
echo "Running continuous tests for 30 minutes..."

# Calculate end time (30 minutes from now)
END_TIME=$(($(date +%s) + 1800))

while [ $(date +%s) -lt $END_TIME ]; do
  echo "Running test batch at $(date +%H:%M:%S)..."
  ab -n 1000 -c 20 -k -q https://jsonplaceholder.typicode.com/posts > /dev/null 2>&1
  sleep 5
done

echo ""
echo "Soak test complete!"
echo "Ran continuous tests for 30 minutes"
