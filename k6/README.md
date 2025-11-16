# JSONPlaceholder API - k6 Performance Test Suite

Comprehensive performance test suite for JSONPlaceholder API (https://jsonplaceholder.typicode.com) using k6.

## 📋 Test Files Overview

### 1. **jsonplaceholder-load-test.js** - Comprehensive Load Test
- **Purpose**: Main test suite covering all CRUD operations
- **Duration**: ~4 minutes
- **VUs**: Ramps from 10 → 20 users
- **Tests Coverage**:
  - GET all posts
  - GET single post
  - GET post comments
  - POST create post
  - PUT update post
  - PATCH partial update
  - DELETE post
  - GET users, todos, albums

### 2. **smoke-test.js** - Smoke Test
- **Purpose**: Quick validation that API is working
- **Duration**: 30 seconds
- **VUs**: 1 user
- **Use Case**: Run before other tests, CI/CD pipeline validation
- **Tests**: Basic CRUD operations on posts endpoint

### 3. **stress-test.js** - Stress Test
- **Purpose**: Find the breaking point of the API
- **Duration**: ~10 minutes
- **VUs**: Ramps up to 150 users
- **Use Case**: Determine maximum capacity and identify bottlenecks

### 4. **spike-test.js** - Spike Test
- **Purpose**: Test response to sudden traffic increases
- **Duration**: ~5 minutes
- **VUs**: Sudden jumps from 5 → 100 → 150
- **Use Case**: Simulate flash sale, viral content scenarios

### 5. **soak-test.js** - Soak/Endurance Test
- **Purpose**: Check for memory leaks and degradation over time
- **Duration**: ~34 minutes (can be extended)
- **VUs**: Steady 20 users
- **Use Case**: Validate stability for production readiness

## 🚀 Prerequisites

Install k6:

**macOS:**
```bash
brew install k6
```

**Linux:**
```bash
sudo gpg -k
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6
```

**Windows:**
```powershell
choco install k6
```

Or download from: https://k6.io/docs/get-started/installation/

## 🏃 Running Tests

### Run Individual Tests

```bash
# Smoke Test (recommended first)
k6 run smoke-test.js

# Full Load Test
k6 run jsonplaceholder-load-test.js

# Stress Test
k6 run stress-test.js

# Spike Test
k6 run spike-test.js

# Soak Test (long duration)
k6 run soak-test.js
```

### Run with Custom Options

```bash
# Override VUs and duration
k6 run --vus 50 --duration 2m jsonplaceholder-load-test.js

# Run with specific stages
k6 run --stage 30s:10,1m:20,30s:0 smoke-test.js
```

### Save Results to File

```bash
# JSON output
k6 run --out json=results.json smoke-test.js

# CSV output
k6 run --out csv=results.csv smoke-test.js

# Multiple outputs
k6 run --out json=results.json --out csv=results.csv smoke-test.js
```

## 📊 Understanding Results

### Key Metrics

- **http_req_duration**: Time for complete request/response
  - `p(95)`: 95th percentile (95% of requests faster than this)
  - `p(99)`: 99th percentile
  - `avg`: Average response time
  - `max`: Maximum response time

- **http_req_failed**: Percentage of failed requests
- **http_reqs**: Total number of requests per second
- **vus**: Number of active virtual users
- **iterations**: Number of test iterations completed

### Thresholds

Each test has defined thresholds:
- ✅ **Green/Pass**: All thresholds met
- ❌ **Red/Fail**: One or more thresholds failed

Example output:
```
✓ http_req_duration..............: avg=234ms min=123ms med=210ms max=456ms p(95)=389ms
✓ http_req_failed................: 0.00%
✓ http_reqs......................: 1250 (25/s)
```

## 🎯 Test Recommendations

### Testing Strategy

1. **Start with Smoke Test**
   ```bash
   k6 run smoke-test.js
   ```
   Quick validation (30s) - Run first!

2. **Run Load Test**
   ```bash
   k6 run jsonplaceholder-load-test.js
   ```
   Normal conditions (4m) - Baseline performance

3. **Execute Stress Test**
   ```bash
   k6 run stress-test.js
   ```
   Find limits (10m) - Discover breaking points

4. **Perform Spike Test**
   ```bash
   k6 run spike-test.js
   ```
   Sudden traffic (5m) - Test elasticity

5. **Run Soak Test** (optional)
   ```bash
   k6 run soak-test.js
   ```
   Extended duration (30m+) - Find memory leaks

### CI/CD Integration

Example GitHub Actions workflow:
```yaml
- name: Run k6 smoke test
  run: k6 run --quiet smoke-test.js
  
- name: Run k6 load test
  run: k6 run --quiet jsonplaceholder-load-test.js
```

## 📈 Interpreting Results

### Good Performance Indicators
- ✅ `http_req_duration p(95) < 500ms`
- ✅ `http_req_failed < 1%`
- ✅ Consistent response times during load
- ✅ All checks passing

### Warning Signs
- ⚠️ Response times increasing over test duration
- ⚠️ High error rates (> 5%)
- ⚠️ `http_req_duration p(95) > 1000ms`
- ⚠️ Failed thresholds

### Critical Issues
- 🔴 Error rate > 10%
- 🔴 Response times > 3000ms
- 🔴 Increasing errors during soak test
- 🔴 System crashes or timeouts

## 🛠️ Customization

### Modify Load Pattern

Edit the `options.stages` in any test file:

```javascript
export const options = {
  stages: [
    { duration: '1m', target: 50 },  // Adjust duration and target
    { duration: '3m', target: 100 }, // Add/remove stages
  ],
};
```

### Adjust Thresholds

```javascript
thresholds: {
  http_req_duration: ['p(95)<300'],  // Stricter: 300ms
  http_req_failed: ['rate<0.05'],    // Max 5% errors
},
```

### Add Custom Metrics

```javascript
import { Counter, Trend } from 'k6/metrics';

const myCounter = new Counter('my_custom_counter');
const myTrend = new Trend('my_custom_trend');

// In test function
myCounter.add(1);
myTrend.add(response.timings.duration);
```

## 📝 Notes

- **JSONPlaceholder is a fake API**: POST/PUT/DELETE don't actually modify data
- **Shared resource**: Be respectful with load (don't run 1000+ VUs)
- **Rate limiting**: May encounter limits with very high load
- **Results may vary**: Public API performance depends on network and server load

## 🔗 Resources

- [k6 Documentation](https://k6.io/docs/)
- [JSONPlaceholder Guide](https://jsonplaceholder.typicode.com/guide/)
- [k6 Cloud](https://k6.io/cloud/) - For advanced analytics
- [Grafana Integration](https://k6.io/docs/results-output/real-time/grafana/)

## 📧 Support

For issues or questions:
- k6 Community: https://community.k6.io/
- JSONPlaceholder: https://github.com/typicode/jsonplaceholder
