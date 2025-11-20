#!/bin/bash

# Soak Test Runner
# Extended duration test for memory leaks and degradation

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p "$PROJECT_DIR/results"

echo "Running Soak Test (30 minutes)..."
jmeter -n \
  -t "$PROJECT_DIR/test-plans/soak-test.jmx" \
  -l "$PROJECT_DIR/results/soak-test-results.jtl" \
  -e \
  -o "$PROJECT_DIR/results/soak-test-report"

echo "Test complete! Report available at: $PROJECT_DIR/results/soak-test-report/index.html"
