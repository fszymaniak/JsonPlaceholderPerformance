# Autocannon Performance Tests

This folder contains Autocannon performance tests for the JSONPlaceholder API. Autocannon is a fast HTTP/1.1 benchmarking tool written in Node.js.

## Prerequisites

- [Node.js 14+](https://nodejs.org/)
- npm

## Setup

Install Autocannon globally:

```bash
npm install -g autocannon
```

Or install locally:

```bash
cd autocannon
npm install
```

## Running Tests

Autocannon can be used via CLI or programmatically.

### CLI Usage

```bash
autocannon -c <connections> -d <duration> <url>
```

### Test Scenarios

#### Smoke Test
Quick validation (1 connection, 30s):
```bash
npm run test:smoke
```

#### Load Test
Moderate load (50 connections, 5min):
```bash
npm run test:load
```

#### Stress Test
High load (200 connections, 10min):
```bash
npm run test:stress
```

#### Spike Test
Sudden traffic (500 connections, 2min):
```bash
npm run test:spike
```

#### Soak Test
Extended duration (20 connections, 30min):
```bash
npm run test:soak
```

### Programmatic Usage

Run custom tests:

```bash
node tests/load-test.js
```

## Test Files

- `tests/smoke-test.js` - Smoke test script
- `tests/load-test.js` - Load test script
- `tests/stress-test.js` - Stress test script
- `tests/spike-test.js` - Spike test script
- `tests/soak-test.js` - Soak test script
- `package.json` - Dependencies and scripts

## Project Structure

```
autocannon/
├── tests/
│   ├── smoke-test.js
│   ├── load-test.js
│   ├── stress-test.js
│   ├── spike-test.js
│   └── soak-test.js
├── package.json
└── README.md
```

## Autocannon Benefits

- Very fast (written in Node.js but optimized)
- Programmatic API for Node.js apps
- HTTP pipelining support
- Warmup support
- Progress tracking
- JSON output
- Custom request bodies
- Good for Node.js benchmarking

## CLI Options

- `-c` - Number of concurrent connections (default: 10)
- `-d` - Duration in seconds (default: 10)
- `-p` - Number of pipelined requests (default: 1)
- `-w` - Number of workers (default: # of CPUs)
- `-m` - HTTP method (GET, POST, etc.)
- `-b` - Request body
- `-H` - Custom headers
- `-t` - Timeout per request (default: 10s)
- `-j` - JSON output
- `--renderStatusCodes` - Print status code distribution

## Programmatic API

```javascript
const autocannon = require('autocannon');

autocannon({
  url: 'https://api.example.com',
  connections: 10,
  duration: 30,
  pipelining: 1
}, console.log);
```

## Output Interpretation

- **Requests** - Total requests sent
- **Throughput** - Requests/bytes per second
- **Latency** - Min, max, mean, stddev, percentiles
- **Requests/Sec** - Distribution over time
- **Bytes/Sec** - Data transfer rate
- **Req/Bytes counts** - Totals

## Advanced Features

### Custom Request Bodies

```bash
autocannon -c 10 -d 30 -m POST \
  -H "Content-Type: application/json" \
  -b '{"title":"test"}' \
  https://jsonplaceholder.typicode.com/posts
```

### HTTP Pipelining

```bash
autocannon -c 10 -d 30 -p 10 https://jsonplaceholder.typicode.com/posts
```

### Multiple Workers

```bash
autocannon -c 100 -d 60 -w 4 https://jsonplaceholder.typicode.com/posts
```

### JSON Output

```bash
autocannon -c 10 -d 30 -j https://jsonplaceholder.typicode.com/posts > results.json
```

## Tips

- Use `-p` for pipelining to increase load
- Add `-w` to utilize multiple CPU cores
- Use programmatic API for complex scenarios
- JSON output is useful for CI/CD integration
- Warmup with `-W` option before actual test
- Great for benchmarking Node.js applications

## Examples

```bash
# Simple GET test
autocannon -c 10 -d 30 https://jsonplaceholder.typicode.com/posts

# POST with body
autocannon -c 10 -d 30 -m POST \
  -H "Content-Type: application/json" \
  -b '{"title":"test","body":"body","userId":1}' \
  https://jsonplaceholder.typicode.com/posts

# High load with pipelining
autocannon -c 100 -d 60 -p 10 -w 4 \
  https://jsonplaceholder.typicode.com/posts

# JSON output
autocannon -c 50 -d 30 -j \
  https://jsonplaceholder.typicode.com/posts > results.json
```
