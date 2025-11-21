# Cassowary Performance Tests

Modern HTTP load testing tool written in Go with clean output and JSON support.

## Installation
```bash
go install github.com/rogerwelin/cassowary@latest
```

## Running Tests
```bash
./run-smoke-test.sh    # 1 conn, 30s
./run-load-test.sh     # 50 conn, 5min
./run-stress-test.sh   # 200 conn, 10min
```

## Examples
```bash
cassowary run -u https://jsonplaceholder.typicode.com/posts -c 10 -n 1000
cassowary run -u https://jsonplaceholder.typicode.com/posts -c 50 -d 60s
cassowary run -u https://jsonplaceholder.typicode.com/posts -c 10 -n 1000 --json
```
