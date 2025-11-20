#!/bin/bash

# Vegeta Stress Test
# High constant load (100 req/s, 10 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/results"

echo "Running Vegeta Stress Test..."
echo "Configuration: 100 req/s, 10 minutes"
echo "Target file: mixed-targets.txt"
echo "=============================="

vegeta attack \
  -targets="$SCRIPT_DIR/targets/mixed-targets.txt" \
  -rate=100 \
  -duration=10m \
  -timeout=10s \
  -workers=50 \
  | tee "$SCRIPT_DIR/results/stress-test-results.bin" \
  | vegeta report

echo ""
echo "Generating reports..."
cat "$SCRIPT_DIR/results/stress-test-results.bin" | vegeta plot > "$SCRIPT_DIR/results/stress-test-report.html"
cat "$SCRIPT_DIR/results/stress-test-results.bin" | vegeta report -type=json > "$SCRIPT_DIR/results/stress-test-report.json"

echo "HTML report saved to: $SCRIPT_DIR/results/stress-test-report.html"
echo "JSON report saved to: $SCRIPT_DIR/results/stress-test-report.json"
echo "Stress test complete!"
