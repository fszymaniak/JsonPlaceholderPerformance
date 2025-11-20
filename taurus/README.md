# Taurus Performance Tests

This folder contains Taurus performance tests for the JSONPlaceholder API, written in YAML configuration files.

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- pip (Python package manager)
- Java 8+ (for JMeter executor)

## Setup

Install Taurus via pip:

```bash
pip install bzt
```

Or create a virtual environment first (recommended):

```bash
cd taurus
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

## Running Tests

Taurus uses YAML configuration files to define tests. It can execute tests using various backends (JMeter, Gatling, Locust, etc.).

### Basic Usage

Run a test scenario:

```bash
bzt <scenario-file>.yml
```

### Test Scenarios

#### Smoke Test
Quick validation with minimal load (1 user, 30s):
```bash
bzt smoke-test.yml
```

#### Load Test
Comprehensive API testing with gradual ramp-up (10-50 users, 7min):
```bash
bzt load-test.yml
```

#### Stress Test
Push the system to its limits (50-150 users, 14min):
```bash
bzt stress-test.yml
```

#### Spike Test
Test sudden traffic surges (5-150 users):
```bash
bzt spike-test.yml
```

#### Soak Test
Extended duration test (20 users, 30min):
```bash
bzt soak-test.yml
```

### Advanced Options

Generate reports:
```bash
bzt load-test.yml -report
```

Override settings:
```bash
bzt load-test.yml -o execution.concurrency=100 -o execution.hold-for=10m
```

Use specific executor (default is JMeter):
```bash
bzt load-test.yml -o modules.jmeter.version=5.6
```

## Test Files

- `smoke-test.yml` - Basic health check scenario
- `load-test.yml` - Comprehensive load test scenario
- `stress-test.yml` - High load stress test scenario
- `spike-test.yml` - Sudden traffic spike test scenario
- `soak-test.yml` - Extended duration test scenario
- `multi-executor.yml` - Example using multiple executors (JMeter + Locust)

## Project Structure

```
taurus/
├── smoke-test.yml         # Smoke test configuration
├── load-test.yml          # Load test configuration
├── stress-test.yml        # Stress test configuration
├── spike-test.yml         # Spike test configuration
├── soak-test.yml          # Soak test configuration
├── multi-executor.yml     # Multi-executor example
├── requirements.txt       # Python dependencies
└── README.md              # This file
```

## Taurus Benefits

- Simple YAML-based configuration
- Unified interface for multiple testing tools
- Built-in reporting and analytics
- Cloud integration (BlazeMeter)
- CI/CD friendly
- Real-time monitoring
- Easy to learn and use
- Support for JMeter, Gatling, Locust, Selenium, and more
- Automatic tool installation
- Test artifact management

## YAML Configuration Structure

A typical Taurus configuration includes:

- `execution` - Test execution settings (concurrency, ramp-up, duration)
- `scenarios` - Test scenarios with requests
- `reporting` - Reporting modules (console, BlazeMeter, etc.)
- `modules` - Tool-specific settings
- `services` - Additional services (monitoring, shellexec, etc.)

## Reports

Taurus automatically generates:
- Real-time console statistics
- HTML reports with charts
- XML/JTL results for further analysis
- Integration with BlazeMeter for cloud reporting

Reports are saved in the artifacts directory (timestamped).

## Cloud Integration

Upload results to BlazeMeter:

```bash
bzt load-test.yml -report -o modules.blazemeter.token=YOUR_API_KEY
```

## Additional Resources

- [Taurus Documentation](https://gettaurus.org/docs/)
- [Taurus on GitHub](https://github.com/Blazemeter/taurus)
- [BlazeMeter](https://www.blazemeter.com/)
