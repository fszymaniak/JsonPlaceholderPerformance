#!/bin/bash

# Stress Test Runner
# Push the system to its limits

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p "$PROJECT_DIR/results"

echo "Running Stress Test..."
jmeter -n \
  -t "$PROJECT_DIR/test-plans/stress-test.jmx" \
  -l "$PROJECT_DIR/results/stress-test-results.jtl" \
  -e \
  -o "$PROJECT_DIR/results/stress-test-report"

echo "Test complete! Report available at: $PROJECT_DIR/results/stress-test-report/index.html"
