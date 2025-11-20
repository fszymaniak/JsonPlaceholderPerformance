# wrk Performance Tests

This folder contains wrk performance tests for the JSONPlaceholder API. wrk is a modern HTTP benchmarking tool capable of generating significant load with a small number of threads.

## Prerequisites

- [wrk](https://github.com/wg/wrk) installed
- For installation:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install wrk

  # macOS
  brew install wrk

  # Build from source
  git clone https://github.com/wg/wrk.git
  cd wrk
  make
  sudo cp wrk /usr/local/bin
  ```

## Running Tests

wrk uses a simple command-line interface with optional Lua scripting for complex scenarios.

### Basic Usage

```bash
wrk -t<threads> -c<connections> -d<duration> <url>
```

### Test Scenarios

#### Smoke Test
Quick validation with minimal load (1 thread, 2 connections, 30s):
```bash
cd wrk
wrk -t1 -c2 -d30s https://jsonplaceholder.typicode.com/posts
```

Or use the script:
```bash
./run-smoke-test.sh
```

#### Load Test
Moderate load (4 threads, 50 connections, 5min):
```bash
wrk -t4 -c50 -d5m -s scripts/load-test.lua https://jsonplaceholder.typicode.com
```

Or use the script:
```bash
./run-load-test.sh
```

#### Stress Test
High load (8 threads, 150 connections, 10min):
```bash
wrk -t8 -c150 -d10m -s scripts/stress-test.lua https://jsonplaceholder.typicode.com
```

Or use the script:
```bash
./run-stress-test.sh
```

#### Spike Test
Sudden traffic surge (12 threads, 200 connections, 2min):
```bash
wrk -t12 -c200 -d2m -s scripts/spike-test.lua https://jsonplaceholder.typicode.com
```

Or use the script:
```bash
./run-spike-test.sh
```

#### Soak Test
Extended duration (4 threads, 20 connections, 30min):
```bash
wrk -t4 -c20 -d30m -s scripts/soak-test.lua https://jsonplaceholder.typicode.com
```

Or use the script:
```bash
./run-soak-test.sh
```

### POST Request Example

```bash
wrk -t2 -c10 -d30s -s scripts/post-request.lua https://jsonplaceholder.typicode.com
```

## Test Files

- `scripts/load-test.lua` - Load test with multiple endpoints
- `scripts/stress-test.lua` - High load stress test
- `scripts/spike-test.lua` - Spike test scenario
- `scripts/soak-test.lua` - Extended duration test
- `scripts/post-request.lua` - POST request example
- `run-*.sh` - Convenience scripts for each test

## Project Structure

```
wrk/
├── scripts/                   # Lua test scripts
│   ├── load-test.lua
│   ├── stress-test.lua
│   ├── spike-test.lua
│   ├── soak-test.lua
│   └── post-request.lua
├── run-smoke-test.sh         # Smoke test runner
├── run-load-test.sh          # Load test runner
├── run-stress-test.sh        # Stress test runner
├── run-spike-test.sh         # Spike test runner
├── run-soak-test.sh          # Soak test runner
└── README.md                  # This file
```

## wrk Benefits

- Extremely high performance (millions of requests/sec)
- Low resource usage
- Lua scripting for complex scenarios
- Simple command-line interface
- Accurate latency percentiles
- Excellent for benchmarking HTTP servers
- Built-in support for HTTP pipelining
- Custom headers and request bodies

## Command Line Options

- `-t` - Number of threads to use (default: 2)
- `-c` - Number of connections to keep open (default: 10)
- `-d` - Duration of test (e.g., 30s, 5m, 1h)
- `-s` - Lua script for custom logic
- `-H` - Add custom header (e.g., `-H "Authorization: Bearer token"`)
- `--timeout` - Socket/request timeout
- `--latency` - Print detailed latency statistics
- `--rate` - Work rate (requests/sec, experimental in wrk2)

## Lua Scripting

wrk supports Lua scripting for advanced scenarios:

```lua
-- Example: Random endpoint selection
wrk.method = "GET"
wrk.headers["Content-Type"] = "application/json"

request = function()
  local paths = {"/posts", "/users", "/todos"}
  local path = paths[math.random(#paths)]
  return wrk.format(nil, path)
end

response = function(status, headers, body)
  if status ~= 200 then
    print("Error: " .. status)
  end
end
```

## Output Interpretation

wrk provides:
- **Requests/sec** - Throughput
- **Transfer/sec** - Data transfer rate
- **Latency** - Distribution (avg, stdev, max, +/- stdev)
- **Percentiles** - 50th, 75th, 90th, 99th percentile latencies (with --latency flag)

## Tips

- Use fewer threads than CPU cores
- Connections should be >> threads for accurate results
- Add `--latency` flag for detailed percentile statistics
- Use Lua scripts for testing different endpoints
- For constant rate testing, consider wrk2 variant
