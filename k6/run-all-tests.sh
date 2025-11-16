#!/bin/bash

# k6 Performance Test Suite Runner
# Runs all tests sequentially and saves results

echo "================================================"
echo "  JSONPlaceholder API - k6 Test Suite Runner"
echo "================================================"
echo ""

# Create results directory
RESULTS_DIR="test-results-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$RESULTS_DIR"

echo "Results will be saved to: $RESULTS_DIR"
echo ""

# Test counter
total_tests=5
current_test=0

# Function to run a test
run_test() {
    local test_file=$1
    local test_name=$2
    
    current_test=$((current_test + 1))
    
    echo "[$current_test/$total_tests] Running: $test_name"
    echo "----------------------------------------"
    
    # Run k6 test and save results
    k6 run "$test_file" \
        --out json="$RESULTS_DIR/${test_file%.js}-results.json" \
        --summary-export="$RESULTS_DIR/${test_file%.js}-summary.json"
    
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo "✅ $test_name - PASSED"
    else
        echo "❌ $test_name - FAILED (exit code: $exit_code)"
    fi
    
    echo ""
    echo "Waiting 10 seconds before next test..."
    sleep 10
    echo ""
}

# Run tests in recommended order
echo "Starting test suite execution..."
echo ""

run_test "smoke-test.js" "Smoke Test (Quick Validation)"
run_test "jsonplaceholder-load-test.js" "Load Test (Comprehensive)"
run_test "spike-test.js" "Spike Test (Traffic Bursts)"
run_test "stress-test.js" "Stress Test (Find Limits)"

# Ask user about soak test (it's long)
echo "================================================"
echo "  Soak Test (30+ minutes)"
echo "================================================"
read -p "Do you want to run the Soak Test? It takes ~34 minutes (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    run_test "soak-test.js" "Soak Test (Endurance)"
else
    echo "Skipping Soak Test"
fi

echo ""
echo "================================================"
echo "  Test Suite Complete!"
echo "================================================"
echo ""
echo "Results saved in: $RESULTS_DIR"
echo ""
echo "View individual results:"
echo "  cat $RESULTS_DIR/smoke-test-summary.json"
echo "  cat $RESULTS_DIR/jsonplaceholder-load-test-summary.json"
echo ""
echo "To generate HTML report, consider using k6-reporter:"
echo "  npm install -g k6-to-junit"
echo "  k6-to-junit $RESULTS_DIR/*-results.json"
echo ""
