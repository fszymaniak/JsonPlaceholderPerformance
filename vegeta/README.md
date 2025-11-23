# Vegeta Performance Tests

This folder contains Vegeta performance tests for the JSONPlaceholder API. Vegeta is a versatile HTTP load testing tool written in Go, designed for constant throughput testing.

## Prerequisites

- [Vegeta](https://github.com/tsenart/vegeta) installed
- For installation:
  ```bash
  # macOS
  brew install vegeta

  # Linux (download binary)
  wget https://github.com/tsenart/vegeta/releases/latest/download/vegeta_linux_amd64.tar.gz
  tar xzf vegeta_linux_amd64.tar.gz
  sudo mv vegeta /usr/local/bin/

  # Or build from source (requires Go)
  go install github.com/tsenart/vegeta@latest
  ```

## Running Tests

Vegeta uses target files to define HTTP requests and command-line options for load configuration.

### Basic Usage

```bash
vegeta attack -targets=targets.txt -rate=50 -duration=30s | vegeta report
```

### Test Scenarios

#### Smoke Test
Quick validation with minimal load (1 req/s, 30s):
```bash
./run-smoke-test.sh
```

Output: Console report + HTML report at `results/smoke-test-report.html`

#### Load Test
Moderate constant load (20 req/s, 5min):
```bash
./run-load-test.sh
```

Output: Console report + HTML report at `results/load-test-report.html`

#### Stress Test
High constant load (100 req/s, 10min):
```bash
./run-stress-test.sh
```

Output: Console report + HTML report at `results/stress-test-report.html`

#### Spike Test
Sudden traffic surge (200 req/s, 2min):
```bash
./run-spike-test.sh
```

Output: Console report + HTML report at `results/spike-test-report.html`

#### Soak Test
Extended duration (20 req/s, 30min):
```bash
./run-soak-test.sh
```

Output: Console report + HTML report at `results/soak-test-report.html`

### POST Request Test

```bash
vegeta attack -targets=targets/post-targets.txt -rate=10 -duration=30s | vegeta report
```

## Test Files

- `targets/get-targets.txt` - GET request targets
- `targets/mixed-targets.txt` - Mixed GET/POST/PUT/DELETE requests
- `targets/post-targets.txt` - POST request targets
- `run-*.sh` - Convenience scripts for each test scenario

## Project Structure

```
vegeta/
├── targets/                   # Target definition files
│   ├── get-targets.txt
│   ├── mixed-targets.txt
│   └── post-targets.txt
├── run-smoke-test.sh         # Smoke test runner
├── run-load-test.sh          # Load test runner
├── run-stress-test.sh        # Stress test runner
├── run-spike-test.sh         # Spike test runner
├── run-soak-test.sh          # Soak test runner
├── results/                   # Test results (generated)
└── README.md                  # This file
```

## Vegeta Benefits

- Constant request rate (crucial for accurate testing)
- Excellent reporting (text, JSON, HTML, histograms)
- HTTP/2 support
- Custom headers and bodies
- Target file format for complex scenarios
- Can be used as a library in Go programs
- Percentile latency calculations
- Easy integration with monitoring systems

## Command Line Options

Attack command:
- `-targets` - File with request targets
- `-rate` - Requests per second (e.g., 50, 50/1s, 0 for max)
- `-duration` - Test duration (e.g., 30s, 5m, 1h)
- `-timeout` - Request timeout (default: 30s)
- `-workers` - Number of workers (default: 10)
- `-max-workers` - Maximum number of workers
- `-http2` - Enable HTTP/2
- `-keepalive` - Use persistent connections

Report command:
- `-type` - Report type: text, json, hist, hdrplot (default: text)
- `-output` - Output file

## Target File Format

```
# GET request
GET https://jsonplaceholder.typicode.com/posts

# POST request with headers and body
POST https://jsonplaceholder.typicode.com/posts
Content-Type: application/json

{"title":"Test","body":"Body","userId":1}

# Multiple targets (randomly selected)
GET https://jsonplaceholder.typicode.com/posts
GET https://jsonplaceholder.typicode.com/users
GET https://jsonplaceholder.typicode.com/todos
```

## Output Interpretation

Text report includes:
- **Requests** - Total requests sent
- **Rate** - Actual requests per second
- **Throughput** - Successful requests per second
- **Duration** - Total test time
- **Latencies** - Min, mean, 50th, 90th, 95th, 99th, max
- **Bytes In/Out** - Total data transfer
- **Success** - Success rate percentage
- **Status Codes** - Distribution of HTTP status codes
- **Errors** - Any errors encountered

## Advanced Usage

### Generate different report types

```bash
# Text report
vegeta attack -targets=targets/get-targets.txt -rate=50 -duration=30s | vegeta report

# JSON report
vegeta attack -targets=targets/get-targets.txt -rate=50 -duration=30s | vegeta report -type=json

# HTML report
vegeta attack -targets=targets/get-targets.txt -rate=50 -duration=30s | vegeta plot > report.html

# Histogram
vegeta attack -targets=targets/get-targets.txt -rate=50 -duration=30s | vegeta report -type=hist[0,2ms,4ms,6ms]
```

### Save results for later analysis

```bash
vegeta attack -targets=targets/get-targets.txt -rate=50 -duration=30s > results.bin
cat results.bin | vegeta report
cat results.bin | vegeta plot > report.html
```

### Ramping load (using shell script)

```bash
for rate in 10 20 50 100; do
  echo "Testing at ${rate} req/s"
  vegeta attack -targets=targets/get-targets.txt -rate=$rate -duration=1m | vegeta report
done
```
