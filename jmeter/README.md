# Apache JMeter Performance Tests

This folder contains Apache JMeter performance tests for the JSONPlaceholder API.

## Prerequisites

- [Apache JMeter 5.6+](https://jmeter.apache.org/download_jmeter.cgi) installed
- Java JDK 8 or later

## Setup

1. Download and extract Apache JMeter from the official website
2. Add JMeter's `bin` directory to your PATH, or use the full path to run tests

## Running Tests

JMeter tests can be run in GUI mode (for development) or CLI mode (for actual testing).

### GUI Mode (Development/Debugging)

Open test plans in JMeter GUI to modify or debug:

```bash
cd jmeter
jmeter -t test-plans/smoke-test.jmx
```

### CLI Mode (Recommended for Testing)

Run tests in non-GUI mode for better performance:

#### Smoke Test
Quick validation with minimal load (1 thread, 30s):
```bash
jmeter -n -t test-plans/smoke-test.jmx -l results/smoke-test-results.jtl -e -o results/smoke-test-report
```

Or use the convenience script:
```bash
./scripts/run-smoke-test.sh
```

#### Load Test
Comprehensive API testing with gradual ramp-up (10-50 threads):
```bash
jmeter -n -t test-plans/load-test.jmx -l results/load-test-results.jtl -e -o results/load-test-report
```

Or use the convenience script:
```bash
./scripts/run-load-test.sh
```

#### Stress Test
Push the system to its limits (50-150 threads):
```bash
jmeter -n -t test-plans/stress-test.jmx -l results/stress-test-results.jtl -e -o results/stress-test-report
```

Or use the convenience script:
```bash
./scripts/run-stress-test.sh
```

#### Spike Test
Test sudden traffic surges (5-150 threads):
```bash
jmeter -n -t test-plans/spike-test.jmx -l results/spike-test-results.jtl -e -o results/spike-test-report
```

Or use the convenience script:
```bash
./scripts/run-spike-test.sh
```

#### Soak Test
Extended duration test for memory leaks and degradation (20 threads, 30min):
```bash
jmeter -n -t test-plans/soak-test.jmx -l results/soak-test-results.jtl -e -o results/soak-test-report
```

Or use the convenience script:
```bash
./scripts/run-soak-test.sh
```

## Test Files

- `test-plans/smoke-test.jmx` - Basic health check test plan
- `test-plans/load-test.jmx` - Comprehensive load test plan
- `test-plans/stress-test.jmx` - High load stress test plan
- `test-plans/spike-test.jmx` - Sudden traffic spike test plan
- `test-plans/soak-test.jmx` - Extended duration test plan

## Project Structure

```
jmeter/
├── test-plans/                    # JMeter test plan files (.jmx)
│   ├── smoke-test.jmx
│   ├── load-test.jmx
│   ├── stress-test.jmx
│   ├── spike-test.jmx
│   └── soak-test.jmx
├── scripts/                       # Convenience scripts for running tests
│   ├── run-smoke-test.sh
│   ├── run-load-test.sh
│   ├── run-stress-test.sh
│   ├── run-spike-test.sh
│   └── run-soak-test.sh
├── results/                       # Test results (generated)
└── README.md                      # This file
```

## Apache JMeter Benefits

- Industry-standard load testing tool
- Rich GUI for test plan development
- Extensive protocol support (HTTP, HTTPS, SOAP, REST, FTP, JDBC, etc.)
- Distributed testing capabilities
- Comprehensive reporting and analysis
- Large ecosystem of plugins
- CSV data parameterization
- Correlation and assertion support
- Performance monitoring and profiling

## Reports

After running tests in CLI mode with the `-e -o` flags, JMeter generates comprehensive HTML reports including:
- Response time statistics
- Throughput graphs
- Error rate analysis
- Response time percentiles
- Active threads over time
- Hits per second
- Detailed transaction statistics

Reports are saved in the `results/` directory.

## Command Line Options

- `-n` - Non-GUI mode
- `-t` - Test plan file
- `-l` - Log file for results
- `-e` - Generate report after test
- `-o` - Output folder for report
- `-J` - Define JMeter property (e.g., `-Jthreads=100`)
