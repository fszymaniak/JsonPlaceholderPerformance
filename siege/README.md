# Siege Performance Tests

This folder contains Siege performance tests for the JSONPlaceholder API. Siege is a classic HTTP load testing and benchmarking utility.

## Prerequisites

- [Siege](https://github.com/JoeDog/siege) installed
- For installation:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install siege

  # macOS
  brew install siege

  # Build from source
  wget http://download.joedog.org/siege/siege-latest.tar.gz
  tar -xzf siege-latest.tar.gz
  cd siege-*/
  ./configure
  make
  sudo make install
  ```

## Running Tests

Siege uses URL files and command-line options for configuration.

### Basic Usage

```bash
siege -c <concurrent> -t <time> -f urls.txt
```

### Test Scenarios

#### Smoke Test
Quick validation (1 user, 30s):
```bash
./run-smoke-test.sh
```

#### Load Test
Moderate load (50 concurrent, 5min):
```bash
./run-load-test.sh
```

#### Stress Test
High load (200 concurrent, 10min):
```bash
./run-stress-test.sh
```

#### Spike Test
Sudden traffic (500 concurrent, 2min):
```bash
./run-spike-test.sh
```

#### Soak Test
Extended duration (20 concurrent, 30min):
```bash
./run-soak-test.sh
```

## Test Files

- `urls/get-urls.txt` - GET request URLs
- `urls/mixed-urls.txt` - Mixed operations (GET/POST)
- `run-*.sh` - Test runner scripts
- `siegerc` - Siege configuration file

## Project Structure

```
siege/
├── urls/
│   ├── get-urls.txt
│   └── mixed-urls.txt
├── run-smoke-test.sh
├── run-load-test.sh
├── run-stress-test.sh
├── run-spike-test.sh
├── run-soak-test.sh
├── siegerc
└── README.md
```

## Siege Benefits

- Transaction support (multiple URLs)
- HTTP authentication
- Cookie support
- Configuration file
- Detailed statistics
- Internet simulation mode
- Regression testing
- Long history and stability

## Command Line Options

- `-c` - Concurrent users (default: 15)
- `-t` - Time to run (e.g., 30S, 5M, 1H)
- `-r` - Repetitions (number of times to run)
- `-f` - File with URLs
- `-d` - Random delay between requests (0-N seconds)
- `-i` - Internet mode (random URL selection)
- `-b` - Benchmark mode (no delays)
- `-v` - Verbose output
- `-q` - Quiet mode
- `-m` - Mark log file with custom message
- `-H` - Add custom header
- `--content-type` - Set Content-Type

## URL File Format

```
# Simple GET requests
https://jsonplaceholder.typicode.com/posts
https://jsonplaceholder.typicode.com/users

# POST with inline data
https://jsonplaceholder.typicode.com/posts POST {"title":"test"}

# With custom headers
https://jsonplaceholder.typicode.com/posts POST < post-data.json
Authorization: Bearer token123
```

## Output Interpretation

- **Transactions** - Successful hits
- **Availability** - Success percentage
- **Elapsed time** - Test duration
- **Data transferred** - Total data
- **Response time** - Average response time
- **Transaction rate** - Requests per second
- **Throughput** - MB per second
- **Concurrency** - Average concurrent connections
- **Successful transactions** - Number of 200 responses
- **Failed transactions** - Number of errors
- **Longest/Shortest transaction** - Min/max response times

## Tips

- Use `-i` for more realistic testing (random URL selection)
- Add `-d1` for 1-second random delay between requests
- Use `-b` benchmark mode for maximum load
- Configure `siegerc` file for persistent settings
- Use `-v` during development, `-q` in production
- Log to file with `-l` option

## Examples

```bash
# Simple test
siege -c 10 -t 30S https://jsonplaceholder.typicode.com/posts

# With URL file
siege -c 50 -t 5M -f urls/get-urls.txt

# Internet mode (random URLs)
siege -c 25 -t 2M -i -f urls/mixed-urls.txt

# Benchmark mode (no delays)
siege -c 100 -r 100 -b -f urls/get-urls.txt

# With delays
siege -c 20 -t 10M -d2 -f urls/get-urls.txt

# Quiet mode
siege -c 50 -t 5M -q -f urls/get-urls.txt
```
