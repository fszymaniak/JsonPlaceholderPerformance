# hey Performance Tests

This folder contains hey performance tests for the JSONPlaceholder API. hey is a tiny program that sends some load to a web application - it's a modern HTTP benchmarking tool written in Go.

## Prerequisites

- [hey](https://github.com/rakyll/hey) installed
- For installation:
  ```bash
  # macOS
  brew install hey

  # Go install
  go install github.com/rakyll/hey@latest

  # Linux (download binary)
  wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
  chmod +x hey_linux_amd64
  sudo mv hey_linux_amd64 /usr/local/bin/hey
  ```

## Running Tests

hey has a simple command-line interface similar to Apache Bench.

### Basic Usage

```bash
hey -n <requests> -c <concurrency> <url>
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
Extended duration (time-based, 30 minutes, 20 concurrent):
```bash
./run-soak-test.sh
```

### POST Request Example

```bash
hey -n 1000 -c 10 -m POST \
  -H "Content-Type: application/json" \
  -d '{"title":"hey test","body":"Testing POST","userId":1}' \
  https://jsonplaceholder.typicode.com/posts
```

## Test Files

- `run-smoke-test.sh` - Smoke test runner
- `run-load-test.sh` - Load test runner
- `run-stress-test.sh` - Stress test runner
- `run-spike-test.sh` - Spike test runner
- `run-soak-test.sh` - Soak test runner

## Project Structure

```
hey/
├── run-smoke-test.sh         # Smoke test runner
├── run-load-test.sh          # Load test runner
├── run-stress-test.sh        # Stress test runner
├── run-spike-test.sh         # Spike test runner
├── run-soak-test.sh          # Soak test runner
└── README.md                  # This file
```

## hey Benefits

- Simple and fast
- Cross-platform (Windows, macOS, Linux)
- HTTP/2 support
- Custom headers and request bodies
- Detailed latency distribution
- Easy to use and understand
- Lightweight binary
- Good for quick benchmarks

## Command Line Options

- `-n` - Number of requests (default: 200)
- `-c` - Number of concurrent workers (default: 50)
- `-q` - Rate limit (requests per second, 0 = no limit)
- `-z` - Duration of test (e.g., 30s, 5m) - alternative to -n
- `-m` - HTTP method (GET, POST, PUT, DELETE, etc.)
- `-H` - Custom HTTP header (can be repeated)
- `-d` - Request body (for POST/PUT)
- `-D` - Request body from file
- `-T` - Content type (sets Content-Type header)
- `-t` - Timeout for each request (default: 20s)
- `-host` - Custom Host header
- `-disable-compression` - Disable gzip compression
- `-disable-keepalive` - Disable keep-alive
- `-cpus` - Number of CPU cores to use

## Output Interpretation

hey provides detailed statistics:
- **Summary** - Total time, slowest, fastest, average, RPS
- **Response time histogram** - Distribution of response times
- **Latency distribution** - Percentiles (10%, 25%, 50%, 75%, 90%, 95%, 99%)
- **Details** - DNS lookup, TCP connection, TLS handshake times
- **Status code distribution** - HTTP status codes received
- **Error distribution** - Any errors encountered

## Tips

- Use `-z` for time-based tests (e.g., `-z 30s` instead of `-n`)
- Add `-q` for rate limiting (constant rate testing)
- Use `-disable-keepalive` to test connection handling
- Increase `-t` timeout for slow APIs
- Use `-cpus` to utilize multiple cores for higher load

## Examples

```bash
# Simple GET test
hey -n 1000 -c 50 https://jsonplaceholder.typicode.com/posts

# Time-based test
hey -z 60s -c 10 https://jsonplaceholder.typicode.com/posts

# Rate-limited test
hey -z 60s -q 50 https://jsonplaceholder.typicode.com/posts

# POST with custom headers
hey -n 1000 -c 10 -m POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer token" \
  -d '{"title":"test"}' \
  https://jsonplaceholder.typicode.com/posts

# HTTP/2 test
hey -n 1000 -c 50 -h2 https://jsonplaceholder.typicode.com/posts
```
