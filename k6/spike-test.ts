import http from 'k6/http';
import { check, sleep } from 'k6';
import { Options } from 'k6/options';

// Spike Test Configuration - Sudden traffic surge
export const options: Options = {
  stages: [
    { duration: '20s', target: 5 },    // Low baseline
    { duration: '10s', target: 100 },  // Sudden spike!
    { duration: '40s', target: 100 },  // Maintain spike
    { duration: '10s', target: 5 },    // Drop back down
    { duration: '10s', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<3000'], // More relaxed for spike
    http_req_failed: ['rate<0.15'],    // Allow some failures during spike
  },
};

const BASE_URL = 'https://jsonplaceholder.typicode.com';

export default function (): void {
  // Test most common user flows during spike with minimal delays

  // 1. Browse posts (most common)
  let response = http.get(`${BASE_URL}/posts`);
  check(response, {
    'GET /posts status OK': (r) => r.status === 200,
  });
  sleep(0.2);

  // 2. View specific post
  const postId: number = Math.floor(Math.random() * 100) + 1;
  response = http.get(`${BASE_URL}/posts/${postId}`);
  check(response, {
    'GET /posts/:id status OK': (r) => r.status === 200,
  });
  sleep(0.2);

  // 3. Check comments
  response = http.get(`${BASE_URL}/posts/${postId}/comments`);
  check(response, {
    'GET comments status OK': (r) => r.status === 200,
  });
  sleep(0.2);
}
