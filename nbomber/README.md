# NBomber Performance Tests

This folder contains NBomber performance tests for the JSONPlaceholder API, written in C#.

## Prerequisites

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download) or later
- NBomber and NBomber.Http packages (installed via NuGet)

## Setup

Restore dependencies:

```bash
cd nbomber
dotnet restore
```

## Building Tests

Build the project:

```bash
dotnet build
```

## Running Tests

Run different test scenarios:

### Smoke Test
Quick validation with minimal load (1 client, 30s):
```bash
dotnet run --scenario smoke
```

### Load Test
Comprehensive API testing with gradual ramp-up (10-50 clients):
```bash
dotnet run --scenario load
```

### Stress Test
Push the system to its limits (50-150 clients):
```bash
dotnet run --scenario stress
```

### Spike Test
Test sudden traffic surges (5-150 clients):
```bash
dotnet run --scenario spike
```

### Soak Test
Extended duration test for memory leaks and degradation (20 clients, 30min):
```bash
dotnet run --scenario soak
```

## Test Files

- `Program.cs` - Main entry point and scenario definitions
- `SmokeTest.cs` - Basic health check scenario
- `LoadTest.cs` - Comprehensive load test scenario
- `StressTest.cs` - High load stress test scenario
- `SpikeTest.cs` - Sudden traffic spike test scenario
- `SoakTest.cs` - Extended duration test scenario

## Project Structure

```
nbomber/
├── NBomberTests.csproj    # Project file with dependencies
├── Program.cs             # Main entry point
├── SmokeTest.cs          # Smoke test scenario
├── LoadTest.cs           # Load test scenario
├── StressTest.cs         # Stress test scenario
├── SpikeTest.cs          # Spike test scenario
├── SoakTest.cs           # Soak test scenario
└── README.md             # This file
```

## NBomber Benefits

- Native .NET integration
- Built-in support for HTTP, WebSockets, and custom protocols
- Real-time reporting and monitoring
- Easy scenario composition
- Comprehensive metrics and statistics
- Built-in support for distributed load testing
- Plugin system for extending functionality

## Reports

After running tests, NBomber generates HTML reports in the `reports/` directory with detailed statistics and charts.
