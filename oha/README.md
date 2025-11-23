# oha Performance Tests

Fast HTTP load generator written in Rust, inspired by hey but faster.

## Installation
```bash
cargo install oha
# Or download binary from https://github.com/hatoo/oha/releases
```

## Features
- Very fast (Rust performance)
- HTTP/2 and HTTP/3 support
- Real-time TUI
- JSON output

## Running Tests
```bash
./run-smoke-test.sh
./run-load-test.sh
./run-stress-test.sh
```

## Examples
```bash
oha https://jsonplaceholder.typicode.com/posts -z 30s
oha https://jsonplaceholder.typicode.com/posts -n 10000 -c 50
oha https://jsonplaceholder.typicode.com/posts -z 1m --fps 60
```
