# Locust Performance Tests

This folder contains Locust performance tests for the JSONPlaceholder API, written in Python.

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- pip (Python package manager)

## Setup

Install dependencies:

```bash
cd locust
pip install -r requirements.txt
```

Or create a virtual environment first (recommended):

```bash
cd locust
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

## Running Tests

Locust can be run in web UI mode or headless mode.

### Web UI Mode (Interactive)

Start Locust with web interface for interactive testing:

```bash
locust -f smoke_test.py
```

Then open http://localhost:8089 in your browser, enter the number of users and spawn rate, and start the test.

### Headless Mode (CLI)

Run tests directly from command line without the web UI:

#### Smoke Test
Quick validation with minimal load (1 user, 30s):
```bash
locust -f smoke_test.py --headless -u 1 -r 1 -t 30s --host https://jsonplaceholder.typicode.com
```

#### Load Test
Comprehensive API testing with gradual ramp-up (10-50 users, 7min):
```bash
locust -f load_test.py --headless -u 50 -r 0.2 -t 7m --host https://jsonplaceholder.typicode.com
```

#### Stress Test
Push the system to its limits (50-150 users, 14min):
```bash
locust -f stress_test.py --headless -u 150 -r 0.5 -t 14m --host https://jsonplaceholder.typicode.com
```

#### Spike Test
Test sudden traffic surges (uses LoadShapeClass for custom pattern):
```bash
locust -f spike_test.py --headless --host https://jsonplaceholder.typicode.com
```

#### Soak Test
Extended duration test for memory leaks and degradation (20 users, 30min):
```bash
locust -f soak_test.py --headless -u 20 -r 1 -t 30m --host https://jsonplaceholder.typicode.com
```

## Test Files

- `smoke_test.py` - Basic health check test
- `load_test.py` - Comprehensive load test
- `stress_test.py` - High load stress test
- `spike_test.py` - Sudden traffic spike test (custom load shape)
- `soak_test.py` - Extended duration test
- `common.py` - Shared utilities and base classes

## Project Structure

```
locust/
├── smoke_test.py          # Smoke test scenario
├── load_test.py           # Load test scenario
├── stress_test.py         # Stress test scenario
├── spike_test.py          # Spike test scenario
├── soak_test.py           # Soak test scenario
├── common.py              # Shared utilities
├── requirements.txt       # Python dependencies
└── README.md              # This file
```

## Locust Benefits

- Python-based, easy to write and maintain
- Real-time web UI for monitoring
- Distributed load testing support
- Custom load shapes for complex scenarios
- Detailed statistics and charts
- Easy integration with CI/CD
- Extensible with Python ecosystem
- CSV export and custom reporting

## Command Line Options

- `-f` - Locustfile to use
- `--headless` - Run without web UI
- `-u` - Number of users to simulate
- `-r` - Spawn rate (users per second)
- `-t` - Test duration (e.g., 30s, 5m, 1h)
- `--host` - Base URL of the target system
- `--html` - Generate HTML report (e.g., `--html=report.html`)
- `--csv` - Save statistics to CSV files
- `--loglevel` - Set log level (DEBUG, INFO, WARNING, ERROR)

## Reports

Generate HTML report with test results:

```bash
locust -f load_test.py --headless -u 50 -r 1 -t 5m --host https://jsonplaceholder.typicode.com --html report.html
```

This creates a comprehensive HTML report with charts and statistics.
