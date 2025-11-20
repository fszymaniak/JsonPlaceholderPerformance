# Bombardier Performance Tests

Fast HTTP benchmarking tool written in Go. Bombardier is designed for high-performance HTTP testing with support for HTTP/1.x and HTTP/2.

## Prerequisites

- [Bombardier](https://github.com/codesenberg/bombardier) installed
- For installation:
  ```bash
  # Go install
  go install github.com/codesenberg/bombardier@latest

  # Download binary (Linux)
  wget https://github.com/codesenberg/bombardier/releases/latest/download/bombardier-linux-amd64
  chmod +x bombardier-linux-amd64
  sudo mv bombardier-linux-amd64 /usr/local/bin/bombardier

  # macOS
  brew install bombardier
  ```

## Running Tests

### Basic Usage

```bash
bombardier -c <connections> -d <duration> <url>
```

### Test Scenarios

```bash
# Smoke Test
./run-smoke-test.sh

# Load Test
./run-load-test.sh

# Stress Test
./run-stress-test.sh

# Spike Test
./run-spike-test.sh

# Soak Test
./run-soak-test.sh
```

## Bombardier Benefits

- Extremely fast (written in Go)
- HTTP/1.x and HTTP/2 support
- Low resource usage
- Simple CLI
- Colored output
- JSON/Plain text output
- Good for high-load testing

## Command Options

- `-c` - Concurrent connections (default: 125)
- `-d` - Test duration (e.g., 30s, 5m)
- `-n` - Number of requests
- `-r` - Requests per second (rate limiting)
- `-t` - Socket/request timeout
- `-m` - HTTP method
- `-H` - Custom headers
- `-b` - Request body
- `-f` - Body from file
- `--http2` - Use HTTP/2
- `--fasthttp` - Use fasthttp client
- `-p` - Print result (plain or json)

## Examples

```bash
# Simple test
bombardier -c 50 -d 30s https://jsonplaceholder.typicode.com/posts

# Rate limited
bombardier -c 10 -r 100 -d 60s https://jsonplaceholder.typicode.com/posts

# HTTP/2
bombardier -c 50 -d 30s --http2 https://jsonplaceholder.typicode.com/posts

# POST request
bombardier -c 10 -d 30s -m POST -H "Content-Type: application/json" \
  -b '{"title":"test"}' https://jsonplaceholder.typicode.com/posts

# JSON output
bombardier -c 50 -d 30s -p json https://jsonplaceholder.typicode.com/posts
```
