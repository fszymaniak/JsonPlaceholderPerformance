import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate } from 'k6/metrics';
import { Options } from 'k6/options';

// Stress Test Configuration - Push system to its limits
export const options: Options = {
  stages: [
    { duration: '30s', target: 50 },  // Ramp up to 50 users
    { duration: '1m', target: 50 },   // Stay at 50 users
    { duration: '30s', target: 100 }, // Ramp up to 100 users
    { duration: '1m', target: 100 },  // Stay at 100 users
    { duration: '30s', target: 150 }, // Ramp up to 150 users
    { duration: '1m', target: 150 },  // Stay at 150 users
    { duration: '30s', target: 0 },   // Ramp down to 0
  ],
  thresholds: {
    http_req_duration: ['p(95)<2000'], // Relaxed threshold for stress test
    http_req_failed: ['rate<0.2'],     // Accept up to 20% errors under stress
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';
const errorRate = new Rate('stress_errors');

interface Endpoint {
  method: string;
  url: string;
}

export default function (): void {
  // Mix of different endpoints to create realistic stress
  const endpoints: Endpoint[] = [
    { method: 'GET', url: `${BASE_URL}/posts` },
    { method: 'GET', url: `${BASE_URL}/posts/${Math.floor(Math.random() * 100) + 1}` },
    { method: 'GET', url: `${BASE_URL}/comments` },
    { method: 'GET', url: `${BASE_URL}/users` },
    { method: 'GET', url: `${BASE_URL}/todos` },
  ];

  // Randomly select an endpoint
  const endpoint: Endpoint = endpoints[Math.floor(Math.random() * endpoints.length)];

  const response = http.get(endpoint.url);

  const success = check(response, {
    'status is 2xx': (r) => r.status >= 200 && r.status < 300,
  });

  errorRate.add(!success);

  // Shorter sleep for stress test
  sleep(Math.random() * 2);
}
