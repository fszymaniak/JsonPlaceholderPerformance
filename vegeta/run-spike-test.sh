#!/bin/bash

# Vegeta Spike Test
# Sudden traffic surge (200 req/s, 2 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/results"

echo "Running Vegeta Spike Test..."
echo "Configuration: 200 req/s, 2 minutes"
echo "Target file: get-targets.txt"
echo "=============================="

vegeta attack \
  -targets="$SCRIPT_DIR/targets/get-targets.txt" \
  -rate=200 \
  -duration=2m \
  -timeout=10s \
  -workers=100 \
  | tee "$SCRIPT_DIR/results/spike-test-results.bin" \
  | vegeta report

echo ""
echo "Generating reports..."
cat "$SCRIPT_DIR/results/spike-test-results.bin" | vegeta plot > "$SCRIPT_DIR/results/spike-test-report.html"
cat "$SCRIPT_DIR/results/spike-test-results.bin" | vegeta report -type=json > "$SCRIPT_DIR/results/spike-test-report.json"

echo "HTML report saved to: $SCRIPT_DIR/results/spike-test-report.html"
echo "JSON report saved to: $SCRIPT_DIR/results/spike-test-report.json"
echo "Spike test complete!"
