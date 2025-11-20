# Gatling Performance Tests

This folder contains Gatling performance tests for the JSONPlaceholder API, written in Scala.

## Prerequisites

- [Java JDK 11](https://adoptium.net/) or later
- [Maven 3.6+](https://maven.apache.org/download.cgi) or use the included Maven wrapper

## Setup

The project uses Maven for dependency management. All dependencies will be downloaded automatically.

## Building Tests

Compile the project:

```bash
cd gatling
mvn clean compile
```

Or use the Maven wrapper (no Maven installation required):

```bash
./mvnw clean compile
```

## Running Tests

Run different test scenarios using Maven:

### Smoke Test
Quick validation with minimal load (1 user, 30s):
```bash
mvn gatling:test -Dgatling.simulationClass=simulations.SmokeTest
```

### Load Test
Comprehensive API testing with gradual ramp-up (10-50 users):
```bash
mvn gatling:test -Dgatling.simulationClass=simulations.LoadTest
```

### Stress Test
Push the system to its limits (50-150 users):
```bash
mvn gatling:test -Dgatling.simulationClass=simulations.StressTest
```

### Spike Test
Test sudden traffic surges (5-150 users):
```bash
mvn gatling:test -Dgatling.simulationClass=simulations.SpikeTest
```

### Soak Test
Extended duration test for memory leaks and degradation (20 users, 30min):
```bash
mvn gatling:test -Dgatling.simulationClass=simulations.SoakTest
```

## Test Files

- `src/test/scala/simulations/SmokeTest.scala` - Basic health check simulation
- `src/test/scala/simulations/LoadTest.scala` - Comprehensive load test simulation
- `src/test/scala/simulations/StressTest.scala` - High load stress test simulation
- `src/test/scala/simulations/SpikeTest.scala` - Sudden traffic spike test simulation
- `src/test/scala/simulations/SoakTest.scala` - Extended duration test simulation

## Project Structure

```
gatling/
├── pom.xml                                    # Maven project configuration
├── src/
│   └── test/
│       ├── scala/
│       │   └── simulations/                   # Simulation files
│       │       ├── SmokeTest.scala
│       │       ├── LoadTest.scala
│       │       ├── StressTest.scala
│       │       ├── SpikeTest.scala
│       │       └── SoakTest.scala
│       └── resources/
│           └── gatling.conf                   # Gatling configuration
└── README.md                                  # This file
```

## Gatling Benefits

- High performance load testing with Scala and Akka
- Beautiful, detailed HTML reports
- Real-time metrics and monitoring
- Scenario composition with DSL
- Distributed load testing support
- Integration with CI/CD pipelines
- Comprehensive assertion capabilities
- Protocol support (HTTP, WebSocket, JMS, SSE)

## Reports

After running tests, Gatling generates comprehensive HTML reports in the `target/gatling/` directory with:
- Request/response statistics
- Response time distribution
- Active users over time
- Requests per second
- Success/failure rates
- Detailed charts and graphs
