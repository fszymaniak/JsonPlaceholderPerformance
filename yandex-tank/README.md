# Yandex.Tank Performance Tests

Powerful load testing tool from Yandex with multiple load generators support (Phantom, JMeter, BFG).

## Installation
```bash
pip install yandextank
```

## Features
- Multiple load generators
- Real-time monitoring
- Yandex.Overload integration
- Complex scenarios
- Plugins ecosystem

## Running Tests
```bash
yandex-tank -c smoke-test.yaml
yandex-tank -c load-test.yaml
```

## Configuration
YAML-based configuration with support for:
- HTTP/HTTPS
- Autostop conditions
- Monitoring
- Custom plugins
