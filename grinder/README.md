# The Grinder Performance Tests

This folder contains The Grinder performance tests for the JSONPlaceholder API, written in Jython (Python for Java).

## Prerequisites

- [Java JDK 8+](https://adoptium.net/)
- [The Grinder 3.11+](https://grinder.sourceforge.net/) downloaded and extracted

## Setup

1. Download The Grinder from https://grinder.sourceforge.net/
2. Extract the archive to a directory (e.g., `/opt/grinder` or `C:\grinder`)
3. Set `GRINDER_HOME` environment variable to the installation directory
4. Add `$GRINDER_HOME/lib` to your classpath

## Running Tests

The Grinder uses properties files to configure tests. Each test scenario has a corresponding properties file.

### Running in Console Mode

Start the Grinder console (for monitoring):

```bash
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Console
```

### Running Agent (Headless Mode)

Run tests without the console using properties files:

#### Smoke Test
Quick validation with minimal load (1 thread, 30s):
```bash
cd grinder
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Grinder smoke-test.properties
```

#### Load Test
Comprehensive API testing with gradual ramp-up (10-50 threads):
```bash
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Grinder load-test.properties
```

#### Stress Test
Push the system to its limits (50-150 threads):
```bash
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Grinder stress-test.properties
```

#### Spike Test
Test sudden traffic surges:
```bash
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Grinder spike-test.properties
```

#### Soak Test
Extended duration test (20 threads, 30min):
```bash
java -cp $GRINDER_HOME/lib/grinder.jar net.grinder.Grinder soak-test.properties
```

## Test Files

- `scripts/smoke_test.py` - Basic health check Jython script
- `scripts/load_test.py` - Comprehensive load test Jython script
- `scripts/stress_test.py` - High load stress test Jython script
- `scripts/spike_test.py` - Sudden traffic spike test Jython script
- `scripts/soak_test.py` - Extended duration test Jython script
- `*.properties` - Configuration files for each test scenario

## Project Structure

```
grinder/
├── scripts/                       # Jython test scripts
│   ├── smoke_test.py
│   ├── load_test.py
│   ├── stress_test.py
│   ├── spike_test.py
│   └── soak_test.py
├── smoke-test.properties         # Smoke test configuration
├── load-test.properties          # Load test configuration
├── stress-test.properties        # Stress test configuration
├── spike-test.properties         # Spike test configuration
├── soak-test.properties          # Soak test configuration
└── README.md                      # This file
```

## The Grinder Benefits

- Java-based with Jython scripting
- Distributed load testing support
- Detailed statistics and reporting
- Mature and stable framework
- Good for testing Java applications
- Flexible test scripting
- Console for real-time monitoring
- Support for multiple protocols

## Properties File Configuration

Key properties in `.properties` files:

- `grinder.script` - Path to the Jython test script
- `grinder.processes` - Number of worker processes
- `grinder.threads` - Number of threads per process
- `grinder.runs` - Number of test iterations (0 = infinite)
- `grinder.duration` - Test duration in milliseconds
- `grinder.logDirectory` - Directory for log files
- `grinder.useConsole` - Whether to connect to console (true/false)

## Reports

The Grinder generates log files in the specified log directory:
- `out_*.log` - Output logs from each worker
- `data_*.log` - Performance data logs
- Error logs for failed requests

Use the console to view real-time statistics and generate reports.
