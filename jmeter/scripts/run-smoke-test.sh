#!/bin/bash

# Smoke Test Runner
# Quick validation with minimal load

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p "$PROJECT_DIR/results"

echo "Running Smoke Test..."
jmeter -n \
  -t "$PROJECT_DIR/test-plans/smoke-test.jmx" \
  -l "$PROJECT_DIR/results/smoke-test-results.jtl" \
  -e \
  -o "$PROJECT_DIR/results/smoke-test-report"

echo "Test complete! Report available at: $PROJECT_DIR/results/smoke-test-report/index.html"
