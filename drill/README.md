# Drill Performance Tests

HTTP load testing application written in Rust with YAML configuration (Ansible-like syntax).

## Installation
```bash
cargo install drill
```

## Features
- YAML-based configuration
- Ansible-like syntax
- Rust performance
- Scenario support

## Running Tests
```bash
drill --benchmark smoke-test.yml
drill --benchmark load-test.yml --stats
```
