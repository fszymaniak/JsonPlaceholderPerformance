# JSONPlaceholder Performance Testing Suite

A comprehensive collection of performance tests for the JSONPlaceholder API using 24+ different testing tools and frameworks. This project serves as a comparison and reference implementation for various performance testing approaches.

## Overview

This repository contains equivalent performance test implementations across multiple tools, allowing you to:
- Compare different performance testing frameworks
- Learn various tool syntaxes and approaches
- Choose the right tool for your needs
- Benchmark tool capabilities and performance

## Available Testing Tools

### Modern HTTP Load Testing Tools
- **[k6](k6/)** - Modern load testing tool with TypeScript support
- **[Artillery](artillery/)** - Modern, powerful performance testing toolkit
- **[Autocannon](autocannon/)** - Fast HTTP/1.1 benchmarking tool for Node.js
- **[Gatling](gatling/)** - Powerful load testing solution with Scala DSL
- **[Locust](locust/)** - Python-based load testing framework

### Traditional Enterprise Tools
- **[JMeter](jmeter/)** - Industry-standard Java-based load testing tool
- **[Taurus](taurus/)** - Automation-friendly wrapper for JMeter, Gatling, Locust, and more
- **[Grinder](grinder/)** - Java load testing framework with Jython scripting
- **[NBomber](nbomber/)** - Modern load testing framework for .NET/C#

### Command-Line Benchmarking Tools
- **[Apache Bench (ab)](ab/)** - Simple HTTP server benchmarking tool
- **[wrk](wrk/)** - Modern HTTP benchmarking tool with Lua scripting
- **[hey](hey/)** - Tiny HTTP load generator written in Go
- **[Bombardier](bombardier/)** - Fast cross-platform HTTP benchmarking tool
- **[Vegeta](vegeta/)** - HTTP load testing tool and library
- **[Oha](oha/)** - HTTP load generator inspired by hey and written in Rust
- **[Plow](plow/)** - High-performance HTTP benchmarking tool written in Go
- **[Cassowary](cassowary/)** - Modern HTTP/S benchmark tool written in Go
- **[Fortio](fortio/)** - Load testing library and CLI tool from Istio project
- **[Drill](drill/)** - HTTP load testing tool written in Rust

### Specialized Tools
- **[Siege](siege/)** - HTTP regression testing and benchmarking utility
- **[Hyperfoil](hyperfoil/)** - Distributed benchmark framework
- **[Yandex Tank](yandex-tank/)** - Load testing tool from Yandex
- **[Tsung](tsung/)** - Multi-protocol distributed load testing tool
- **[GoReplay](goreplay/)** - Network traffic replay tool

## Quick Start

Each tool has its own directory with:
- Dedicated README with installation and usage instructions
- Test configurations for all test types
- Tool-specific examples and best practices

### Common Test Types

All tools implement these standard performance test scenarios:

1. **Smoke Test** - Quick validation with minimal load
2. **Load Test** - Gradual ramp-up to test normal conditions
3. **Stress Test** - Push system beyond normal capacity
4. **Spike Test** - Sudden traffic surges
5. **Soak Test** - Extended duration for stability testing

### Example: Running k6 Tests

```bash
# Install dependencies
npm install

# Build TypeScript tests
npm run build

# Run tests
npm run test:smoke
npm run test:load
npm run test:stress
```

See individual tool directories for specific instructions.

## Project Structure

```
.
├── k6/                     # k6 TypeScript tests
├── artillery/              # Artillery YAML configurations
├── autocannon/             # Autocannon Node.js tests
├── nbomber/                # NBomber C# tests
├── jmeter/                 # JMeter test plans
├── gatling/                # Gatling Scala simulations
├── locust/                 # Locust Python tests
├── taurus/                 # Taurus YAML configurations
├── grinder/                # Grinder Jython scripts
├── wrk/                    # wrk Lua scripts
├── vegeta/                 # Vegeta configurations
├── ab/                     # Apache Bench scripts
├── hey/                    # hey test scripts
├── bombardier/             # Bombardier test scripts
├── oha/                    # Oha test scripts
├── plow/                   # Plow test scripts
├── cassowary/              # Cassowary test scripts
├── fortio/                 # Fortio test configurations
├── drill/                  # Drill YAML configurations
├── siege/                  # Siege test configurations
├── hyperfoil/              # Hyperfoil YAML benchmarks
├── yandex-tank/            # Yandex Tank configurations
├── tsung/                  # Tsung XML configurations
├── goreplay/               # GoReplay scripts
└── README.md               # This file
```

## Tool Selection Guide

### Choose k6 if you want:
- TypeScript/JavaScript ecosystem
- Modern scripting with good IDE support
- Cloud integration options
- Protocol support (HTTP, WebSocket, gRPC)

### Choose Artillery if you want:
- Simple YAML configuration
- Node.js ecosystem
- WebSocket/Socket.io support
- Easy CI/CD integration

### Choose JMeter if you need:
- Enterprise-grade features
- GUI for test creation
- Extensive protocol support
- Mature ecosystem and plugins

### Choose Locust if you prefer:
- Python programming
- Distributed load generation
- Web UI for monitoring
- Flexible test scenarios

### Choose CLI tools (wrk, hey, vegeta) if you want:
- Quick benchmarking
- Minimal setup
- Command-line automation
- Lightweight resource usage

### Choose NBomber if you're in:
- .NET/C# ecosystem
- Need for strongly-typed tests
- Modern async/await patterns

## Contributing

Each tool implementation aims to be idiomatic and follow best practices for that specific tool. Contributions are welcome to:
- Add new tools
- Improve existing implementations
- Add more test scenarios
- Update documentation

## Testing Target

All tests target the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) API, a free fake REST API for testing and prototyping.

## License

MIT
