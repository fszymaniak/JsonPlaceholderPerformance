# Plow Performance Tests

HTTP benchmarking tool with real-time terminal dashboard written in Go.

## Installation
```bash
go install github.com/six-ddc/plow@latest
```

## Features
- Real-time TUI dashboard
- Live charts and statistics
- HTTP/2 support
- Rate limiting

## Running Tests
```bash
./run-smoke-test.sh
./run-load-test.sh
./run-stress-test.sh
```

## Examples
```bash
plow https://jsonplaceholder.typicode.com/posts -c 10 -d 30s
plow https://jsonplaceholder.typicode.com/posts -c 50 -n 10000
plow https://jsonplaceholder.typicode.com/posts -c 10 --rate 50 -d 1m
```
