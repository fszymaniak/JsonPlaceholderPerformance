# JSONPlaceholder Performance Tests

This project contains k6 performance tests for the JSONPlaceholder API, written in TypeScript.

## Prerequisites

- [k6](https://k6.io/docs/getting-started/installation/) installed
- Node.js and npm installed

## Setup

Install dependencies:

```bash
npm install
```

## Building Tests

Build all TypeScript tests:

```bash
npm run build
```

Or build and watch for changes:

```bash
npm run build:watch
```

## Running Tests

After building, you can run the different test types:

### Smoke Test
Quick validation with minimal load (1 VU, 30s):
```bash
npm run test:smoke
```

### Load Test
Comprehensive API testing with gradual ramp-up (10-20 VUs):
```bash
npm run test:load
```

### Stress Test
Push the system to its limits (50-150 VUs):
```bash
npm run test:stress
```

### Spike Test
Test sudden traffic surges (5-150 VUs):
```bash
npm run test:spike
```

### Soak Test
Extended duration test for memory leaks and degradation (20 VUs, 30min):
```bash
npm run test:soak
```

## Test Files

- `src/smoke-test.ts` - Basic health check
- `src/jsonplaceholder-load-test.ts` - Comprehensive load test
- `src/stress-test.ts` - High load stress test
- `src/spike-test.ts` - Sudden traffic spike test
- `src/soak-test.ts` - Extended duration test

## Project Structure

```
.
├── src/                    # TypeScript source files
├── dist/                   # Compiled JavaScript files (generated)
├── package.json            # Project dependencies and scripts
├── tsconfig.json          # TypeScript configuration
├── webpack.config.js      # Webpack bundling configuration
└── README.md              # This file
```

## TypeScript Benefits

- Type safety for k6 API
- Better IDE support and autocomplete
- Compile-time error checking
- Improved code maintainability
- Interface definitions for API responses
