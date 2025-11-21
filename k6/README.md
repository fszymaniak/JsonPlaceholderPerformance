# k6 Performance Tests

This folder contains [k6](https://k6.io/) performance tests for the JSONPlaceholder API, written in TypeScript.

## About k6

k6 is a modern load testing tool built for developers and testers. It's designed to test the performance and reliability of APIs, microservices, and websites. Written in Go with test scripts in JavaScript/TypeScript, k6 provides:

- **Developer-friendly**: Write tests in TypeScript with full type safety
- **Performance**: Efficient load generation with minimal resource usage
- **CI/CD Integration**: Easy integration into continuous integration pipelines
- **Rich Metrics**: Comprehensive performance metrics and custom metrics support
- **Thresholds**: Pass/fail criteria for automated testing

## Test Scenarios

### 1. Smoke Test (`smoke-test.ts`)
**Purpose**: Quick validation with minimal load - perfect for CI/CD pipelines

**Configuration**:
- Virtual Users: 1
- Duration: 30 seconds
- Thresholds:
  - 95% of requests < 1000ms
  - Error rate < 1%

**Endpoints Tested**:
- GET `/posts` - List all posts
- GET `/posts/1` - Get single post
- POST `/posts` - Create new post
- GET `/users` - List all users
- GET `/todos` - List all todos

**Use Case**: Run before every deployment to quickly verify API health and basic functionality.

### 2. Load Test (`jsonplaceholder-load-test.ts`)
**Purpose**: Comprehensive API testing with gradual ramp-up to simulate realistic load patterns

**Configuration**:
- Ramp-up: 10 users (20s) → 10 users (40s) → 20 users (20s) → 20 users (40s) → 0 users (20s)
- Total Duration: ~2.5 minutes
- Thresholds:
  - 95% of requests < 500ms
  - Error rate < 10%

**Endpoints Tested**:
- GET `/posts` - List all posts
- GET `/posts/{id}` - Get single post (random ID)
- GET `/posts/{id}/comments` - Get post comments
- POST `/posts` - Create new post
- PUT `/posts/{id}` - Update post
- PATCH `/posts/{id}` - Partial update post
- DELETE `/posts/{id}` - Delete post
- GET `/users` - List all users
- GET `/todos` - List all todos
- GET `/albums` - List all albums

**Use Case**: Regular performance testing to ensure API handles normal traffic patterns with acceptable response times.

### 3. Stress Test (`stress-test.ts`)
**Purpose**: Push the system to its limits to identify breaking points

**Configuration**:
- Ramp-up: 10 users → 50 users → 100 users → 150 users → 0 users
- Duration: ~2.5 minutes
- Thresholds:
  - 95% of requests < 2000ms
  - Error rate < 30%

**Use Case**: Determine maximum capacity and identify performance degradation points.

### 4. Spike Test (`spike-test.ts`)
**Purpose**: Test sudden traffic surges to verify system resilience

**Configuration**:
- Pattern: 5 users → sudden spike to 150 users → back to 5 users
- Duration: ~1.5 minutes
- Thresholds:
  - 95% of requests < 3000ms
  - Error rate < 40%

**Use Case**: Verify the API can handle sudden traffic spikes (e.g., viral content, marketing campaigns).

### 5. Soak Test (`soak-test.ts`)
**Purpose**: Extended duration test to identify memory leaks and performance degradation over time

**Configuration**:
- Virtual Users: 20 (constant)
- Duration: 30 minutes
- Thresholds:
  - 95% of requests < 1000ms
  - Error rate < 10%

**Use Case**: Long-running test to ensure system stability and detect issues like memory leaks or resource exhaustion.

## Running Tests

### Prerequisites

1. **Install k6**: Follow the [k6 installation guide](https://k6.io/docs/getting-started/installation/)
2. **Install Node.js dependencies**: Run `npm install` from the project root

### Build Tests

All TypeScript files must be compiled to JavaScript before running with k6:

```bash
# From project root
npm run build
```

This compiles all `.ts` files in the `k6/` folder to JavaScript in the `dist/` folder using webpack.

### Run Individual Tests

After building, run any test scenario:

```bash
# Smoke test (30s)
npm run test:smoke

# Load test (~2.5min)
npm run test:load

# Stress test (~2.5min)
npm run test:stress

# Spike test (~1.5min)
npm run test:spike

# Soak test (30min)
npm run test:soak
```

Or run k6 directly:

```bash
k6 run dist/smoke-test.js
k6 run dist/jsonplaceholder-load-test.js
k6 run dist/stress-test.js
k6 run dist/spike-test.js
k6 run dist/soak-test.js
```

### Watch Mode

For development, automatically rebuild on file changes:

```bash
npm run build:watch
```

## Test Structure

Each test file follows this structure:

```typescript
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Options } from 'k6/options';

// Test configuration (VUs, duration, thresholds)
export const options: Options = {
  vus: 1,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<1000'],
    http_req_failed: ['rate<0.01'],
  },
};

// Main test function - executed by each VU
export default function (): void {
  // Make HTTP requests
  const response = http.get('https://jsonplaceholder.typicode.com/posts');

  // Verify responses
  check(response, {
    'status is 200': (r) => r.status === 200,
  });

  // Pause between iterations
  sleep(1);
}
```

## TypeScript Benefits

- **Type Safety**: Catch errors at compile-time with k6 type definitions
- **IntelliSense**: Full IDE autocomplete support for k6 APIs
- **Interfaces**: Typed API response models (Post, User, Comment, etc.)
- **Maintainability**: Easier refactoring and code organization
- **Documentation**: Self-documenting code with type annotations

## Metrics

k6 automatically collects these metrics:

- **http_req_duration**: Request duration (latency)
- **http_req_failed**: Rate of failed requests
- **http_reqs**: Total number of HTTP requests
- **iterations**: Number of test iterations completed
- **vus**: Current number of active virtual users

Custom metrics in load test:
- **errors**: Custom error rate tracking

## Thresholds

Thresholds define pass/fail criteria for tests:

```typescript
thresholds: {
  http_req_duration: ['p(95)<500'],  // 95th percentile < 500ms
  http_req_failed: ['rate<0.1'],     // Error rate < 10%
}
```

If thresholds are exceeded, k6 exits with a non-zero status code, failing CI/CD pipelines.

## API Endpoints Tested

All tests target the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/):

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/posts` | GET | Get all posts (100 items) |
| `/posts/{id}` | GET | Get single post by ID |
| `/posts/{id}/comments` | GET | Get comments for a post |
| `/posts` | POST | Create a new post |
| `/posts/{id}` | PUT | Update a post (replace) |
| `/posts/{id}` | PATCH | Partially update a post |
| `/posts/{id}` | DELETE | Delete a post |
| `/users` | GET | Get all users |
| `/todos` | GET | Get all todos |
| `/albums` | GET | Get all albums |

## CI/CD Integration

The smoke test is integrated into the GitHub Actions CI pipeline:

```yaml
- name: Run smoke test
  run: k6 run dist/smoke-test.js
```

This provides fast feedback on API health with every commit.

## Further Reading

- [k6 Documentation](https://k6.io/docs/)
- [k6 TypeScript Guide](https://k6.io/docs/using-k6/test-authoring/typescript/)
- [k6 Thresholds](https://k6.io/docs/using-k6/thresholds/)
- [k6 Metrics](https://k6.io/docs/using-k6/metrics/)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
