# Tsung Performance Tests

Multi-protocol distributed load testing tool written in Erlang.

## Installation
```bash
# Ubuntu/Debian
sudo apt-get install tsung

# Build from source
git clone https://github.com/processone/tsung.git
cd tsung && ./configure && make && sudo make install
```

## Features
- Distributed testing
- Multi-protocol (HTTP, WebSocket, MQTT, etc.)
- XML configuration
- Real-time graphs

## Running Tests
```bash
tsung -f smoke-test.xml start
tsung -f load-test.xml start
```
