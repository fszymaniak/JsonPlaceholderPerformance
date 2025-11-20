#!/bin/bash

# Vegeta Soak Test
# Extended duration test (20 req/s, 30 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/results"

echo "Running Vegeta Soak Test..."
echo "Configuration: 20 req/s, 30 minutes"
echo "Target file: mixed-targets.txt"
echo "=============================="
echo "This test will run for 30 minutes. Please be patient..."
echo ""

vegeta attack \
  -targets="$SCRIPT_DIR/targets/mixed-targets.txt" \
  -rate=20 \
  -duration=30m \
  -timeout=10s \
  | tee "$SCRIPT_DIR/results/soak-test-results.bin" \
  | vegeta report

echo ""
echo "Generating reports..."
cat "$SCRIPT_DIR/results/soak-test-results.bin" | vegeta plot > "$SCRIPT_DIR/results/soak-test-report.html"
cat "$SCRIPT_DIR/results/soak-test-results.bin" | vegeta report -type=json > "$SCRIPT_DIR/results/soak-test-report.json"

echo "HTML report saved to: $SCRIPT_DIR/results/soak-test-report.html"
echo "JSON report saved to: $SCRIPT_DIR/results/soak-test-report.json"
echo "Soak test complete!"
