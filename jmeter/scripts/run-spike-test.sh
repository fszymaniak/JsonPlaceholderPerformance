#!/bin/bash

# Spike Test Runner
# Test sudden traffic surges

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p "$PROJECT_DIR/results"

echo "Running Spike Test..."
jmeter -n \
  -t "$PROJECT_DIR/test-plans/spike-test.jmx" \
  -l "$PROJECT_DIR/results/spike-test-results.jtl" \
  -e \
  -o "$PROJECT_DIR/results/spike-test-report"

echo "Test complete! Report available at: $PROJECT_DIR/results/spike-test-report/index.html"
