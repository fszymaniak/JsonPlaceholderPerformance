#!/bin/bash

# Vegeta Smoke Test
# Quick validation with minimal load (1 req/s, 30s)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/results"

echo "Running Vegeta Smoke Test..."
echo "Configuration: 1 req/s, 30 seconds"
echo "=============================="

vegeta attack \
  -targets="$SCRIPT_DIR/targets/get-targets.txt" \
  -rate=1 \
  -duration=30s \
  -timeout=10s \
  | tee "$SCRIPT_DIR/results/smoke-test-results.bin" \
  | vegeta report

echo ""
echo "Generating HTML report..."
cat "$SCRIPT_DIR/results/smoke-test-results.bin" | vegeta plot > "$SCRIPT_DIR/results/smoke-test-report.html"

echo "HTML report saved to: $SCRIPT_DIR/results/smoke-test-report.html"
echo "Smoke test complete!"
