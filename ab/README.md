# Apache Bench (ab) Performance Tests

This folder contains Apache Bench (ab) performance tests for the JSONPlaceholder API. Apache Bench is a classic command-line tool for benchmarking HTTP servers.

## Prerequisites

- Apache Bench (ab) - usually comes pre-installed with Apache HTTP Server
- For installation:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install apache2-utils

  # macOS (comes with macOS)
  # ab is pre-installed

  # CentOS/RHEL
  sudo yum install httpd-tools
  ```

## Running Tests

ab uses a simple command-line interface.

### Basic Usage

```bash
ab -n <requests> -c <concurrency> <url>
```

### Test Scenarios

#### Smoke Test
Quick validation (100 requests, 1 concurrent):
```bash
./run-smoke-test.sh
```

#### Load Test
Moderate load (10,000 requests, 50 concurrent):
```bash
./run-load-test.sh
```

#### Stress Test
High load (50,000 requests, 200 concurrent):
```bash
./run-stress-test.sh
```

#### Spike Test
Sudden traffic (20,000 requests, 500 concurrent):
```bash
./run-spike-test.sh
```

#### Soak Test
Extended duration (time-based with multiple runs):
```bash
./run-soak-test.sh
```

### POST Request Example

```bash
ab -n 1000 -c 10 -p post-data.json -T application/json \
  https://jsonplaceholder.typicode.com/posts
```

## Test Files

- `run-smoke-test.sh` - Smoke test runner
- `run-load-test.sh` - Load test runner
- `run-stress-test.sh` - Stress test runner
- `run-spike-test.sh` - Spike test runner
- `run-soak-test.sh` - Soak test runner
- `post-data.json` - Sample POST request body

## Project Structure

```
ab/
├── run-smoke-test.sh         # Smoke test runner
├── run-load-test.sh          # Load test runner
├── run-stress-test.sh        # Stress test runner
├── run-spike-test.sh         # Spike test runner
├── run-soak-test.sh          # Soak test runner
├── post-data.json            # POST request payload
└── README.md                  # This file
```

## Apache Bench Benefits

- Pre-installed on most systems
- Simple and easy to use
- Fast and lightweight
- Industry standard for quick tests
- Reliable and stable
- Good for basic benchmarking
- Minimal dependencies

## Command Line Options

- `-n` - Number of requests to perform
- `-c` - Number of concurrent requests
- `-t` - Time limit for test (alternative to -n)
- `-p` - File containing POST data
- `-T` - Content-type header for POST data
- `-H` - Add custom header (e.g., `-H "Authorization: Bearer token"`)
- `-k` - Enable HTTP keep-alive
- `-r` - Don't exit on socket receive errors
- `-s` - Timeout per request (default: 30 seconds)
- `-g` - Write gnuplot data file
- `-e` - Write CSV data file
- `-v` - Verbosity level (1-5)

## Output Interpretation

ab provides detailed statistics:
- **Server info** - Software name and version
- **Document info** - Path and length
- **Concurrency Level** - Number of concurrent requests
- **Time taken** - Total test duration
- **Complete requests** - Successfully completed requests
- **Failed requests** - Number of failures
- **Requests per second** - Throughput (mean)
- **Time per request** - Mean across all concurrent requests
- **Transfer rate** - KB/sec received
- **Connection Times** - Min, mean, median, max
- **Percentage of requests** - Served within certain time (50%, 66%, 75%, 80%, 90%, 95%, 98%, 99%, 100%)

## Limitations

- Single URL per test (no scenario support)
- Limited to GET and POST methods easily
- No built-in ramping or complex scenarios
- Less suitable for modern web apps with complex flows
- No WebSocket support
- Limited reporting compared to modern tools

## Tips

- Use `-k` (keep-alive) for more realistic testing
- Add `-r` to not exit on errors during high load
- Use `-g` or `-e` to export data for analysis
- Increase timeout with `-s` for slow APIs
- Use `-v 2` for more detailed output
- Combine with shell scripts for complex scenarios

## Examples

```bash
# Simple GET test
ab -n 1000 -c 50 https://jsonplaceholder.typicode.com/posts

# With keep-alive
ab -n 1000 -c 50 -k https://jsonplaceholder.typicode.com/posts

# Time-based test (60 seconds)
ab -t 60 -c 10 https://jsonplaceholder.typicode.com/posts

# POST with JSON data
ab -n 1000 -c 10 -p post-data.json -T application/json \
  https://jsonplaceholder.typicode.com/posts

# With custom headers
ab -n 1000 -c 50 -H "Authorization: Bearer token123" \
  https://jsonplaceholder.typicode.com/posts

# Export to CSV
ab -n 1000 -c 50 -e results.csv \
  https://jsonplaceholder.typicode.com/posts

# Verbose output
ab -n 1000 -c 50 -v 2 https://jsonplaceholder.typicode.com/posts
```

## Comparison with Modern Tools

While ab is great for quick benchmarks, consider modern alternatives for:
- Complex scenarios → Artillery, k6, Gatling
- Constant rate testing → Vegeta, Fortio
- High throughput → wrk, wrk2
- WebSocket testing → Artillery, k6
- Detailed reporting → Gatling, Taurus

However, ab remains valuable for:
- Quick sanity checks
- Simple benchmarks
- Pre-installed availability
- Basic performance verification
