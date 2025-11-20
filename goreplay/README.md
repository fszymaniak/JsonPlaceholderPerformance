# GoReplay Traffic Replay

Network monitoring tool that can record live HTTP traffic and replay it for testing.

## Installation
```bash
# Download binary
wget https://github.com/buger/goreplay/releases/latest/download/gor_linux_amd64.tar.gz
tar xzf gor_linux_amd64.tar.gz
sudo mv gor /usr/local/bin/

# macOS
brew install goreplay
```

## Features
- Record production traffic
- Replay to test environment
- Traffic shadowing
- Rate limiting
- Filtering

## Usage Examples

### Record traffic
```bash
sudo gor --input-raw :8080 --output-file requests.gor
```

### Replay traffic
```bash
gor --input-file requests.gor --output-http "http://staging-server.com"
```

### Live traffic shadowing
```bash
sudo gor --input-raw :80 \
  --output-http "http://test-server.com|10" \
  --output-http-stats --output-http-timeout 5s
```

### Rate limiting
```bash
gor --input-file requests.gor \
  --output-http "http://test.com" \
  --output-http-rate-limit 100
```

## Use Cases
- Testing with real production patterns
- Performance testing with actual traffic
- Debugging production issues in safe environment
- A/B testing backends
- Load testing with realistic data

## Note
GoReplay is primarily for traffic replay rather than traditional load generation,
making it unique among load testing tools.
