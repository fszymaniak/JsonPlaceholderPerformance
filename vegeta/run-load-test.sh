#!/bin/bash

# Vegeta Load Test
# Moderate constant load (20 req/s, 5 minutes)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/results"

echo "Running Vegeta Load Test..."
echo "Configuration: 20 req/s, 5 minutes"
echo "Target file: mixed-targets.txt (GET/POST/PUT/DELETE)"
echo "=============================="

vegeta attack \
  -targets="$SCRIPT_DIR/targets/mixed-targets.txt" \
  -rate=20 \
  -duration=5m \
  -timeout=10s \
  | tee "$SCRIPT_DIR/results/load-test-results.bin" \
  | vegeta report

echo ""
echo "Generating HTML report..."
cat "$SCRIPT_DIR/results/load-test-results.bin" | vegeta plot > "$SCRIPT_DIR/results/load-test-report.html"

echo ""
echo "Generating JSON report..."
cat "$SCRIPT_DIR/results/load-test-results.bin" | vegeta report -type=json > "$SCRIPT_DIR/results/load-test-report.json"

echo "HTML report saved to: $SCRIPT_DIR/results/load-test-report.html"
echo "JSON report saved to: $SCRIPT_DIR/results/load-test-report.json"
echo "Load test complete!"
