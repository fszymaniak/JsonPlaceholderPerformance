# Quick Start Guide

## 🚀 Get Running in 3 Steps

### Step 1: Install k6
```bash
# macOS
brew install k6

# Linux (Debian/Ubuntu)
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6

# Windows
choco install k6
```

### Step 2: Run Your First Test
```bash
# Quick smoke test (30 seconds)
k6 run smoke-test.js
```

### Step 3: Run Full Test Suite
```bash
# Automated - runs all tests
./run-all-tests.sh

# Or manual
k6 run jsonplaceholder-load-test.js
```

## 📊 What to Look For

### Good Results ✅
```
✓ http_req_duration..............: avg=234ms p(95)=389ms
✓ http_req_failed................: 0.00%
```

### Bad Results ❌
```
✗ http_req_duration..............: avg=2.3s p(95)=5.2s
✗ http_req_failed................: 15.2%
```

## 🎯 Test Types Cheat Sheet

| Test File | Duration | Purpose | When to Use |
|-----------|----------|---------|-------------|
| smoke-test.js | 30s | Quick validation | Before deploying, in CI/CD |
| jsonplaceholder-load-test.js | 4m | Normal load | Regular performance checks |
| spike-test.js | 5m | Sudden traffic | Before marketing campaigns |
| stress-test.js | 10m | Find limits | Capacity planning |
| soak-test.js | 34m | Long stability | Before major releases |

## 💡 Common Commands

```bash
# Run with custom VUs
k6 run --vus 50 smoke-test.js

# Run for custom duration  
k6 run --duration 5m smoke-test.js

# Save results to file
k6 run --out json=results.json smoke-test.js

# Run quietly (less output)
k6 run --quiet smoke-test.js

# Run all tests automatically
./run-all-tests.sh
```

## ⚠️ Important Notes

- JSONPlaceholder is a **fake API** - POST/PUT/DELETE don't actually change data
- It's a **shared public resource** - be respectful with load levels
- Results vary based on network conditions
- Don't run extreme load (1000+ VUs) on this free API

## 🆘 Troubleshooting

**Problem**: `k6: command not found`
- **Solution**: Install k6 (see Step 1 above)

**Problem**: High error rates
- **Solution**: Reduce VUs or add longer sleep times

**Problem**: Tests fail thresholds
- **Solution**: This is expected! It shows where performance issues exist

**Problem**: Connection timeouts
- **Solution**: Check internet connection, try reducing VUs

## 📈 Next Steps

1. Start with smoke test
2. Review the results
3. Run load test for detailed analysis
4. Customize tests for your needs
5. Integrate into CI/CD pipeline

For detailed information, see README.md
