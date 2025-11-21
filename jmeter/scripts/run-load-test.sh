#!/bin/bash

# Load Test Runner
# Comprehensive API testing with gradual ramp-up

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p "$PROJECT_DIR/results"

echo "Running Load Test..."
jmeter -n \
  -t "$PROJECT_DIR/test-plans/load-test.jmx" \
  -l "$PROJECT_DIR/results/load-test-results.jtl" \
  -e \
  -o "$PROJECT_DIR/results/load-test-report"

echo "Test complete! Report available at: $PROJECT_DIR/results/load-test-report/index.html"
