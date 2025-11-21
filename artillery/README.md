# Artillery Performance Tests

This folder contains Artillery performance tests for the JSONPlaceholder API. Artillery is a modern, powerful, and easy-to-use performance testing toolkit.

## Prerequisites

- [Node.js 18+](https://nodejs.org/)
- npm or yarn

## Setup

Install Artillery globally:

```bash
npm install -g artillery@latest
```

Or install locally in the project:

```bash
cd artillery
npm install
```

## Running Tests

Artillery uses YAML configuration files to define test scenarios.

### Basic Usage

```bash
artillery run <scenario-file>.yml
```

### Test Scenarios

#### Smoke Test
Quick validation (1 VU, 30s):
```bash
artillery run scenarios/smoke-test.yml
```

Or:
```bash
npm run test:smoke
```

#### Load Test
Ramping load (10-50 VUs, 5min):
```bash
artillery run scenarios/load-test.yml
```

Or:
```bash
npm run test:load
```

#### Stress Test
High load (50-150 VUs, 10min):
```bash
artillery run scenarios/stress-test.yml
```

Or:
```bash
npm run test:stress
```

#### Spike Test
Traffic spikes (5-150 VUs):
```bash
artillery run scenarios/spike-test.yml
```

Or:
```bash
npm run test:spike
```

#### Soak Test
Extended duration (20 VUs, 30min):
```bash
artillery run scenarios/soak-test.yml
```

Or:
```bash
npm run test:soak
```

### Generate HTML Report

```bash
artillery run scenarios/load-test.yml --output report.json
artillery report report.json --output report.html
```

Or use the combined script:
```bash
npm run test:load:report
```

## Test Files

- `scenarios/smoke-test.yml` - Smoke test configuration
- `scenarios/load-test.yml` - Load test configuration
- `scenarios/stress-test.yml` - Stress test configuration
- `scenarios/spike-test.yml` - Spike test configuration
- `scenarios/soak-test.yml` - Soak test configuration
- `package.json` - Dependencies and npm scripts

## Project Structure

```
artillery/
├── scenarios/                 # Test scenario YAML files
│   ├── smoke-test.yml
│   ├── load-test.yml
│   ├── stress-test.yml
│   ├── spike-test.yml
│   └── soak-test.yml
├── package.json               # npm configuration
├── .gitignore
└── README.md                  # This file
```

## Artillery Benefits

- Modern and actively maintained
- Easy YAML-based configuration
- WebSocket and Socket.io support
- AWS Lambda support
- Plugin ecosystem
- Real-time metrics
- HTML reports with charts
- Expectations and assertions
- Scenarios and flows
- Custom JavaScript functions
- CI/CD integration
- Distributed load testing (Artillery Pro)

## YAML Configuration Structure

```yaml
config:
  target: "https://api.example.com"
  phases:
    - duration: 60
      arrivalRate: 10
      name: "Warm up"
  defaults:
    headers:
      Content-Type: "application/json"

scenarios:
  - name: "Test scenario"
    flow:
      - get:
          url: "/endpoint"
      - post:
          url: "/endpoint"
          json:
            key: "value"
```

## Output Metrics

Artillery provides comprehensive metrics:
- **Scenarios** - Total launched, completed
- **Requests** - Total sent, completed
- **RPS** - Requests per second
- **Latency** - Min, max, median, p95, p99
- **HTTP codes** - Distribution of status codes
- **Errors** - Any errors encountered
- **Custom metrics** - User-defined metrics

## Advanced Features

### Custom JavaScript Functions

```yaml
config:
  processor: "./helpers.js"

scenarios:
  - flow:
      - function: "setRandomUser"
      - post:
          url: "/users"
          json:
            userId: "{{ userId }}"
```

### Expectations (Assertions)

```yaml
scenarios:
  - flow:
      - get:
          url: "/posts/1"
          expect:
            - statusCode: 200
            - contentType: json
            - hasProperty: title
```

### WebSocket Support

```yaml
scenarios:
  - engine: ws
    flow:
      - send: "Hello WebSocket"
      - think: 1
```

### Environment Variables

```bash
artillery run -e production scenarios/load-test.yml
```

## Plugins

Install useful plugins:

```bash
# Metrics by endpoint
npm install --save-dev artillery-plugin-metrics-by-endpoint

# Expect plugin
npm install --save-dev artillery-plugin-expect

# Publish metrics to external systems
npm install --save-dev artillery-plugin-statsd
npm install --save-dev artillery-plugin-cloudwatch
```

## Tips

- Use `--quiet` for less verbose output
- Use `--output` to save raw results
- Use `artillery report` to generate HTML reports
- Use environments for different targets
- Add custom processors for complex logic
- Use expectations for functional testing
- Monitor resources during tests

## Examples

```bash
# Run with custom environment
artillery run -e staging scenarios/load-test.yml

# Run with quiet mode
artillery run --quiet scenarios/smoke-test.yml

# Run and generate report
artillery run scenarios/load-test.yml -o results.json
artillery report results.json -o report.html

# Quick test (no config file)
artillery quick --duration 60 --rate 10 https://jsonplaceholder.typicode.com/posts

# Run with overrides
artillery run scenarios/load-test.yml \
  --overrides '{"config":{"phases":[{"duration":120,"arrivalRate":20}]}}'
```
