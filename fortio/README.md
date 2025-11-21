# Fortio Performance Tests

Fortio is a load testing library, command line tool, advanced echo server and web UI in Go. Originally developed for Istio service mesh testing, it's great for microservices.

## Prerequisites

```bash
# Go install
go install fortio.org/fortio@latest

# Download binary
wget https://github.com/fortio/fortio/releases/latest/download/fortio_linux_amd64.tgz
tar xzf fortio_linux_amd64.tgz && sudo mv fortio /usr/local/bin/

# macOS
brew install fortio
```

## Running Tests

```bash
# Smoke (1 QPS, 30s)
./run-smoke-test.sh

# Load (20 QPS, 5min)
./run-load-test.sh

# Stress (100 QPS, 10min)
./run-stress-test.sh

# Spike (200 QPS, 2min)
./run-spike-test.sh

# Soak (20 QPS, 30min)
./run-soak-test.sh
```

## Fortio Benefits

- Constant QPS (queries per second) testing
- gRPC support
- Web UI for visualization
- Percentile latency tracking
- JSON output
- Great for microservices testing
- Developed by Istio team

## Examples

```bash
# Constant QPS test
fortio load -qps 50 -t 60s https://jsonplaceholder.typicode.com/posts

# With connections
fortio load -c 10 -qps 100 -t 5m https://jsonplaceholder.typicode.com/posts

# POST request
fortio load -qps 10 -t 30s -H "Content-Type: application/json" \
  -payload '{"title":"test"}' -method POST \
  https://jsonplaceholder.typicode.com/posts

# JSON output
fortio load -qps 50 -t 30s -json results.json \
  https://jsonplaceholder.typicode.com/posts

# Web UI (start server)
fortio server
# Then access http://localhost:8080
```
